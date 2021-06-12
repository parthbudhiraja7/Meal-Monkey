import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:meal_monkey/Config/config.dart';
import 'package:meal_monkey/Counters/cartitemcounter.dart';
import 'package:meal_monkey/Counters/totalMoney.dart';
import 'package:meal_monkey/Store/homebottom.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DateTimeChoose extends StatefulWidget {
  final double totalAmount;
  const DateTimeChoose({Key key, this.totalAmount}) : super(key: key);
  @override
  _DateTimeChooseState createState() => _DateTimeChooseState();
}

class _DateTimeChooseState extends State<DateTimeChoose> {
  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSucsess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  //Payment
  Razorpay razorpay;

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_Bd0GrUdjsQ8xta',
      "amount": widget.totalAmount * 100,
      'name': 'Meal Monkey',
      "currency": "INR",
      'description': 'Payment',
      "offer_id": "offer_HEa0ZtDXNFeD3W",
      'prefill': {'Name': '', 'Contact': ''},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSucsess(PaymentSuccessResponse response) {
    addOrderDetails();
    // Fluttertoast.showToast(msg: "SUCCESS:" + response.paymentId);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Route route = MaterialPageRoute(builder: (c) => HomeBottom());
    Navigator.push(context, route);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "PAYMENT HAS BEEN FALIED",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL WALLET:" + response.walletName);
  }

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
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Date",
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Time",
              style: TextStyle(
                letterSpacing: 1.2,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 2.0,
        onPressed: () {
          openCheckout();
        },
        icon: Icon(Icons.account_balance),
        label: Text("MAKE PAYMENT"),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              child: Container(
                height: 120.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insert_emoticon, color: Colors.black),
                    SizedBox(height: 5),
                    Text(
                      "Choose Your Pickup Time",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Your Order Will Be Ready In 15 mins",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Choose Pickup Date",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Card(
                      color: Colors.grey[100],
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        onSaved: (String val) {
                          _setDate = val;
                        },
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18.0,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Choose Pickup Time',
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Card(
                    color: Colors.grey[100],
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addOrderDetails() {
    writeOrderDetailsForUser({
      EcommerceApp.totalAmount: widget.totalAmount,
      EcommerceApp.orderRecievingDate: _dateController.text,
      EcommerceApp.orderRecievingTime: _timeController.text,
      "orderBy": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID: EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList),
      // EcommerceApp.paymentDetails: "Cash On Delivery",
      EcommerceApp.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess: true
    });
    writeOrderDetailsForAdmin({
      EcommerceApp.totalAmount: widget.totalAmount,
      EcommerceApp.orderRecievingDate: _dateController.text,
      EcommerceApp.orderRecievingTime: _timeController.text,
      "orderBy": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID: EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList),
      // EcommerceApp.paymentDetails: "Cash On Delivery",
      EcommerceApp.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess: true,
    }).whenComplete(() => {emptyCartNow()});
  }

  emptyCartNow() {
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
    List tempList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    Firestore.instance
        .collection("users")
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempList,
    }).then((value) {
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Congratulations, your order has been placed",
        textAlign: TextAlign.center,
      ),
    ));
    Route route = MaterialPageRoute(builder: (c) => HomeBottom());
    Navigator.push(context, route);
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) +
                data['orderTime'])
        .setData(data);
  }

  Future writeOrderDetailsForAdmin(Map<String, dynamic> data) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionOrders)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) +
                data['orderTime'])
        .setData(data);
  }
}
