import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/story_view_mode.dart';
import 'package:chitchat/views/story_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryList extends StatelessWidget {
  const StoryList({
    super.key,
    required this.stories,
    required this.height,
    required this.personNumber,
  });

  final List<Story> stories;
  final double height;
  final int personNumber;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  StoryViewerPage(
                                      story: stories[
                                          index]),
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.17,
                          width: height * 0.13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius
                                    .circular(15),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              15),
                                  image: DecorationImage(
                                      fit: BoxFit
                                          .fill,
                                      image: AssetImage(
                                          'assets/Designer.png')))),
                        )),
                  ),
                  spacingHeight(height * 0.002),
                  Text(
                    'User ${personNumber + index}',
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: height * 0.016),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
