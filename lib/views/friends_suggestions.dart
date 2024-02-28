import 'package:chitchat/controller/friend_suggestion_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                height: height * 0.05,
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
            spacingHeight(height * 0.020),
            Consumer<FriendSuggestionProvider>(
              builder: (context, friendSuggestionPro, child) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
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
                            color: Color.fromARGB(255, 41, 33, 53)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(25.0),
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
                                  child: Container(
                                    height: height * 0.085,
                                    width: height * 0.085,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/Designer (2).png'))),
                                  ),
                                ),
                              ),
                              spacingHeight(height * 0.01),
                              Text(
                                'User $personNumber',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: Colors.white),
                              ),
                              spacingHeight(height * 0.01),
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  height: height * 0.035,
                                  width: width * 0.3,
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
