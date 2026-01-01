import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../cus_home.dart';
import '../../dboy_home.dart';
import '../../dsignup.dart';
import '../../signup.dart';
import '../../ip.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../values/app_regex.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty && password.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ip(title: '',),
        ),
      );
      return false;
    },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const GradientBackground(
              children: [
                Text(
                  AppStrings.signInToYourNAccount,
                  style: AppTheme.titleLarge,
                ),
                SizedBox(height: 6),
                Text(AppStrings.signInToYourAccount, style: AppTheme.bodySmall),
              ],
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [



                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('Email')),
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "please enter valid username";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15,),

                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('Password')),

                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "please enter valid password ";
                        }
                        return null;
                      },
                      obscureText: true,
                    ),




                  SizedBox(height: 15,),
                      FilledButton(
                        onPressed: _isLoading ? null : () {
                          _send_data();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                        child: _isLoading
                            ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,))
                            : Text(
                                'Login',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                      ),


                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                // const SizedBox(height: 15),
                // ElevatedButton(
                //   onPressed: () =>




                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => user_reg(),
                          ),
                        );
                      },
                      child: const Text("New user? Register here!",
                      style: TextStyle(fontSize: 16, color: Colors.black,),)

                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(width: 4),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dboyreg(),
                            ),
                          );
                        },
                        child: Text("Join as Delivery Boy! ",
                          style: TextStyle(fontSize: 16, color: Colors.black,),)
                    ),
                  ],
                ),
              ],
            )

          ],
        ),
      ),
    );
  }


  bool _isLoading = false;

  void _send_data() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    String uname = emailController.text;
    String pass = passwordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_login_post/');
    try {
      final response = await http.post(urls, body: {
        'username': uname,
        'password': pass,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'];
          String type = jsonDecode(response.body)['type'];
          sh.setString("lid", lid);

          if (type == 'user'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>cus_home(),),);
          }
          else if(type == "dboy"){
            String dboyStatus = jsonDecode(response.body)['status_dboy'] ?? 'approved';
            if (dboyStatus == 'approved') {
                 Fluttertoast.showToast(msg: 'Welcome !');
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>deliver_home(),),);
            } else {
                 Fluttertoast.showToast(msg: 'Your account is pending admin approval.');
            }
          }
          else{
            Fluttertoast.showToast(msg: 'Not Found !');
          }
        } else {
          Fluttertoast.showToast(msg: 'Invalid Credentials');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
        if (mounted) {
            setState(() {
                _isLoading = false;
            });
        }
    }
  }
}
