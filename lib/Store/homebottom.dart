import 'package:meal_monkey/Store/account.dart';
import 'package:meal_monkey/Store/cart.dart';
import 'package:meal_monkey/Store/storehome.dart';
import 'package:flutter/material.dart';

import 'Search.dart';

class HomeBottom extends StatefulWidget {
  @override
  _HomeBottomState createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int _selectedIndex = 0;
  Widget _body;

  @override
  void initState() {
    super.initState();

    this._body = StoreHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _body,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Seach',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ACCOUNT',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange.shade300,
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _setBodyLayout();
  }

  void _setBodyLayout() {
    switch (_selectedIndex) {
      case 0:
        setState(() => _body = StoreHome());
        break;

      case 1:
        setState(() => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SearchProduct())));

        break;

      case 2:
        setState(() => _body = CartScreen());
        break;

      case 3:
        setState(() => _body = AccountScreen());
        break;
    }
  }
}
