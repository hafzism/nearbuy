import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'cus_home.dart';

void main() {
  runApp(const ViewSlot());
}

class ViewSlot extends StatelessWidget {
  const ViewSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF184A2C)),
        useMaterial3: true,
      ),
      home: const view_noti(title: ''),
    );
  }
}

class view_noti extends StatefulWidget {
  const view_noti({super.key, required this.title});

  final String title;

  @override
  State<view_noti> createState() => _view_notiState();
}

class _view_notiState extends State<view_noti> {
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> not_ = <String>[];
  List<String> shop_ = <String>[];



  @override
  void initState() {
    super.initState();
    ViewSlot(); // Call the API function here in initState
  }

  Future<void> ViewSlot() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> not = <String>[];
    List<String> shop = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? ''; // Ensure 'url' is not null
      String lid = sh.getString('lid') ?? '';  // Ensure 'lid' is not null
      // String pid = sh.getString('pid') ?? '';  // Ensure 'lid' is not null

      if (urls.isEmpty || lid.isEmpty) {
        print('Error: URL or LID missing in SharedPreferences');
        return;
      }

      String url = '$urls/view_notification/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      print("Response Data: ${data.body}"); // Debugging print statement

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'] ?? 'unknown'; // Check if status exists

      if (statuss != 'ok') {
        print('Error: Status not OK');
        return;
      }

      var arr = jsondata["data"];
      if (arr == null || arr.isEmpty) {
        print('No data found');
        return;
      }

      print("Order count: ${arr.length}");

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        not.add(arr[i]['not']);
        shop.add(arr[i]['shop']);


      }

      setState(() {
        id_ = id;
        date_ = date;
        not_ = not;
        shop_ = shop;

      });

      print('Order data successfully updated');
    } catch (e) {
      print("Network Error: $e");
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
          title: Text("Notifications"),
        ),
        body: Container(
          decoration: BoxDecoration(),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press $index");
                },
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
                                buildRow("Shop", shop_[index]),
                                buildRow("Notification", not_[index]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // if (ostatus_[index] == "pending")...{
                      //   ElevatedButton(onPressed: () async {
                      //     SharedPreferences sh = await SharedPreferences.getInstance();
                      //     sh.setString("pid", id_[index]).toString();
                      //     Navigator.push(
                      //       context, MaterialPageRoute(builder: (context) => cancel_reason(),),);
                      //   }, child: (Text("Cancel")))
                      // }else...{
                      //   Text(ostatus_[index])

                      // }
                    ],
                  ),
                ),
              );
            },
          ),
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
          )
        ],
      ),
    );
  }
}
