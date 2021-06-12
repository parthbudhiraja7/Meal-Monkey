import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Store/dateTime.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Counters/cartitemcounter.dart';
import 'package:meal_monkey/Counters/totalMoney.dart';
import 'package:meal_monkey/Models/item.dart';
import 'package:meal_monkey/Store/homebottom.dart';
import 'package:meal_monkey/Widgets/loadingWidget.dart';
import 'package:meal_monkey/Widgets/orderCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double totalAmount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.7),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Your",
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Cart",
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        onPressed: () {
          if (EcommerceApp.sharedPreferences
                  .getStringList(EcommerceApp.userCartList)
                  .length ==
              1) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Add items to your cart".toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DateTimeChoose(totalAmount: totalAmount)));
          }
        },
        icon: Icon(Icons.date_range),
        label: Text("CHOOSE DATE/TIME"),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100]),
                  margin: EdgeInsets.only(bottom: 30, right: 20, left: 20),
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Text(
                    "Total Amount : ₹ ${amountProvider.totalAmount.toString()} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: EcommerceApp.firestore
                .collection("Menu")
                .where("shortInfo",
                    whereIn: EcommerceApp.sharedPreferences
                        .getStringList(EcommerceApp.userCartList))
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : snapshot.data.documents.length == 0
                      ? beginBuildingCart()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              ItemModel model = ItemModel.fromJson(
                                  snapshot.data.documents[index].data);
                              if (index == 0) {
                                totalAmount = 0;
                                totalAmount =
                                    model.price + totalAmount + totalAmount;
                              } else {
                                totalAmount = model.price + totalAmount;
                              }
                              if (snapshot.data.documents.length - 1 == index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((t) {
                                  Provider.of<TotalAmount>(context,
                                          listen: false)
                                      .display(totalAmount);
                                });
                              }
                              return sourceInfo(model, context,
                                  removeCartFunction: () =>
                                      removeItemFromUserCart(model.shortInfo));
                            },
                            childCount: snapshot.hasData
                                ? snapshot.data.documents.length
                                : 0,
                          ),
                        );
            },
          ),
        ],
      ),
    );
  }

  beginBuildingCart() {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon, color: Colors.black),
              Text("Cart is empty"),
              Text("Start adding items to your cart."),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId) {
    List tempCartList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(shortInfoAsId);

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempCartList,
    }).then((v) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.teal,
        content: Text(
          "Item Removed from your cart".toUpperCase(),
          textAlign: TextAlign.center,
        ),
      ));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeBottom()));
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
      totalAmount = 0;
    });
  }
}
