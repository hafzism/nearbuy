import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nearbuy/view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dview_profile.dart';

void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyEditpage(title: 'Edit Profile'),
    );
  }
}

class MyEditpage extends StatefulWidget {
  const MyEditpage({super.key, required this.title});

  final String title;

  @override
  State<MyEditpage> createState() => _MyEditpageState();
}

class _MyEditpageState extends State<MyEditpage> {
  _MyEditpageState() {
    _get_data();
  }

  final formcontrol = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  String profile = '';
  // String proof = '';

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dob.text = _dateFormatter.format(picked);
      });
    }
  }

  void _get_data() async {

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? lid = sh.getString('lid');

    if (url == null || lid == null) {
      Fluttertoast.showToast(msg: 'Error fetching URL or User ID');
      return;
    }

    final urls = Uri.parse('$url/user_view_profile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          setState(() {
            nameController.text = data['name'] ?? '';
            dob.text = data['dob'] ?? '';
            emailController.text = data['email'] ?? '';
            phone.text = data['phone'] ?? '';
            place.text = data['place'] ?? '';
            pinController.text = data['pin'] ?? '';
            districtController.text = data['district'] ?? '';
            stateController.text = data['state'] ?? '';
            profile = '${sh.getString("img_url")}${data['profile'].toString()}';
            // proof = '${sh.getString("img_url")}${data['proof'].toString()}';
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child : Form(
              key: formcontrol,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_selectedImage != null) ...{
                    InkWell(
                      child: Image.file(
                        _selectedImage!,
                        height: 400,
                      ),
                      onTap: _checkPermissionAndChooseImage,
                    ),
                  } else ...{
                    InkWell(
                      onTap: _checkPermissionAndChooseImage,
                      child: Column(
                        children: [
                          Image.network(profile, height: 200, width: 200),
                          const Text('Select Image', style: TextStyle(color: Colors.cyan))
                        ],
                      ),
                    ),
                  },


                  // if (_selectedImage2 != null) ...{
                  //   InkWell(
                  //     child: Image.file(
                  //       _selectedImage2!,
                  //       height: 400,
                  //     ),
                  //     onTap: _checkPermissionAndChooseImage2,
                  //   ),
                  // } else ...{
                  //   InkWell(
                  //     onTap: _checkPermissionAndChooseImage2,
                  //     child: Column(
                  //       children: [
                  //         Image.network(proof, height: 200, width: 200),
                  //         const Text('Select Image', style: TextStyle(color: Colors.cyan))
                  //       ],
                  //     ),
                  //   ),
                  // },
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Name"),
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "please enter your name";
                        }

                        String pattern = r'^[a-zA-Z\s]+$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return "Name must contain only letters and spaces";
                        }

                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        onTap: () {
                          _selectDate(context);
                        },
                        controller: dob,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Dob")),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your date of birth';
                          }

                          // Try to parse the date input
                          DateTime? dob;
                          try {
                            dob = DateTime.parse(value);
                          } catch (e) {
                            return 'Please enter a valid date in YYYY-MM-DD format';
                          }

                          // Calculate age
                          DateTime today = DateTime.now();
                          int age = today.year - dob.year;

                          if (dob.month > today.month || (dob.month == today.month && dob.day > today.day)) {
                            age--;
                          }

                          // Check if age is 18 or above
                          if (age < 18) {
                            return 'You must be at least 18 years old';
                          }

                          return null;
                        }

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text("Email")),


                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "please enter correct email";
                        }
                        String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },



                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Phone")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }

                          // Regular expression for validating a phone number (10 digits)
                          String pattern = r'^[0-9]{10}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid 10-digit phone number';
                          }

                          return null;
                        }

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: place,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Place")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a place';
                          }

                          // Regular expression for place validation (allows letters, spaces, and common symbols, but no numbers)
                          String pattern = r'^[a-zA-Z\s,.-]+$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Place name can only contain letters, spaces, commas, periods, and hyphens';
                          }

                          return null;
                        }

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: districtController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("District")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a district';
                          }

                          // Regular expression for place validation (allows letters, spaces, and common symbols, but no numbers)
                          String pattern = r'^[a-zA-Z\s,.-]+$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'District name can only contain letters, spaces, commas, periods, and hyphens';
                          }

                          return null;
                        }


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: stateController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("State")),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a state';
                          }

                          // Regular expression for place validation (allows letters, spaces, and common symbols, but no numbers)
                          String pattern = r'^[a-zA-Z\s,.-]+$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'State name can only contain letters, spaces, commas, periods, and hyphens';
                          }

                          return null;
                        }


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: pinController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Pin")),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your 6-digit PIN';
                          }

                          // Regular expression for validating a 6-digit PIN
                          String pattern = r'^\d{6}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid 6-digit PIN';
                          }

                          return null;
                        }


                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      senddata();
                    },
                    child: const Text("Edit"),
                  ),
                ],
              ),)
        ),
      ),
    );
  }

  void senddata() async {
    String uname = nameController.text;
    String dob1 = dob.text;
    String uemail = emailController.text;
    String uphone = phone.text;
    String udis = districtController.text;
    String ustate = stateController.text;
    String upin = pinController.text;
    String uplace = place.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? lid = sh.getString('lid');

    if (url == null || lid == null) {
      Fluttertoast.showToast(msg: 'Error fetching URL or User ID');
      return;
    }

    final urls = Uri.parse('$url/user_edit_profile/');
    try {
      final response = await http.post(urls, body: {
        "profile": photo,
        // "proof": photo2,
        "name": uname,
        "state": ustate,
        "pin": upin,
        "dob": dob1,
        "email": uemail,
        "district": udis,
        "phone": uphone,
        "place": uplace,
        "lid": lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Edit Successful');
          {Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfile(title: "",),),);}// Navigate to the next screen
        } else {
          Fluttertoast.showToast(msg: 'Email already exists');
        }
      } else { Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  File? _selectedImage;
  String? _encodedImage;
  String photo = '';

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }



  // File? _selectedImage2;
  // String? _encodedImage2;
  // String photo2 = '';
  //
  // Future<void> _chooseAndUploadImage2() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedImage != null) {
  //     setState(() {
  //       _selectedImage2 = File(pickedImage.path);
  //       _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
  //       photo2 = _encodedImage2.toString();
  //     });
  //   }
  // }

  // Future<void> _checkPermissionAndChooseImage2() async {
  //   final PermissionStatus status = await Permission.mediaLibrary.request();
  //   if (status.isGranted) {
  //     _chooseAndUploadImage2();
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: const Text('Permission Denied'),
  //         content: const Text(
  //           'Please go to app settings and grant permission to choose an image.',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }


}
