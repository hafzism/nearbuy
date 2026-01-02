// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:nearbuy/sample.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'home.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const viewoffers(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class viewoffers extends StatefulWidget {
//   const viewoffers({super.key, required this.title});
//
//   final String title;
//
//   State<viewoffers> createState() => _viewoffersState();
// }
//
// class _viewoffersState extends State<viewoffers> {
//   _viewoffersState(){
//     viewVol();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> not_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> shop_ = <String>[];
//
//   Future<void> viewVol() async {
//     List<String> id = <String>[];
//     List<String> not = <String>[];
//     List<String> date = <String>[];
//     List<String> shop = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? urls = sh.getString('url');
//       String? lid = sh.getString('lid');
//
//       if (urls == null || lid == null) {
//         print("URL or lid not found in SharedPreferences.");
//         return;
//       }
//
//       String url = '$urls/view_notification/';
//       var response = await http.post(Uri.parse(url), body: {
//         'lid': lid,
//       });
//
//       var jsonData = json.decode(response.body);
//       String status = jsonData['status'];
//
//       if (status == "ok") {
//         var arr = jsonData["data"];
//
//
//         for (int i = 0; i < arr.length; i++) {
//           id.add(arr[i]['id'].toString());
//           not.add(arr[i]['not'].toString());
//           date.add(arr[i]['date'].toString());
//           shop.add(arr[i]['shop'].toString());
//         }
//
//         setState(() {
//           id_ = id;
//           not_ = not;
//           date_ = date;
//           shop_ = shop;
//         });
//       } else {
//         print("Failed to load data: $status");
//       }
//     } catch (e) {
//       print("Error: ${e.toString()}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             onLongPress: () {
//               print("Long press on item $index");
//             },
//             title: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Notification: ${not_[index]}"),
//                     ),
//                     const SizedBox(height: 15),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Date: ${date_[index]}"),
//                     ),
//                     const SizedBox(height: 15),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Shop name: ${shop_[index]}"),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>  HomePage(),
//                           ),
//                         );
//                       },
//                       child: const Text("Home"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
