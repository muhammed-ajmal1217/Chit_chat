import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/model/request_model.dart';
import 'package:chitchat/views/drawer/drawer.dart';
import 'package:chitchat/views/friends_request_page/widgets/helpers_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsRequest extends StatelessWidget {
  FriendsRequest({Key? key, e});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 19, 25, 35),
      body: Consumer2<FriendshipProvider, ProfileProvider>(
        builder: (context, value, value1, child) {
          return StreamProvider<List<RequestModel>>(
            create: (_) => value.getRequest(),
            initialData: [],
            builder: (context, snapshot) {
              final requests = Provider.of<List<RequestModel>>(context);
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  RequestModel requestData = requests[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height * 0.09,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:  Color.fromARGB(255, 33, 43, 61)
                                .withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            '${requestData.senderName}',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          leading: GestureDetector(
                            onTap: () {},
                            child: Hero(
                              tag: index,
                              child: Container(
                                height: height * 0.065,
                                width: height * 0.065,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(requestData.profilePicture??''),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              requestAccept_Reject(Icons.check, height, () {}),
                              SizedBox(width: width * 0.03),
                              requestAccept_Reject(Icons.close, height, () {
                                final profilePro = Provider.of<ProfileProvider>(
                                    context,
                                    listen: false);
                                print(
                                    "'Sender User : ${requestData.senderName}");
                                print('Current User : ${profilePro.userName}');
                                Provider.of<FriendshipProvider>(context,
                                        listen: false)
                                    //requestData.senderId!,requestData.senderName!,profilePro.userName
                                    .acceptFriendRequest(
                                        userData: requestData,
                                        currentUserName: profilePro.userName,
                                        profilePic: profilePro.profileUrl
                                        );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
