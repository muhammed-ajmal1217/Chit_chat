
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/model/request_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({
    Key? key,
  });

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  void initState() {
    super.initState();
    Provider.of<FriendshipProvider>(context, listen: false).getRequest();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<FriendshipProvider>(context);
    return Expanded(
      child: StreamBuilder<List<RequestModel>>(
        stream: provider.getFriends(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<RequestModel> friends = snapshot.data ?? [];
            if(friends.isEmpty){
              return Center(child: Text('There is no Requests',style: TextStyle(color: Colors.white),),);
            }else{
              return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                RequestModel requestData = friends[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height * 0.09,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 41, 33, 53).withOpacity(0.5),
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
                          style: GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                        ),
                        leading: GestureDetector(
                          onTap: () {
                            
                          },
                          child: Hero(
                            tag: index,
                            child: Container(
                              height: height * 0.065,
                              width: height * 0.065,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage('assets/Designer (2).png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                
                              },
                              child: Icon(
                                Icons.message,
                                color: Color.fromARGB(255, 10, 213, 189),
                              ),
                            ),
                            SizedBox(width: width * 0.06),
                            Icon(
                              Icons.remove_circle_outline,
                              color: Color.fromARGB(255, 244, 79, 54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
            }
          }
        },
      ),
    );
  }
}
