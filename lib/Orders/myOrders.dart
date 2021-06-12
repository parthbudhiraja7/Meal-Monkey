import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Widgets/orderCard.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "My",
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Orders",
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
      body: StreamBuilder<QuerySnapshot>(
        stream: EcommerceApp.firestore
            .collection(EcommerceApp.collectionUser)
            .document(
                EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
            .collection(EcommerceApp.collectionOrders)
            .snapshots(),
        builder: (c, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (c, index) {
                    return FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection("Menu")
                          .where("shortInfo",
                              whereIn: snapshot.data.documents[index]
                                  [EcommerceApp.productID])
                          .getDocuments(),
                      builder: (c, snap) {
                        return snap.hasData
                            ? OrderCard(
                                itemCount: snap.data.documents.length,
                                data: snap.data.documents,
                                orderID:
                                    snapshot.data.documents[index].documentID,
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    );
                  },
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
