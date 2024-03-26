import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/friend_suggestion_provider.dart';
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/views/user_profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsSuggestions extends StatefulWidget {
  FriendsSuggestions({Key? key}) : super(key: key);

  @override
  State<FriendsSuggestions> createState() => _FriendsSuggestionsState();
}

class _FriendsSuggestionsState extends State<FriendsSuggestions> {
  late List<UserModel> filteredUsers = [];
  late AuthenticationService service;

  @override
  void initState() {
    super.initState();
    service = AuthenticationService();
    loadFilteredUsers();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 19, 25, 35),
        title: Text(
          'Suggestions for you',
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 19, 25, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Consumer<FriendshipProvider>(
                  builder: (context, provider, child) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: provider.filteredUsers.length,
                      itemBuilder: (context, index) {
                        final userDetails = provider.filteredUsers[index];
                        return buildUserTile(userDetails, provider);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserTile(UserModel userDetails, FriendshipProvider provider) {
    final height = MediaQuery.of(context).size.height;
    final isAccepted = provider.isFriendAccepted;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 33, 43, 61).withOpacity(0.5),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 44, 56, 80).withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfile(
                          user: userDetails,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: userDetails,
                    child: Container(
                      height: height * 0.085,
                      width: height * 0.085,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 40, 49, 62),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: userDetails.profilePicture != null
                              ? NetworkImage(userDetails.profilePicture ?? '')
                              : NetworkImage(UserIcon.proFileIcon),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  ' ${userDetails.userName}',
                  style: GoogleFonts.raleway(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.01),
                InkWell(
                  onTap: () async {
                    final profilePro =
                        Provider.of<ProfileProvider>(context, listen: false);
                    print("'Receiver User : ${userDetails.userName}");
                    print('Current User : ${profilePro.userName}');
                    if (userDetails.isRequested == null ||
                        userDetails.isRequested == false) {
                      await provider.sendFriendRequest(
                        userData: userDetails,
                        userName: profilePro.userName,
                        profilePic: profilePro.profileUrl,
                      );
                    } else {
                      await provider.deleteSentFriendRequest(userDetails);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: (userDetails.isRequested == null ||
                              userDetails.isRequested == false)
                          ? Colors.orange
                          : Color.fromARGB(255, 40, 54, 75).withOpacity(0.7),
                    ),
                    child: Center(
                      child: (userDetails.isRequested == null ||
                              userDetails.isRequested == false)
                          ? Text(
                              'Add Friend',
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Added',
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void loadFilteredUsers() {
    final pro1 = Provider.of<FirebaseProvider>(context, listen: false);
    final provider = Provider.of<FriendshipProvider>(context, listen: false);
    provider.filteredUsers = pro1.users
        .where((user) => user.userId != service.authentication.currentUser!.uid)
        .toList();
    provider.loadRequestedStatus();
  }
}
