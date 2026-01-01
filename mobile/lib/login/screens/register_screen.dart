// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../utils/common_widgets/gradient_background.dart';
// import '../values/app_strings.dart';
// import '../values/app_theme.dart';
// import 'login_screen.dart';
//
// class userreg extends StatefulWidget {
//   const userreg({super.key});
//
//   @override
//   State<userreg> createState() => _userregState();
// }
//
// class _userregState extends State<userreg> {
//
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
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope( onWillPop: ()async{
//       return false;
//     },
//       child: Scaffold(
//         body: ListView(
//           children: [
//             const GradientBackground(
//               children: [
//                 Text(AppStrings.register, style: AppTheme.titleLarge),
//                 SizedBox(height: 6),
//                 Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Form(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: <Widget>[
//                               TextFormField(
//                                 validator: (value){
//                                   if(value!.isEmpty){
//                                     return "fill the name";
//                                   }
//                                   return null;
//
//                                 },
//                                 controller: nameController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Name',
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//
//
//                               TextFormField(
//                                 controller: phoneController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Phone',
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: emailController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Email',
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: dobController,
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Date of Birth',
//                                 ),
//                                 onTap: () => _selectDate(context),
//                               ),
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: placeController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Place',
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: districtController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'District',
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: stateController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'State',
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: pinController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Pin',
//                                 ),
//                               ),
//
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: passwordController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Password',
//                                 ),
//                               ),
//
//
//                               const SizedBox(height: 15),
//
//                               TextFormField(
//                                 controller: confirmPasswordController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                                   labelText: 'Confirm password',
//                                 ),
//                               ),
//
//
//
//                               if(_selectedImage!=null) ...{
//                                 InkWell(
//                                   child: Image.file(_selectedImage!, height: 400,),
//                                   radius: 399,
//                                   onTap: _checkPermissionAndChooseImage,
//                                 )
//                               }
//                               else ...{
//                                 InkWell(
//                                   onTap: _checkPermissionAndChooseImage,
//                                   child: Column(
//                                     children: [
//                                       Image(image: NetworkImage(
//                                           'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
//                                         height: 200,
//                                         width: 200,),
//                                       Text('Select Image', style: TextStyle(color: Colors.cyan))
//                                     ],
//                                   ),
//                                 ),
//                               },
//
//
//
//                               if(_selectedProof!=null) ...{
//                                 InkWell(
//                                   child: Image.file(_selectedProof!, height: 400,),
//                                   radius: 399,
//                                   onTap: _checkPermissionAndChooseProof,
//                                 )
//                               }else ...{
//                                 InkWell(
//                                   onTap: _checkPermissionAndChooseProof,
//                                   child: Column(
//                                     children: [
//                                       Image(image: NetworkImage(
//                                           'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
//                                         height: 200,
//                                         width: 200,),
//                                       Text('Select Image', style: TextStyle(color: Colors.cyan))
//                                     ],
//                                   ),
//                                 ),
//                               },
//
//
//
//
//
//                               SizedBox(height: 15,),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: FilledButton(
//                                   onPressed: () {
//                                     if(_formKey.currentState!.validate()){
//                                       submitForm();
//                                     }
//
//
//                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),),);                  // Navigate to signup screen
//                                   },
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
//                                     backgroundColor: MaterialStateProperty.all(Colors.black),
//                                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     )),
//                                   ),
//                                   child: Text(
//                                     'Register',
//                                     style: TextStyle(fontSize: 16, color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//
//
//
//
//                             ],
//                           ),
//                         ),
//                       ),
//
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   AppStrings.iHaveAnAccount,
//                   style: AppTheme.bodySmall.copyWith(color: Colors.black),
//                 ),
//
//
//                 TextButton(onPressed: () {
//                   Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),);
//                 }, child: Text("Login"))
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
