// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:nearbuy/sample.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'complaint.dart';
// import 'home.dart';
// import 'package:http/http.dart' as http;
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
//       home: const view_not(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class view_not extends StatefulWidget {
//   const view_not({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<view_not> createState() => _view_notState();
// }
//
// class _view_notState extends State<view_not> {
//
//
//   _view_notState(){
//     viewvol();
//   }
//
//
//   List<String> id_ = <String>[];
//   List<String> not_= <String>[];
//   List<String> date_= <String>[];
//   List<String> shop_= <String>[];
//
//   Future<void> viewvol() async {
//     List<String> id = <String>[];
//     List<String> not = <String>[];
//     List<String> date = <String>[];
//     List<String> shop = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/view_notification/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'lid':lid
//
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         not.add(arr[i]['not'].toString());
//         date.add(arr[i]['date'].toString());
//         shop.add(arr[i]['shop'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         not_ = not;
//         date_ = date;
//         shop_ = shop;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             onLongPress: () {
//               print("long press " + index.toString());
//             },
//             title: Padding(
//               padding: const EdgeInsets.all(80),
//               child: Column(
//                 children: [
//                   Card(
//                     child: Column(
//                       children: [
//
//                         Padding(padding: EdgeInsets.all(8.0), child: Text("Notification : "+not_[index])),
//                         SizedBox(height: 15,),
//                         Padding(padding: EdgeInsets.all(8.0), child: Text("Date : "+date_[index])),
//                         SizedBox(height: 15,),
//                         Padding(padding: EdgeInsets.all(8.0), child: Text("Shop name : "+shop_[index])),
//                         ElevatedButton(onPressed:()
//                         {Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),),);},
//                             child: Text("Home")),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ), //
//
//     );
//   }
//
// }
//
