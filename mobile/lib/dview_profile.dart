import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dedit_profile.dart';
import 'edit_profile_new.dart';

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
      home: const dboy_vprofile(title: 'Flutter Demo Home Page'),
    );
  }
}

class dboy_vprofile extends StatefulWidget {
  const dboy_vprofile({super.key, required this.title});

  final String title;

  @override
  State<dboy_vprofile> createState() => _dboy_vprofileState();
}

class _dboy_vprofileState extends State<dboy_vprofile> {
  String Name = "";
  String Phone = "";
  String Email = "";
  String Dob = "";
  String Place = "";
  String District = "";
  String State = "";
  String Pincode = "";
  String Photo = "";
  String Photo_ = "";

  @override
  void initState() {
    super.initState();
    vprofile();
  }

  void vprofile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/dboy_view_profile/');
    try {
      final response = await http.post(urls, body: {"lid": lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name1 = jsonDecode(response.body)['name'];
          String phone1 = jsonDecode(response.body)['phone'];
          String email1 = jsonDecode(response.body)['email'];
          String dob1 = jsonDecode(response.body)['dob'];
          String place1 = jsonDecode(response.body)['place'];
          String dis1 = jsonDecode(response.body)['dis'];
          String state1 = jsonDecode(response.body)['state'];
          String pin1 = jsonDecode(response.body)['pin'];
          String photo = img_url + jsonDecode(response.body)['photo'];
          String photo1 = img_url + jsonDecode(response.body)['photo1'];

          setState(() {
            Name = name1;
            Phone = phone1;
            Email = email1;
            Dob = dob1;
            Place = place1;
            District = dis1;
            State = state1;
            Pincode = pin1;
            Photo = photo;
            Photo_ = photo1;
          });
        } else {
          Fluttertoast.showToast(msg: 'Profile not found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      return true;
    },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Image 1
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          Photo.isNotEmpty ? Photo : 'https://via.placeholder.com/150',
                        ),
                        backgroundColor: Colors.blueAccent[100],
                      ),
                      SizedBox(height: 20),

                      // User Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch, // Align to stretch within the card
                        children: [
                          _buildInfoRow("Name", Name),
                          _buildInfoRow("Phone no", Phone),
                          _buildInfoRow("Email", Email),
                          _buildInfoRow("Date of Birth", Dob),
                          _buildInfoRow("Place", Place),
                          _buildInfoRow("District", District),
                          _buildInfoRow("State", State),
                          _buildInfoRow("Pincode", Pincode),
                        ],
                      ),

                      SizedBox(height: 30),

                      // Profile Image 2
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          Photo_.isNotEmpty ? Photo_ : 'https://via.placeholder.com/150',
                        ),
                        backgroundColor: Colors.blueAccent[100],
                      ),
                      SizedBox(height: 30),

                      // Edit Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dboy_edit_profile(title: 'Edit Profile'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to display user info with label on the left and value on the right
  Row _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class MyEditPage extends StatelessWidget {
  final String title;

  MyEditPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Edit Profile Page'),
      ),
    );
  }
}



