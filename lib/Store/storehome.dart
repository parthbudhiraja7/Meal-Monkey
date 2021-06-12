import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Counters/cartitemcounter.dart';
import 'package:meal_monkey/Store/cart.dart';
import 'package:meal_monkey/Store/menuList.dart';
import 'package:meal_monkey/Widgets/custom_divider_view.dart';
import 'package:meal_monkey/Widgets/myDrawer.dart';
import 'package:meal_monkey/Widgets/offersListItem.dart';
import 'package:meal_monkey/Widgets/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  List offers = [
    'assets/offers/offer_1.jpeg',
    'assets/offers/offer_2.jpeg',
    'assets/offers/offer_3.jpeg',
    'assets/offers/offer_4.jpeg',
    'assets/offers/offer_5.jpeg',
    'assets/offers/offer_7.jpeg',
    'assets/offers/offer_8.jpeg',
  ];

  List swiper = [
    'assets/offers/o1.jpg',
    'assets/offers/o2.jpg',
    'assets/offers/o3.jpg',
    'assets/offers/o4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
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
        centerTitle: true,
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black.withOpacity(0.7),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
              Positioned(
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.brightness_1,
                      color: Colors.orange,
                      size: 20.0,
                    ),
                    Positioned(
                      left: 7.0,
                      top: 4.0,
                      bottom: 4.0,
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, _) {
                          return Text(
                            (EcommerceApp.sharedPreferences
                                        .getStringList(
                                            EcommerceApp.userCartList)
                                        .length -
                                    1)
                                .toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
        leading: IconButton(
          icon: Image.asset(
            "assets/images/menu.png",
            color: Colors.black.withOpacity(0.7),
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Container(
            height: 192,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 15),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (_, index) =>
                  offersListItem(imageUrl: offers[index]),
              separatorBuilder: (_, index) => Container(width: 5),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "The Fastest in",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.2,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Delivery ",
                            style: TextStyle(
                              letterSpacing: 1.2,
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Food",
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1.2,
                              color: Colors.red.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Image.asset('assets/images/delivery-man.png'),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          CustomDividerView(),
          Container(
            height: 230.0,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpaceMedium(),
                _buildPopularHeader(context),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('AdminUsers')
                      .orderBy(
                        "timestamp",
                        descending: false,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             RestaurantPage()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(right: 15.0, left: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.2),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/logo/piet.jpg",
                                        height: 80.0,
                                        width: 80.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceSmall(),
                                  Text(
                                    snapshot.data.documents[index]['username']
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.65),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  UIHelper.verticalSpace(2.0),
                                  Text(
                                    snapshot.data.documents[index]
                                        ['profileName'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            color: Colors.grey, fontSize: 13.0),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CustomDividerView(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            height: 180.0,
            child: Swiper(
              itemHeight: 100,
              duration: 500,
              itemWidth: MediaQuery.of(context).size.width,
              pagination: SwiperPagination(
                alignment: Alignment.bottomLeft,
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Colors.black.withOpacity(0.7),
                    size: 5.0,
                    activeSize: 10.0),
              ),
              itemCount: swiper.length,
              itemBuilder: (BuildContext context, int index) => ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  swiper[index],
                  fit: BoxFit.cover,
                ),
              ),
              autoplay: true,
              viewportFraction: 1.0,
              scale: 0.9,
            ),
          ),
          UIHelper.verticalSpaceMedium(),
          CustomDividerView(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.security,
                            color: Colors.black.withOpacity(0.7),
                          ),
                          UIHelper.horizontalSpaceExtraSmall(),
                          Text(
                            'Menu',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllItems()));
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'SEE ALL',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(fontSize: 16.0),
                                ),
                                UIHelper.horizontalSpaceExtraSmall(),
                                ClipOval(
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.orange[900],
                                    height: 20.0,
                                    width: 20.0,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      UIHelper.verticalSpaceExtraSmall(),
                      Text(
                        'With Best Safety Standards',
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMedium(),
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("Menu")
                        .limit(6)
                        .orderBy("publishedData", descending: true)
                        .snapshots(),
                    builder: (context, dataSnapshot) {
                      if (!dataSnapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dataSnapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.all(15.0),
            height: 400.0,
            color: Colors.grey[200],
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'LIVE\nFOR\nFOOD',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.grey[400],
                            fontSize: 80.0,
                            letterSpacing: 0.2,
                            height: 0.8,
                          ),
                    ),
                    UIHelper.verticalSpaceLarge(),
                    Text(
                      'MADE FOR FOOD LOVERS',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                    ),
                    Text(
                      'BY PARTH BUDHIRAJA',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                    ),
                    UIHelper.verticalSpaceExtraLarge(),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  left: 140.0,
                  top: 90.0,
                  child: Image.asset(
                    'assets/images/burger.png',
                    height: 80.0,
                    width: 80.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ProductPage(itemModel: model)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Text(
              model.title.toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            ClipOval(
              child: Image.network(
                model.thumbnailUrl,
                height: 100.0,
                fit: BoxFit.cover,
                width: 100.0,
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Text(
              model.shortInfo.toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 0.5,
              ),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(
              "₹ " + model.price.toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Container(
              child: removeCartFunction == null
                  ? Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                      ),
                      child: TextButton(
                        onPressed: () {
                          checkItemInCart(model.shortInfo, context);
                        },
                        child: Text(
                          'ADD',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        removeCartFunction();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPopularHeader(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Popular Brands',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(
              'Most ordered from around your locality',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
    height: 150.0,
    width: width * 0.34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            offset: Offset(0, 5), blurRadius: 10.0, color: Colors.grey[200]),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.network(
        imgPath,
        height: 150.0,
        width: width * 0.34,
        fit: BoxFit.fill,
      ),
    ),
  );
}

void checkItemInCart(String shortInfoAsID, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(shortInfoAsID)
      ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Item already in the cart".toUpperCase(),
            textAlign: TextAlign.center,
          ),
        ))
      : addItemToCart(shortInfoAsID, context);
}

addItemToCart(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(shortInfoAsID);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: tempCartList,
  }).then((v) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Item Added To Cart".toUpperCase(),
        textAlign: TextAlign.center,
      ),
    ));
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
