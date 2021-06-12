// import 'package:e_commerce/Config/config.dart';
// import 'package:e_commerce/Models/address.dart';
// import 'package:flutter/material.dart';

// class AddAddress extends StatelessWidget {
//   final formKey = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final cName = TextEditingController();
//   final cPhoneNumber = TextEditingController();
//   final cFlatHomeNumber = TextEditingController();
//   final cCity = TextEditingController();
//   final cState = TextEditingController();
//   final cPinCode = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       key: scaffoldKey,
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: true,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Add",
//               style: TextStyle(
//                 letterSpacing: 1.2,
//                 color: Colors.black.withOpacity(0.7),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 5),
//             Text(
//               "Address",
//               style: TextStyle(
//                 letterSpacing: 1.2,
//                 color: Colors.orange,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         elevation: 0.0,
//         onPressed: () {
//           if (formKey.currentState.validate()) {
//             final model = AddressModel(
//               name: cName.text.trim(),
//               state: cState.text.trim(),
//               pincode: cPinCode.text.trim(),
//               phoneNumber: cPhoneNumber.text.trim(),
//               flatNumber: cFlatHomeNumber.text.trim(),
//               city: cCity.text.trim(),
//             ).toJson();
//             EcommerceApp.firestore
//                 .collection(EcommerceApp.collectionUser)
//                 .document(EcommerceApp.sharedPreferences
//                     .getString(EcommerceApp.userUID))
//                 .collection(EcommerceApp.subCollectionAddress)
//                 .document(DateTime.now().toString())
//                 .setData(model)
//                 .then((value) {
//               final snack =
//                   SnackBar(content: Text("New Address Added Successfully"));
//               FocusScope.of(context).requestFocus(FocusNode());
//               ScaffoldMessenger.of(context).showSnackBar(snack);
//               formKey.currentState.reset();
//             });
//           }
//         },
//         label: Text("DONE"),
//         backgroundColor: Colors.green,
//         icon: Icon(Icons.done_all_outlined),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   MyTextField(
//                     hint: "Name",
//                     type: TextInputType.name,
//                     controller: cName,
//                   ),
//                   SizedBox(height: 5),
//                   MyTextField(
//                     hint: "Phone Number",
//                     type: TextInputType.number,
//                     controller: cPhoneNumber,
//                   ),
//                   SizedBox(height: 5),
//                   MyTextField(
//                     hint: "Flat Number",
//                     type: TextInputType.streetAddress,
//                     controller: cFlatHomeNumber,
//                   ),
//                   SizedBox(height: 5),
//                   MyTextField(
//                     hint: "City",
//                     type: TextInputType.text,
//                     controller: cCity,
//                   ),
//                   SizedBox(height: 5),
//                   MyTextField(
//                     hint: "State",
//                     type: TextInputType.text,
//                     controller: cState,
//                   ),
//                   SizedBox(height: 5),
//                   MyTextField(
//                     hint: "Pin Code",
//                     type: TextInputType.number,
//                     controller: cPinCode,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyTextField extends StatelessWidget {
//   final String hint;
//   final TextInputType type;
//   final TextEditingController controller;

//   MyTextField({
//     Key key,
//     this.type,
//     this.hint,
//     this.controller,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(
//           Radius.circular(10.0),
//         ),
//       ),
//       padding: EdgeInsets.only(top: 10, left: 20, right: 20.0),
//       child: TextFormField(
//           keyboardType: type,
//           decoration: InputDecoration(
//             labelStyle: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.black54,
//               letterSpacing: 2.0,
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.green,
//               ),
//             ),
//             labelText: hint,
//           ),
//           controller: controller,
//           validator: (val) => val.isEmpty ? "Field Cannot be empty" : null),
//     );
//   }
// }
