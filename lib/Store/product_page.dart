// import 'package:meal_monkey/Models/item.dart';
// import 'package:flutter/material.dart';

// class ProductPage extends StatefulWidget {
//   final ItemModel itemModel;
//   ProductPage({this.itemModel});
//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   int quantityOfItem = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black.withOpacity(0.7),
//         ),
//         title: Text(
//           "Item Detail",
//           style: TextStyle(
//             letterSpacing: 1.2,
//             color: Colors.black.withOpacity(0.7),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             tooltip: "Info",
//             icon: Icon(
//               Icons.info_outline,
//               color: Colors.black.withOpacity(0.7),
//             ),
//             onPressed: () {},
//           )
//         ],
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(
//           Icons.delete,
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.red,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.network(
//               widget.itemModel.thumbnailUrl,
//               height: MediaQuery.of(context).size.height * 0.3,
//               fit: BoxFit.contain,
//               width: MediaQuery.of(context).size.width,
//             ),
//             SizedBox(height: 10),
//             Text(
//               widget.itemModel.title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 letterSpacing: 1.5,
//                 fontSize: 29,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               widget.itemModel.shortInfo,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 letterSpacing: 1.5,
//                 fontSize: 20,
//               ),
//             ),
//             SizedBox(height: 15),
//             Text(
//               "Rs " + widget.itemModel.price.toString(),
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 letterSpacing: 1.5,
//                 fontSize: 20,
//               ),
//             ),
//             SizedBox(height: 30),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 50.0),
//               height: 50,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(30.0),
//                 ),
//                 border: Border.all(
//                   color: Colors.green,
//                 ),
//               ),
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'UPDATE',
//                   style: TextStyle(
//                       letterSpacing: 1.5,
//                       color: Colors.white,
//                       // fontSize: 12,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
// const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
