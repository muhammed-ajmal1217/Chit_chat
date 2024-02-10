import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isOn=true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: appBarGradient(),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/Designer.png'),
                    ),
                    spacingWidth(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'username@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
                spacingHeight(height*0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello i am new to Chitchat',style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),),
                              Icon(Icons.edit,color: Colors.white,)
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Terms & Conditions'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Notification'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Theme'),
            onTap: () {},
            trailing: Switch(
              value: false,
              onChanged: (value) {
                setState(() {
                  isOn=value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Log out'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Delete my Account'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
