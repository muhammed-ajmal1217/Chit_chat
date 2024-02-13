import 'package:chitchat/controller/friend_suggestion_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/views/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsSuggestions extends StatefulWidget {
  const FriendsSuggestions({Key? key}) : super(key: key);

  @override
  State<FriendsSuggestions> createState() => _FriendsSuggestionsState();
}

class _FriendsSuggestionsState extends State<FriendsSuggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          'Suggestions for you',
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 40,
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
            ),
            spacingHeight(20),
            Consumer<FriendSuggestionProvider>(
              builder: (context, friendSuggestionPro, child) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      final personNumber = index + 1;
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: mainGradient(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfile(index: personNumber),
                                  ));
                                },
                                child: Hero(
                                  tag: personNumber,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/Designer.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'User $personNumber',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(height: 8.0),
                              InkWell(
                                onTap: () {
                                  friendSuggestionPro.isClickedon(index);
                                },
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: friendSuggestionPro.isClicked[index]
                                        ? Color(0xffFA7B06)
                                        : Color(0xff02B4BF),
                                  ),
                                  child: Center(
                                    child: Text(
                                      friendSuggestionPro.isClicked[index]
                                          ? 'Requested'
                                          : 'Add Friend',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
