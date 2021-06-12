import 'package:meal_monkey/Authentication/login.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Orders/myOrders.dart';
import 'package:meal_monkey/Widgets/ui_helper.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "WELCOME " +
                      EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userName)
                          .toUpperCase(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userEmail),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                height: 2,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0)), //this right here
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Meal",
                                              style: TextStyle(
                                                letterSpacing: 1.2,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Monkey",
                                              style: TextStyle(
                                                letterSpacing: 1.2,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "By Parth Budhiraja",
                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Wanna eat fresh & heathy?\n"
                                              "\nOrder your favourite food Now& pickup your food in 15 mins"
                                          .toUpperCase(),
                                      style: TextStyle(
                                        letterSpacing: 1.2,
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03),
                      padding: EdgeInsets.all(20.0 / 2),
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F8FD),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 5,
                            offset: Offset(-5, -5),
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.info_outline,
                          size: 25,
                          color: Colors.red.shade200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0)), //this right here
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Meal",
                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Monkey",
                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "By Parth Budhiraja",
                                      style: TextStyle(
                                        letterSpacing: 1.2,
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email,
                                        color: Colors.black.withOpacity(0.7)),
                                    SizedBox(width: 5),
                                    Text(
                                      "mealMonkey@piet.co.in",
                                      style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Help",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 18,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "FAQs & Links",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 15,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyOrders()));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Past Orders",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 18,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Delicious Food you ordered",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 15,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  EcommerceApp.auth.signOut().then((c) {
                    Route route = MaterialPageRoute(builder: (c) => Login());
                    Navigator.pushReplacement(context, route);
                  });
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, bottom: 10.0, right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LOGOUT",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpaceLarge(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Made By : Parth Budhiraja",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 15,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
