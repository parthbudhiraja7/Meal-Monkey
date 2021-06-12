import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_monkey/Models/item.dart';
import 'package:meal_monkey/Widgets/ui_helper.dart';
import 'package:flutter/material.dart';

import 'menuList.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  Future<QuerySnapshot> docList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: searchWidget(),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: docList,
        builder: (context, snap) {
          return snap.hasData
              ? ListView.builder(
                  itemCount: snap.data.documents.length,
                  itemBuilder: (context, index) {
                    ItemModel model =
                        ItemModel.fromJson(snap.data.documents[index].data);
                    return sourceInfo(model, context);
                  },
                )
              : Center(child: Text(""));
        },
      ),
    );
  }

  Widget searchWidget() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      child: Container(
        width: MediaQuery.of(context).size.width - 40.0,
        height: 50.0,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            SizedBox(width: 8),
            Icon(
              Icons.search,
              color: Colors.black54,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value) {
                    startSearching(value);
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future startSearching(String query) async {
    docList = Firestore.instance
        .collection("Menu")
        .where("title", isGreaterThanOrEqualTo: query)
        .getDocuments();
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {},
    child: ListTile(
      dense: false,
      leading: ClipOval(
        child: Image.network(
          model.thumbnailUrl,
          height: 50.0,
          fit: BoxFit.cover,
          width: 50.0,
        ),
      ),
      title: Text(
        model.title.toString(),
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          letterSpacing: 1.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UIHelper.verticalSpaceExtraSmall(),
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
        ],
      ),
      trailing: Container(
        child: removeCartFunction == null
            ? IconButton(
                icon: Icon(
                  Icons.add_box_rounded,
                  color: Colors.black.withOpacity(0.7),
                ),
                onPressed: () {
                  checkItemInCart(model.shortInfo, context);
                },
              )
            : IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  removeCartFunction();
                },
              ),
      ),
    ),
  );
}
