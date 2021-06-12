import 'package:meal_monkey/Authentication/login.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Orders/myOrders.dart';
import 'package:meal_monkey/Store/Search.dart';
import 'package:meal_monkey/Store/homebottom.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
            ),
            accountEmail: new Text(
              EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
            ),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userName)[0]),
            ),
          ),
          new ListTile(
            title: new Text("Home"),
            trailing: new Icon(Icons.home, color: Colors.black),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeBottom()))
                  .then((value) {
                Navigator.pop(context);
              });
            },
          ),
          new ListTile(
            title: new Text("Recent Orders"),
            trailing: new Icon(Icons.food_bank, color: Colors.black),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyOrders()))
                  .then((value) {
                Navigator.pop(context);
              });
            },
          ),
          new ListTile(
            title: new Text("Search"),
            trailing: new Icon(Icons.search, color: Colors.black),
            onTap: () async {
              Navigator.of(context)
                  .push(
                      MaterialPageRoute(builder: (context) => SearchProduct()))
                  .then((value) {
                Navigator.pop(context);
              });
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text("About The App"),
            trailing: new Icon(Icons.bubble_chart, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Meal",
                                      style: TextStyle(
                                        letterSpacing: 1.2,
                                        color: Colors.black.withOpacity(0.7),
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
          ),
          new ListTile(
            title: new Text("Contact Us"),
            trailing: new Icon(Icons.help, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Meal",
                                      style: TextStyle(
                                        letterSpacing: 1.2,
                                        color: Colors.black.withOpacity(0.7),
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
          ),
          new Divider(),
          new ListTile(
            title: new Text("Logout"),
            trailing: new Icon(Icons.arrow_forward, color: Colors.black),
            onTap: () {
              EcommerceApp.auth.signOut().then((c) {
                Route route = MaterialPageRoute(builder: (c) => Login());
                Navigator.pushReplacement(context, route);
              });
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            height: 100,
            child: Text(
              "Made By Parth Budhiraja",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
