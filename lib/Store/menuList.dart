import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Counters/cartitemcounter.dart';
import 'package:meal_monkey/Models/item.dart';
import 'package:meal_monkey/Widgets/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

double width;

class AllItems extends StatefulWidget {
  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  List offers = [
    'assets/offers/offer_1.jpeg',
    'assets/offers/offer_2.jpeg',
    'assets/offers/offer_3.jpeg',
    'assets/offers/offer_4.jpeg',
    'assets/offers/offer_5.jpeg',
    'assets/offers/offer_6.jpeg',
    'assets/offers/offer_7.jpeg',
    'assets/offers/offer_8.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Menu",
          style: TextStyle(
            letterSpacing: 1.2,
            color: Colors.orange,
            fontWeight: FontWeight.w600,
          ),
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
      ),
      body: ListView(
        children: [
          // StreamBuilder<QuerySnapshot>(
          //   stream: Firestore.instance
          //       .collection("Menu")
          //       .orderBy("publishedData", descending: true)
          //       .snapshots(),
          //   builder: (context, dataSnapshot) {
          //     if (!dataSnapshot.hasData)
          //       return Center(child: CircularProgressIndicator());
          //     return ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: dataSnapshot.data.documents.length,
          //       itemBuilder: (context, index) {
          //         ItemModel model = ItemModel.fromJson(
          //             dataSnapshot.data.documents[index].data);
          //         return sourceInfo(model, context);
          //       },
          //     );
          //   },
          // ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("Menu")
                .orderBy("publishedData", descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              if (!dataSnapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return new StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 2,
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(
                    1,
                    index.isEven ? 1.2 : 1.2,
                  );
                },
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
                itemCount: dataSnapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ItemModel model = ItemModel.fromJson(
                      dataSnapshot.data.documents[index].data);
                  return sourceInfo(model, context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ProductPage(itemModel: model)));
    },
    child: Container(
      alignment: Alignment.center,
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
          SizedBox(height: 15),
          ClipOval(
            child: Image.network(
              model.thumbnailUrl,
              height: 100.0,
              fit: BoxFit.cover,
              width: 100.0,
            ),
          ),
          SizedBox(height: 10),
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
