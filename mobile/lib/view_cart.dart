// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:nearbuy/sample.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
// void main() {
//   runApp(const ViewSlot());
// }
//
// class ViewSlot extends StatelessWidget {
//   const ViewSlot({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Products',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF184A2C)),
//         useMaterial3: true,
//       ),
//       home: const Viewcart(title: ''),
//     );
//   }
// }
//
// class Viewcart extends StatefulWidget {
//   const Viewcart({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<Viewcart> createState() => _ViewcartState();
// }
//
// class _ViewcartState extends State<Viewcart> {
//   _ViewcartState() {
//     ViewSlot();
//   }
//
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//
//     ViewSlot();
//
//     // Initializing Razorpay
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     // Disposing Razorpay instance to avoid memory leaks
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     // Handle successful payment
//     print("Payment Successful: ${response.paymentId}");
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/user_payment/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           // Handle success response
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print("Error in Payment: ${response.code} - ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet
//     print("External Wallet: ${response.walletName}");
//   }
//
//   void _openCheckout() {
//     int am = int.parse(amount_) * 100;
//
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
//       'amount': am, // Amount in paise (e.g. 2000 paise = Rs 20)
//       'name': 'Flutter Razorpay Example',
//       'description': 'Payment for the product',
//       'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
//       'external': {
//         'wallets': ['paytm'] // List of external wallets
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: ${e.toString()}');
//     }
//   }
//
//   String amount_ = "0";
//   List<String> id_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> price_ = <String>[];
//   List<String> quantity_ = <String>[];
//   List<String> photo_ = <String>[];
//   List<String> date_ = <String>[];
//
//   Future<void> ViewSlot() async {
//     List<String> id = <String>[];
//     List<String> price = <String>[];
//     List<String> name = <String>[];
//     List<String> quantity = <String>[];
//     List<String> photo = <String>[];
//     List<String> date = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_view_cart/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//       String amount = jsondata['amount'].toString();
//
//       var arr = jsondata["data"];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         price.add(arr[i]['price'].toString());
//         name.add(arr[i]['name'].toString());
//         quantity.add(arr[i]['quantity'].toString());
//         date.add(arr[i]['date'].toString());
//         photo.add(sh.getString('img_url').toString() + arr[i]['photo']);
//       }
//
//       setState(() {
//         id_ = id;
//         amount_ = amount;
//         price_ = price;
//         quantity_ = quantity;
//         photo_ = photo;
//         name_ = name;
//         date_ = date;
//       });
//     } catch (e) {
//       print("Network Error: $e");
//       Fluttertoast.showToast(msg: "Network Error");
//     }
//   }
//
//   // Function to delete product from cart
//   Future<void> deleteProductFromCart(String cartId, int index) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String url = '$urls/del_cart/';
//
//       var data = await http.post(Uri.parse(url), body: {'id': cartId});
//       var jsondata = json.decode(data.body);
//       String status = jsondata['status'];
//
//       if (status == 'ok') {
//         setState(() {
//           id_.removeAt(index);
//           price_.removeAt(index);
//           name_.removeAt(index);
//           quantity_.removeAt(index);
//           photo_.removeAt(index);
//           date_.removeAt(index);
//         });
//         Fluttertoast.showToast(msg: "Item deleted");
//       } else {
//         Fluttertoast.showToast(msg: "Failed to delete item");
//       }
//     } catch (e) {
//       print("Network Error: $e");
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage(title: 'home')),
//               );
//             },
//           ),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           title: Text(widget.title),
//           actions: [
//             Text(amount_),
//             IconButton(
//               icon: Icon(Icons.payment),
//               onPressed: () {
//                 _openCheckout();
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           child: ListView.builder(
//             physics: BouncingScrollPhysics(),
//             itemCount: id_.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 title: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Card(
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: double.infinity,
//                               height: 450,
//                               child: Image.network(
//                                 photo_[index],
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               top: 20,
//                               left: 20,
//                               child: Text(
//                                 name_[index],
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               left: 0,
//                               right: 0,
//                               child: Container(
//                                 padding: EdgeInsets.all(20),
//                                 color: Colors.black.withOpacity(0.5),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Quantity',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       quantity_[index],
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Price info',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       price_[index],
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // Add delete button
//                             Positioned(
//                               right: 10,
//                               top: 10,
//                               child: IconButton(
//                                 onPressed: () {
//                                   deleteProductFromCart(id_[index], index);
//                                 },
//                                 icon: Icon(
//                                   Icons.clear,
//                                   color: Colors.red,
//                                 ),
//                                 tooltip: 'Remove from Cart',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
