import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cus_home.dart';
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
      home: const ViewProfile(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key, required this.title});

  final String title;

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String Name = "";
  String Phone = "";
  String Email = "";
  String Dob = "";
  String Place = "";
  String District = "";
  String State = "";
  String Pincode = "";
  String Photo = "";
  // String Photo_ = "";

  @override
  void initState() {
    super.initState();
    vprofile();
  }

  void vprofile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    String img_url = sh.getString('img_url') ?? '';

    final urls = Uri.parse('$url/user_view_profile/');
    try {
      final response = await http.post(urls, body: {"lid": lid});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String status = data['status'] ?? '';
        if (status == 'ok') {
          String name1 = data['name']?.toString() ?? '';
          String phone1 = data['phone']?.toString() ?? '';
          String email1 = data['email']?.toString() ?? '';
          String dob1 = data['dob']?.toString() ?? '';
          String place1 = data['place']?.toString() ?? '';
          String dis1 = data['dis']?.toString() ?? '';
          String state1 = data['state']?.toString() ?? '';
          String pin1 = data['pin']?.toString() ?? '';
          String photo = img_url + (data['profile']?.toString() ?? '');
          // String photo1 = img_url + (data['proof']?.toString() ?? '');

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
            // Photo_ = photo1;
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>cus_home(),),);

      return false;
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
                      // CircleAvatar(
                      //   radius: 70,
                      //   backgroundImage: NetworkImage(
                      //     Photo_.isNotEmpty ? Photo_ : 'https://via.placeholder.com/150',
                      //   ),
                      //   backgroundColor: Colors.blueAccent[100],
                      // ),
                      // SizedBox(height: 30),

                      // Edit Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyEditpage(title: 'Edit Profile'),
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
        Container(
          width: 130,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}



