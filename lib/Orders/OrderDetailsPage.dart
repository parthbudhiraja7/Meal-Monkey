import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Store/homebottom.dart';
import 'package:meal_monkey/Widgets/orderCard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

String getOrderId = "";

class OrderDetails extends StatelessWidget {
  final String orderID;
  OrderDetails({Key key, this.orderID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getOrderId = orderID;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: EcommerceApp.firestore
              .collection(EcommerceApp.collectionUser)
              .document(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userUID))
              .collection(EcommerceApp.collectionOrders)
              .document(orderID)
              .get(),
          builder: (c, snapshot) {
            Map dataMap;
            if (snapshot.hasData) {
              dataMap = snapshot.data.data;
            }
            return snapshot.hasData
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StatusBanner(
                          status: dataMap[EcommerceApp.isSuccess],
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 10),
                            child: Text(
                              "ORDERS DETAILS",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Total Amount - ₹ " +
                                  dataMap[EcommerceApp.totalAmount].toString(),
                              style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "PickUp Time - " +
                                  dataMap[EcommerceApp.orderRecievingTime]
                                      .toString(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "PickUp Date - " +
                                  dataMap[EcommerceApp.orderRecievingDate]
                                      .toString(),
                            ),
                          ),
                        ),
                        Divider(height: 2.0),
                        SizedBox(height: 10.0),
                        FutureBuilder<QuerySnapshot>(
                          future: EcommerceApp.firestore
                              .collection("Menu")
                              .where("shortInfo",
                                  whereIn: dataMap[EcommerceApp.productID])
                              .getDocuments(),
                          builder: (c, dataSnapshot) {
                            return dataSnapshot.hasData
                                ? OrderCard(
                                    itemCount:
                                        dataSnapshot.data.documents.length,
                                    data: dataSnapshot.data.documents,
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Order ID : " + getOrderId),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text("Ordered At : " +
                              DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(dataMap['orderTime'])))),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class StatusBanner extends StatelessWidget {
  final bool status;
  StatusBanner({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;
    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Successfully" : msg = "Unsuccessfully";
    return Container(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20.0),
          Text(
            "Order Placed " + msg,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10.0),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 8.0,
            child: Center(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

confirmParcelShifted(BuildContext context, String mOrderId) {
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection(EcommerceApp.collectionOrders)
      .document(mOrderId)
      .delete();

  getOrderId = "";
  Route route = MaterialPageRoute(builder: (c) => HomeBottom());
  Navigator.push(context, route);

  Fluttertoast.showToast(msg: "Order has been received.Confirmed");
}
