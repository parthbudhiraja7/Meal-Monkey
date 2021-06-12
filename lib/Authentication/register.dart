import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/DialogBox/errorDialog.dart';
import 'package:meal_monkey/DialogBox/loadingDialog.dart';
import 'package:meal_monkey/Store/homebottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 80.0,
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 180.0, 0.0, 0.0),
                        child: Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 80.0,
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 10, left: 20, right: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Your Name";
                            } else {
                              return null;
                            }
                          },
                          controller: _nameTextEditingController,
                          obscureText: false,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                letterSpacing: 2.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              labelText: "NAME"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 10, left: 20, right: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Your Number";
                            } else if (value.length != 10) {
                              return "Please Check";
                            } else {
                              return null;
                            }
                          },
                          controller: _phoneTextEditingController,
                          obscureText: false,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                letterSpacing: 2.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              labelText: "PHONE NUMBER"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 10, left: 20, right: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          controller: _emailTextEditingController,
                          obscureText: false,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              letterSpacing: 2.0,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            labelText: "EMAIL",
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 10, left: 20, right: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Your Password";
                            } else {
                              return null;
                            }
                          },
                          controller: _passwordTextEditingController,
                          obscureText: true,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              letterSpacing: 2.0,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            labelText: "PASSWORD",
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 10, left: 20, right: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Re-enter Your Password";
                            } else if (_passwordTextEditingController ==
                                _cPasswordTextEditingController) {
                              return "Please Check";
                            } else {
                              return null;
                            }
                          },
                          controller: _cPasswordTextEditingController,
                          obscureText: true,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              letterSpacing: 2.0,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            labelText: "CONFIRM PASSWORD",
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 50.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            // shadowColor: Colors.greenAccent.shade200,
                            color: Colors.orange.shade300,
                            elevation: 7.0,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  uploadAndSaveImage();
                                }
                              },
                              child: Center(
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 50.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Center(
                                child: Text(
                                  'Go Back'.toUpperCase(),
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> uploadAndSaveImage() async {
    {
      _passwordTextEditingController.text ==
              _cPasswordTextEditingController.text
          ? _emailTextEditingController.text.isNotEmpty &&
                  _passwordTextEditingController.text.isNotEmpty &&
                  _cPasswordTextEditingController.text.isNotEmpty &&
                  _nameTextEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please Fill up the Form..")
          : displayDialog("Password doesnot match");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Registering, Please wait..",
          );
        });

    _registerUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.of(context);
        Route route = MaterialPageRoute(builder: (c) => HomeBottom());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "number": _phoneTextEditingController.text.trim(),
      "password": _passwordTextEditingController.text.trim(),
      "name": _nameTextEditingController.text.trim(),
      "registerationTime": DateTime.now(),
      EcommerceApp.userCartList: ["garbageValue"],
    });

    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userName, _nameTextEditingController.text.trim());
    // await EcommerceApp.sharedPreferences
    //     .setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatTime = new DateFormat('MMM d, hh:mm aaa');
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "email": _emailTextEditingController.text.trim(),
      "number": _phoneTextEditingController.text.trim(),
      "password": _passwordTextEditingController.text.trim(),
      "name": _nameTextEditingController.text.trim(),
      "Registeration Time": time,
    };
    ref.child("userDetails").push().set(data);
  }
}
