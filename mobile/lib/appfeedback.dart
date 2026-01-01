import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sendfeedback.dart';  // Make sure this page has MySendComplaint class defined
import 'package:http/http.dart' as http;

import 'cus_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const appfeedback(title: 'Flutter Demo Home Page'),
    );
  }
}

class appfeedback extends StatefulWidget {
  const appfeedback({super.key, required this.title});

  final String title;

  @override
  State<appfeedback> createState() => _appfeedbackState();
}

class _appfeedbackState extends State<appfeedback> {

  _appfeedbackState(){
    viewvol();
  }

  List<String> id_ = <String>[];
  List<String> feedback_ = <String>[];
  List<String> date_ = <String>[];

  Future<void> viewvol() async {
    List<String> id = <String>[];
    List<String> feedback = <String>[];
    List<String> date = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_feedback/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        feedback.add(arr[i]['feedback'].toString());
        date.add(arr[i]['date'].toString());
      }

      setState(() {
        id_ = id;
        feedback_ = feedback;
        date_ = date;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cus_home()),
            );
          }),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Send app feedback to admin"),
        ),
        body: Container(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Colors.black,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                buildRow("Date", date_[index]),
                                buildRow("Feedback", feedback_[index]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Add Floating Action Button here
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => sendfeedback()), // Redirect to send complaint page
            );
          },
          tooltip: 'Send Feedback',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
