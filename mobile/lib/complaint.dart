import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'cus_home.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'BUILD RIGHT';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text("Send Complaint")),
        body: const sendcomplaint(),
      ),
    );
  }
}

class sendcomplaint extends StatefulWidget {
  const sendcomplaint({Key? key}) : super(key: key);

  @override
  State<sendcomplaint> createState() => _sendcomplaintState();
}

class _sendcomplaintState extends State<sendcomplaint> {


  final formcontroll = GlobalKey<FormState>();


  TextEditingController complaintcontroller = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
          onWillPop: () async{ return true; },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: BackButton( onPressed:() {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => cus_home()),);


              },),

              backgroundColor: Colors.white,
              foregroundColor: Colors.black,

              title: Text("Complaint"),
            ),

            body:
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child:Form(
                        key: formcontroll,
                      child: TextFormField(
                        maxLines: 5, // Allow unlimited lines
                        keyboardType: TextInputType.multiline,

                        controller: complaintcontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          labelText: 'complaint',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                          return "Complaint cannot be blank";
                          }
                          return null;
                        }
                      ),
                      )
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Send'),
                          onPressed: () async {


                            String complaint = complaintcontroller.text.toString();




                            SharedPreferences sh = await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String lid = sh.getString('lid').toString();

                            final urls = Uri.parse('$url/user_send_complaint/');
                            try {
                              final response = await http.post(urls, body: {

                                'complaint':complaint,
                                'lid':lid,

                              });
                              if (response.statusCode == 200) {
                                String status = jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  Fluttertoast.showToast(msg: 'complaint sent Successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => cus_home(),
                                      ));
                                }  else {
                                  Fluttertoast.showToast(msg: 'Failed to sent feedback');
                                }
                              } else {
                                Fluttertoast.showToast(msg: 'Network Error');
                              }
                            } catch (e) {
                              Fluttertoast.showToast(msg: e.toString());
                            }


                          },
                        )
                    ),
                  ],
                )),
          ));



  }
}