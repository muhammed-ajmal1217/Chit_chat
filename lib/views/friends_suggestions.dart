import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class FriendsSuggestions extends StatefulWidget {


  FriendsSuggestions({Key? key, }) : super(key: key);

  @override
  State<FriendsSuggestions> createState() => _FriendsSuggestionsState();
}

class _FriendsSuggestionsState extends State<FriendsSuggestions> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).updateUserName();
  }
  AuthenticationService service = AuthenticationService();
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
        color:  Color.fromARGB(255, 19, 25, 35),
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
                child: Consumer2<FriendshipProvider, FirebaseProvider>(
                  builder: (context, pro, pro1, child) {
                    final filteredUsers = pro1.users.where((user) =>
                        user.userId !=
                        service.authentication.currentUser!.uid).toList();
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final userDetails = filteredUsers[index];
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 33, 43, 61)
                                .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       UserProfile(index: personNumber),
                                    // ));
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
                                          image:userDetails.profilePicture!=null? NetworkImage(userDetails.profilePicture??''):NetworkImage(UserIcon.proFileIcon)
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
                                  onTap: ()async {
                                    final profilePro=Provider.of<ProfileProvider>(context,listen: false);
                                    print("'Reciever User : ${userDetails.userName}");
                                    print('Current User : ${profilePro.userName}');
                                    await pro.sendFriendRequest(
                                        userData: userDetails,
                                        userName:profilePro.userName,
                                        profilePic: profilePro.profileUrl
                                        );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:Colors.orange,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add Friend',
                                        style: GoogleFonts.raleway(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
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
}

