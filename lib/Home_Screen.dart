import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

//Creating a class user to store the data;
class User {
  final String title;
  final String body;

  User({
    required this.title,
    required this.body,
  });
}

class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {


  Future<List<User>> getRequest() async {
    String url = "https://jsonplaceholder.typicode.com/posts";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    List<User> users = [];
    for (var singleUser in responseData) {
      User user = User(
          title: singleUser["title"].toString(),
          body: singleUser["body"].toString());
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink.shade900,
          title: Text(
            "Home Screen",
            style: GoogleFonts.prompt(fontSize: 22),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Data Loading Please Wait!",
                          style: TextStyle(),
                        ),
                        Text("Check your Network connection!"),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) => SingleChildScrollView(
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1, color: Colors.pink.shade900//                   <--- border width here
                                    ),
                                    color: Colors.blueGrey.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 3.7,
                                  width: MediaQuery.of(context).size.width / 1,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data[index].title,
                                          style: GoogleFonts.lora(
                                              fontSize: 17,
                                              color: Colors.red.shade900),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          snapshot.data[index].body,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          style: GoogleFonts.prompt(
                                              color: Colors.deepOrange.shade600,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              }
            },
          ),
        ),
      ),
    );
  }
}
//
