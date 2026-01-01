import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'login/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearbuy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ip(title: 'Nearbuy Setup'),
    );
  }
}

class ip extends StatefulWidget {
  const ip({super.key, required this.title});

  final String title;

  @override
  State<ip> createState() => _ipState();
}

class _ipState extends State<ip> {

  TextEditingController ipcontroller = new TextEditingController(text: "https://nearbuy-project.onrender.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Hidden debug info or instructions could go here
            SizedBox(height: 20),
            Text("Connecting to Nearbuy Server..."),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {senddata();}, child: Text('Start App'))
          ],
        ),
      ),
    );
  }
  
  void senddata()async {
    // Hardcoded production URL for ease of use
    String prodUrl = "https://nearbuy-project.onrender.com";
    
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("url", prodUrl + "/product_finder");
    sh.setString("img_url", prodUrl);
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
