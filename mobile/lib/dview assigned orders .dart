import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dboy_home.dart';


// import 'edit fee service.dart';
// import 'home.dart';




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
      home: const dboy_vorders(title: ''),
    );
  }
}

class dboy_vorders extends StatefulWidget {
  const dboy_vorders({super.key, required this.title});

  final String title;

  @override
  State<dboy_vorders> createState() => _dboy_vordersState();
}

class _dboy_vordersState extends State<dboy_vorders> {

  _dboy_vordersState(){
    ViewSlot();
  }

  List<String> id_ = <String>[];
  List<String> date_= <String>[];
  List<String> amount_= <String>[];
  List<String> qnty_= <String>[];
  List<String> pname_= <String>[];
  List<String> cname_= <String>[];


  get status => null;

  Future<void> ViewSlot() async {
    List<String> id = <String>[];
    List<String> date= <String>[];
    List<String> amount= <String>[];
    List<String> qnty = <String>[];
    List<String> pname = <String>[];
    List<String> cname= <String>[];




    try {

      SharedPreferences sh = await SharedPreferences.getInstance();
      String? urls = sh.getString('url');
      String? lid = sh.getString('lid');
      // SharedPreferences sh = await SharedPreferences.getInstance();
      // String urls = sh.getString('url').toString();
      // String lid = sh.getString('lid').toString();
      // String url = '$urls/dboy_view_orders/';

      if (urls == null || lid == null) {
        print("URL or lid not found in SharedPreferences.");
        return;
      }
      String url = '$urls/dboy_view_orders/';
      var response = await http.post(Uri.parse(url), body: {
        'lid': lid,
      });
      // var data = await http.post(Uri.parse(url), body: {
      //   'lid': lid
      // });
      // print(data.body);  // Print the raw data
      var jsonData = json.decode(response.body);
      String status = jsonData['status'];

      // var jsondata = json.decode(data.body);
      // String statuss = jsondata['status'];

      if (status == "ok") {
        var arr = jsonData["data"];

      // print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        amount.add(arr[i]['price']);
        qnty.add(arr[i]['qnt']);
        pname.add(arr[i]['pname']);
        cname.add(arr[i]['cname']);


      }

      setState(() {
        id_ = id;
        date_ = date;
        amount_ = amount;
        pname_ = pname;
        qnty_ = qnty;
        cname_ = cname;


      });

      } else {
        print("Failed to load data: $status");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  //     print(statuss);
  //   } catch (e) {
  //     print("Network Error: $e");
  //     print("Error ------------------- " + e.toString());
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => deliver_home(),
            ));

        return true;
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Replace with your desired icon
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => deliver_home(),
                  ));

            },
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Order details"),
        ),

        body: Container(decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/'), fit: BoxFit.cover),
        ),
          child: ListView.builder(

            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.all(5.0),
            // shrinkWrap: true,
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 500,
                          shadowColor: Colors.black,
                          color: Colors.black,

                          margin: EdgeInsets.all(10),
                          child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Customer Name",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white

                                            ,
                                          ),),
                                        Text(cname_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white

                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Shop Name",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(pname_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Customer Place",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(qnty_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Customer Number",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(amount_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Date",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(date_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),
                                        ),




                                      ],
                                    ),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        // Retrieve the URL from shared preferences
                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                        String? urls = sh.getString('url'); // Get URL from shared preferences

                                        if (urls == null || urls.isEmpty) {
                                          Fluttertoast.showToast(msg: "Error: URL not found");
                                          return;
                                        }

                                        // Construct the API endpoint
                                        String url = '$urls/dboy_update_status/';

                                        // Send the request to update the status
                                        var response = await http.post(
                                          Uri.parse(url),
                                          body: {'cid': id_[index]}, // Pass the 'cid' as a parameter
                                        );

                                        // Check if the request was successful
                                        if (response.statusCode == 200) {
                                          var jsondata = json.decode(response.body); // Decode the JSON response
                                          String status = jsondata['status']; // Extract the status

                                          // Show a success message
                                          Fluttertoast.showToast(msg: "Status updated to: $status");

                                          // Refresh the view
                                          ViewSlot();
                                        } else {
                                          // Handle errors if the status code is not 200 (success)
                                          Fluttertoast.showToast(msg: "Error updating status: ${response.statusCode}");
                                        }
                                      } catch (e) {
                                        // Handle network or decoding errors
                                        print("Network Error: $e");
                                        Fluttertoast.showToast(msg: "Failed to update status: $e");
                                      }
                                    },

                                    style: ElevatedButton.styleFrom(

                                      // Text color
                                      alignment: Alignment.center,// Button padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),), // Rounded corners
                                    ),
                                    child: Text("Update status",
                                      style: TextStyle(
                                        color: Colors.black
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),



      ),
    );
  }
}



