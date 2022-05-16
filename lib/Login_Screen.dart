import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home_Screen.dart';

class Login_Page extends StatefulWidget {
  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController user_name = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  void initState() {
    user_name = TextEditingController();
    password = TextEditingController();

    super.initState();
  }

  Widget _builduserName() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: TextField(
          controller: user_name,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: "Enter User Name",
            prefixIcon: Icon(FontAwesomeIcons.user),

            // prefix:Icon(FontAwesomeIcons.facebook,color: Colors.black,),
          ),
        ),
      ),
    );
  }

  Widget _buildpassword() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: TextField(
          controller: password,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: "Enter Password",
            prefixIcon: Icon(FontAwesomeIcons.lock),
            // suffixIcon: IconButton(
            //   icon: Icon(Icons.clear), onPressed: () {
            // },),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade900,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.2,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/key.png'),
                    ),
                    Text(
                      "Login",
                      style: GoogleFonts.notoSerif(
                          fontSize: 45, color: Colors.pink.shade900),
                    )
                  ],
                ),

                _builduserName(),
                _buildpassword(),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text(
                    'Login',
                    style: (TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    if (user_name.text == password.text) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home_Screen()));

                      setState(() {
                        user_name.clear();
                        password.clear();
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Invalid Credentials'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.pink.shade900,
                      padding:
                          EdgeInsets.symmetric(horizontal: 115, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: Text(
                    'Clear',
                    style: (TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    user_name.clear();
                    password.clear();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.grey,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
