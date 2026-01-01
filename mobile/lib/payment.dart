// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
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
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Handle successful payment
//     print("Payment Successful: ${response.paymentId}");
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
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
//       'amount': 20, // Amount in paise (e.g. 2000 paise = Rs 20)
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
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Razorpay Flutter Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _openCheckout,
//           child: Text('Make Payment'),
//         ),
//       ),
//     );
//   }
// }