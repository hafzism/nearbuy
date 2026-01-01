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
        appBar: AppBar(title: const Text("Send reason")),
        body: const cancel_reason(),
      ),
    );
  }
}

class cancel_reason extends StatefulWidget {
  const cancel_reason({Key? key}) : super(key: key);

  @override
  State<cancel_reason> createState() => _cancel_reasonState();
}

class _cancel_reasonState extends State<cancel_reason> {





  TextEditingController reasoncontroller = TextEditingController();




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

              title: Text("Reason"),
            ),

            body:
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        maxLines: 5, // Allow unlimited lines
                        keyboardType: TextInputType.multiline,

                        controller: reasoncontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          labelText: 'Reason',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Send'),
                          onPressed: () async {


                            String reason = reasoncontroller.text.toString();




                            SharedPreferences sh = await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String lid = sh.getString('lid').toString();
                            String pid = sh.getString('pid').toString();

                            final urls = Uri.parse('$url/user_cancel_return/');
                            try {
                              final response = await http.post(urls, body: {

                                'reason':reason,
                                'lid':lid,
                                'pid':pid,

                              });
                              print('------------------------');
                              print(pid);

                              if (response.statusCode == 200) {
                                String status = jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  Fluttertoast.showToast(msg: 'Damage report recieved. please wait for the shop to contact you.');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => cus_home(),
                                      ));
                                }  else {
                                  Fluttertoast.showToast(msg: 'Failed to cancel');
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