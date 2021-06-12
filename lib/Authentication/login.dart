import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meal_monkey/Authentication/register.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/DialogBox/errorDialog.dart';
import 'package:meal_monkey/Store/homebottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                            child: Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: 80.0,
                                color: Colors.black.withOpacity(0.8),
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(16.0, 140.0, 0.0, 0.0),
                            child: Text(
                              'There',
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20.0),
                      child: TextFormField(
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
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20.0),
                      child: TextFormField(
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
                      alignment: Alignment(1.0, 0.0),
                      padding:
                          EdgeInsets.only(top: 30.0, left: 20.0, right: 20),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  color: Colors.white,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 20, left: 20, right: 20.0),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              _email = value;
                                            });
                                          },
                                          validator: validateEmail,
                                          cursorColor:
                                              Theme.of(context).primaryColor,
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0, vertical: 30),
                                        child: Container(
                                          height: 50.0,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.orangeAccent,
                                            elevation: 7.0,
                                            child: TextButton(
                                              onPressed: () {
                                                _auth.sendPasswordResetEmail(
                                                    email: _email);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Email Has Been Sent."
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Send Request'.toUpperCase(),
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
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.orange.shade300,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    (Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          // shadowColor: Colors.redAccent.shade200,
                          color: Colors.orange.shade300,
                          elevation: 7.0,
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                login();
                              }
                            },
                            child: Center(
                              child: Text(
                                'LOGIN',
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
                    )),
                    SizedBox(height: 40.0),
                    (InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 16.0,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            'Register',
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 16.0,
                              color: Colors.orange.shade300,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    {
      _emailTextEditingController.text.isNotEmpty &&
              _passwordTextEditingController.text.isNotEmpty
          ? uploadToStorage()
          : displayDialog("Please Fill the details");
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
          return Center(
            child: SpinKitPulse(
              color: Colors.orange.shade300,
            ),
          );
        });

    loginUser();
  }

  void loginUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
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
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => HomeBottom());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("users")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences
          .setString("uid", dataSnapshot.data[EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userEmail, dataSnapshot.data[EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userName, dataSnapshot.data[EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl,
          dataSnapshot.data[EcommerceApp.userAvatarUrl]);
      List<String> cartList =
          dataSnapshot.data[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, cartList);
    });
  }
}
