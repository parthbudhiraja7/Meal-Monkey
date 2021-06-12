import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Authentication/login.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Counters/ItemQuantity.dart';
import 'package:meal_monkey/Counters/cartitemcounter.dart';
import 'package:meal_monkey/Counters/changeAddresss.dart';
import 'package:meal_monkey/Counters/totalMoney.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
        title: 'e-Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange.shade300,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: Stack(children: [
        Column(
          children: [
            Container(
              color: Colors.orange.shade200,
              height: MediaQuery.of(context).size.height * 0.53,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(right: 40, top: 20, bottom: 20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/path.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 40),
                  // SizedBox(
                  //   height: 300,
                  //   width: 300,
                  //   child: Lottie.asset(
                  //     'assets/monkey.json',
                  //   ),
                  // ),
                  SizedBox(height: 50),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Get Your Food",
                          style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.2,
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delivered ",
                              style: TextStyle(
                                letterSpacing: 1.2,
                                fontSize: 30,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Fast",
                              style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 1.2,
                                color: Colors.red.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Our job is to fill your tummy with\ndelicious food and fast delivey",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 60.0,
                      width: 200,
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: Colors.transparent,
                        color: Colors.red.withOpacity(0.8),
                        elevation: 7.0,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          },
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 2.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "In partnership with PIET".toUpperCase(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
