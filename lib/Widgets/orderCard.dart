import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Models/item.dart';
import 'package:meal_monkey/Orders/OrderDetailsPage.dart';
import 'package:meal_monkey/Store/menuList.dart';
import 'package:meal_monkey/Widgets/ui_helper.dart';
import 'package:flutter/material.dart';

int counter = 0;

class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  OrderCard({Key key, this.data, this.itemCount, this.orderID})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (counter == 0) {
        //   counter = counter + 1;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetails(orderID: orderID)));
      },
      // },
      child: Container(
        // padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        height: itemCount * 90.0,
        child: ListView.builder(
          itemCount: itemCount,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c, index) {
            ItemModel model = ItemModel.fromJson(data[index].data);
            return sourceOrderInfo(model, context);
          },
        ),
      ),
    );
  }
}

Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    // height: 100.0,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              model.thumbnailUrl,
              height: 50.0,
              fit: BoxFit.cover,
              width: 50.0,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpaceExtraSmall(),
                Text(
                  model.shortInfo,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
                UIHelper.verticalSpaceExtraSmall(),
                Text(
                  "Total Amount" + " ₹" + (model.price).toString(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.delivery_dining, color: Colors.green),
              SizedBox(width: 5),
              // Text(
              //   "Delivered",
              //   style: TextStyle(
              //     color: Colors.green,
              //     letterSpacing: 1.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // )
            ],
          )
        ],
      ),
    ),
  );
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            model.thumbnailUrl,
            height: 80.0,
            fit: BoxFit.cover,
            width: 80.0,
          ),
          SizedBox(width: 10),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green[800]),
                    ),
                    child: ClipOval(
                      child: Container(
                        height: 5.0,
                        width: 5.0,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    model.title.toString(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceExtraSmall(),
              Text(
                model.shortInfo.toString(),
                style: TextStyle(
                  letterSpacing: 1.0,
                ),
              ),
              UIHelper.verticalSpaceExtraSmall(),
              Text(
                "Rs " + model.price.toString(),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Container(
            child: removeCartFunction == null
                ? IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    onPressed: () {
                      checkItemInCart(model.shortInfo, context);
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.delete, color: Colors.red.shade400),
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
