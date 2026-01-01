// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:product_finder/viewreview.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// import 'home.dart';
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   static const String _title = 'BUILD RIGHT';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Send Feedback")),
//         body: const sendreviews(),
//       ),
//     );
//   }
// }
//
// class sendreviews extends StatefulWidget {
//   const sendreviews({Key? key}) : super(key: key);
//
//   @override
//   State<sendreviews> createState() => _sendreviewsState();
// }
//
// class _sendreviewsState extends State<sendreviews> {
//
//
//
//
//
//   TextEditingController feedbackController = TextEditingController();
//
//   String rating="";
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       WillPopScope(
//           onWillPop: () async{ return true; },
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               leading: BackButton( onPressed:() {
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => home(title: 'Home')),);
//
//
//               },),
//
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.black,
//
//               title: Text("Review"),
//             ),
//
//             body:
//             Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: ListView(
//                   children: <Widget>[
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       child: TextField(
//                         maxLines: 5, // Allow unlimited lines
//                         keyboardType: TextInputType.multiline,
//
//                         controller: feedbackController,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//
//                           labelText: 'Feedback',
//                         ),
//                       ),
//                     ),
//                     RatingBar.builder(
//                       initialRating: 3,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                       itemBuilder: (context, _) => Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                       ),
//                       onRatingUpdate: (ratin) {
//                         print(ratin);
//
//                         rating= ratin.toString();
//
//
//                       },
//                     ),
//
//
//
//                     Container(
//                         height: 50,
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         child: ElevatedButton(
//                           child: const Text('Send'),
//                           onPressed: () async {
//
//                             String feedback= feedbackController.text.toString();
//
//
//
//
//                             SharedPreferences sh = await SharedPreferences.getInstance();
//                             String url = sh.getString('url').toString();
//                             String lid = sh.getString('lid').toString();
//                             String planid = sh.getString('planid').toString();
//
//                             final urls = Uri.parse('$url/user_send_rating/');
//                             try {
//                               final response = await http.post(urls, body: {
//                                 'review':feedback,
//                                 'rating':rating,
//                                 'lid':lid,
//                                 'planid':planid,
//                               }
//                               );
//                               if (response.statusCode == 200) {
//                                 String status = jsonDecode(response.body)['status'];
//                                 if (status == 'ok') {
//                                   Fluttertoast.showToast(msg: 'Review sent Successfully');
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => viewreviews(),
//                                       ));
//                                 }  else {
//                                   Fluttertoast.showToast(msg: 'Failed to sent feedback');
//                                 }
//                               } else {
//                                 Fluttertoast.showToast(msg: 'Network Error');
//                               }
//                             } catch (e) {
//                               Fluttertoast.showToast(msg: e.toString());
//                             }
//
//
//                           },
//                         )
//                     ),
//                   ],
//                 )),
//           ));
//
//
//
//   }
// }