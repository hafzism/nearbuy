// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../sample.dart';
// import 'login/screens/login_screen.dart';
// import 'login/utils/common_widgets/gradient_background.dart';
// import 'login/values/app_strings.dart';
// import 'login/values/app_theme.dart';
//
//
// class dboyreg extends StatefulWidget {
//   const dboyreg({super.key});
//
//   @override
//   State<dboyreg> createState() => _dboyregState();
// }
//
// class _dboyregState extends State<dboyreg> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = new TextEditingController();
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController passwordController = new TextEditingController();
//   TextEditingController confirmPasswordController =  new TextEditingController();
//   TextEditingController phoneController = new TextEditingController();
//   TextEditingController dobController = new TextEditingController();
//   TextEditingController placeController = new TextEditingController();
//   TextEditingController districtController = new TextEditingController();
//   TextEditingController stateController = new TextEditingController();
//   TextEditingController pinController = new TextEditingController();
//
//
//
//
//
//   File? _selectedImage;
//   String? _encodedImage;
//
//   Future<void> _chooseAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
//         photo = _encodedImage.toString();
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   String photo = '';
//
//
//
//
//
//
//
//   File? _selectedProof;
//   String? _encodedProof;
//
//
//   Future<void> _chooseAndUploadProof() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedProof = File(pickedImage.path);
//         _encodedProof = base64Encode(_selectedProof!.readAsBytesSync());
//         idproof = _encodedProof.toString();
//       });
//     }
//   }
//
//
//   Future<void> _checkPermissionAndChooseProof() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadProof();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   String idproof = '';
//
//
//   final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         dobController.text = _dateFormatter.format(picked);
//       });
//     }
//   }
//
//
//
//
//   Future<void> submitForm() async {
//     String _name = nameController.text;
//     String _phone = phoneController.text;
//     String _email = emailController.text;
//     String _dob = dobController.text;
//     String _place = placeController.text;
//     String _district = districtController.text;
//     String _state = stateController.text;
//     String _pin = pinController.text;
//     String _pass = passwordController.text;
//     String _cpass = confirmPasswordController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? ''; // Set your backend URL
//
//     if (url.isEmpty) {
//       Fluttertoast.showToast(msg: 'Invalid server URL');
//       return;
//     }
//
//     final Uri uri = Uri.parse('$url/uerregister/');
//     try {
//       final response = await http.post(uri, body: {
//         'name': _name,
//         'phone': _phone,
//         'email': _email,
//         'dob': _dob,
//         'place': _place,
//         'district': _district,
//         'state': _state,
//         'pin': _pin,
//         'password':_pass,
//         'confirmpassword':_cpass,
//         'image': _encodedImage ?? '',
//         'proof': _encodedProof ?? '',
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Signup successful');
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),),);
//           // Navigate to the next page if necessary
//         } else {
//           Fluttertoast.showToast(msg: 'Signup failed');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           const GradientBackground(
//             children: [
//               Text(AppStrings.register, style: AppTheme.titleLarge),
//               SizedBox(height: 6),
//               Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//
//
//
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: <Widget>[
//                           TextFormField(
//                             controller: nameController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Name',
//                             ),
//
//
//                             validator: (value){
//                               if (value == null || value.isEmpty){
//                                 return "please enter your name";
//                               }
//
//                               String pattern = r'^[a-zA-Z\s]+$';
//                               RegExp regex = RegExp(pattern);
//                               if (!regex.hasMatch(value)) {
//                                 return "Name must contain only letters and spaces";
//                               }
//
//                               return null;
//                             },
//
//                           ),
//                           const SizedBox(height: 15),
//
//
//                           TextFormField(
//                             controller: phoneController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Phone',
//                             ),
//
//
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your phone number';
//                                 }
//
//                                 // Regular expression for validating a phone number (10 digits)
//                                 String pattern = r'^[0-9]{10}$';
//                                 RegExp regex = RegExp(pattern);
//                                 if (!regex.hasMatch(value)) {
//                                   return 'Please enter a valid 10-digit phone number';
//                                 }
//
//                                 return null;
//                               }
//
//
//                           ),
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: emailController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Email',
//                             ),
//
//                             validator: (value){
//                               if (value == null || value.isEmpty){
//                                 return "please enter correct email";
//                               }
//                               String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//                               RegExp regex = RegExp(pattern);
//                               if (!regex.hasMatch(value)) {
//                                 return 'Please enter a valid email address';
//                               }
//                               return null;
//                             },
//
//                           ),
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: dobController,
//                             readOnly: true,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Date of Birth'),
//
//
//
//                            onTap: () => _selectDate(context),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your date of birth';
//                                 }
//
//                                 // Try to parse the date input
//                                 DateTime? dob;
//                                 try {
//                                   dob = DateTime.parse(value);
//                                 } catch (e) {
//                                   return 'Please enter a valid date in YYYY-MM-DD format';
//                                 }
//
//                                 // Calculate age
//                                 DateTime today = DateTime.now();
//                                 int age = today.year - dob.year;
//
//                                 if (dob.month > today.month || (dob.month == today.month && dob.day > today.day)) {
//                                   age--;
//                                 }
//
//                                 // Check if age is 18 or above
//                                 if (age < 18) {
//                                   return 'You must be at least 18 years old';
//                                 }
//
//                                 return null;
//                               }
//
//                           ),
//
//
//
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: placeController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Place',
//                             ),
//
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter a place';
//                                 }
//
//                                 // Regular expression for place validation (allows letters, spaces, and common symbols, but no numbers)
//                                 String pattern = r'^[a-zA-Z\s,.-]+$';
//                                 RegExp regex = RegExp(pattern);
//                                 if (!regex.hasMatch(value)) {
//                                   return 'Place name can only contain letters, spaces, commas, periods, and hyphens';
//                                 }
//
//                                 return null;
//                               }
//
//
//                           ),
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: districtController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'District',
//                             ),
//                           ),
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: stateController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'State',
//                             ),
//
//
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter a district';
//                                 }
//
//                                 // Regular expression for place validation (allows letters, spaces, and common symbols, but no numbers)
//                                 String pattern = r'^[a-zA-Z\s,.-]+$';
//                                 RegExp regex = RegExp(pattern);
//                                 if (!regex.hasMatch(value)) {
//                                   return 'District name can only contain letters, spaces, commas, periods, and hyphens';
//                                 }
//
//                                 return null;
//                               }
//
//                           ),
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: pinController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Pin',
//                             ),
//
//
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your 6-digit PIN';
//                                 }
//
//                                 // Regular expression for validating a 6-digit PIN
//                                 String pattern = r'^\d{6}$';
//                                 RegExp regex = RegExp(pattern);
//                                 if (!regex.hasMatch(value)) {
//                                   return 'Please enter a valid 6-digit PIN';
//                                 }
//
//                                 return null;
//                               }
//
//                           ),
//
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: passwordController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Password',
//                             ),
//
//
//                             obscureText: true, // To hide the text (password style)
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your current password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters long';
//                               }
//
//                               String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
//                               RegExp regex = RegExp(pattern);
//                               if (!regex.hasMatch(value)) {
//                                 return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, and 1 number';
//                               }
//
//                               return null;
//                             },
//
//                           ),
//
//
//                           const SizedBox(height: 15),
//
//                           TextFormField(
//                             controller: confirmPasswordController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                               labelText: 'Confirm password',
//                             ),
//
//
//                             obscureText: true, // To hide the text (password style)
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please confirm your password';
//                               }
//                               if (value != confirmPasswordController.text) {
//                                 return 'Passwords do not match';
//                               }
//
//                               // Add password strength validation if necessary (can be skipped for Confirm Password)
//                               String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
//                               RegExp regex = RegExp(pattern);
//                               if (!regex.hasMatch(value)) {
//                                 return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, and 1 number';
//                               }
//
//                               return null;
//                             },
//
//
//                           ),
//
//                         SizedBox(height: 15,),
//
//                           if(_selectedImage!=null) ...{
//                             InkWell(
//                               child: Image.file(_selectedImage!, height: 400,),
//                               radius: 399,
//                               onTap: _checkPermissionAndChooseImage,
//                             )
//                           }
//                           else ...{
//                             InkWell(
//                               onTap: _checkPermissionAndChooseImage,
//                               child: Column(
//                                 children: [
//                                   Image(image: NetworkImage(
//                                       'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
//                                     height: 200,
//                                     width: 200,),
//                                   Text('Select Image', style: TextStyle(color: Colors.cyan))
//                                 ],
//                               ),
//                             ),
//                           },
//
//
//
//                           if(_selectedProof!=null) ...{
//                             InkWell(
//                               child: Image.file(_selectedProof!, height: 400,),
//                               radius: 399,
//                               onTap: _checkPermissionAndChooseProof,
//                             )
//                           }else ...{
//                             InkWell(
//                               onTap: _checkPermissionAndChooseProof,
//                               child: Column(
//                                 children: [
//                                   Image(image: NetworkImage(
//                                       'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
//                                     height: 200,
//                                     width: 200,),
//                                   Text('Select Image', style: TextStyle(color: Colors.cyan))
//                                 ],
//                               ),
//                             ),
//                           },
//
//
//
//
//
//                           SizedBox(height: 15,),
//                           SizedBox(
//                             width: double.infinity,
//                             child: FilledButton(
//                               onPressed: () {
//                                 submitForm();
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),),);                  // Navigate to signup screen
//                               },
//                               style: ButtonStyle(
//                                 padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
//                                 backgroundColor: MaterialStateProperty.all(Colors.black),
//                                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 )),
//                               ),
//                               child: Text(
//                                 'Register',
//                                 style: TextStyle(fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ),
//
//
//
//
//                         ],
//                       ),
//                     ),
//                   ),
//
//
//
//
//                 ],
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 AppStrings.iHaveAnAccount,
//                 style: AppTheme.bodySmall.copyWith(color: Colors.black),
//               ),
//
//
//               TextButton(onPressed: () {
//                 Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),);
//               }, child: Text("Login"))
//
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
