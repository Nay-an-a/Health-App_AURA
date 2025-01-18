import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Map<String, String> user;
  Profile({Key? key, required this.user}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 40, color: Colors.white54),
              radius: 50,
              // Set the size of the avatar
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.grey, // Line color
              thickness: 1, // Line thickness
              height: 20, // Vertical space around the divider
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 19 /*,fontWeight:FontWeight.bold*/,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 107),
              Text(": "),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  user['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.phone, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "Contact Number",
                    style: TextStyle(
                      fontSize: 19 /*,fontWeight:FontWeight.bold*/,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 17),
              Text(": "),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  user['phoneno']!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "Email Id",
                    style: TextStyle(
                      fontSize: 19 /*,fontWeight:FontWeight.bold*/,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 90),
              Text(":"),
              Expanded(child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  "${user['emailId']!}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
