import 'package:flutter/material.dart';

import 'dchangepass.dart';
import 'dview assigned orders .dart';
import 'dview_profile.dart';
import 'login/screens/login_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: deliver_home(),
    );
  }
}

class deliver_home extends StatefulWidget {
  @override
  _deliver_homeState createState() => _deliver_homeState();
}

class _deliver_homeState extends State<deliver_home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {

    if (index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => deliver_home()));
    }

    else if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => dboy_vprofile(title: '',)));
    }

    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }


    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Home Page')),




        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,


            children: [



              _buildMenuCard('Profile', Icons.person, Colors.blue),

              _buildMenuCard('Orders', Icons.message, Colors.green),

              _buildMenuCard('Password', Icons.notifications, Colors.orange),

              _buildMenuCard('Log out', Icons.settings, Colors.red),



            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout, color: Colors.black),
              label: 'Logout',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue, // Keeps the selected text in blue
          onTap: (_onItemTapped),
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Color color) {
    return InkWell(
      onTap: (){
        if (title == 'Profile' ){

          Navigator.push(context, MaterialPageRoute(builder: (context) => dboy_vprofile(title: '',)));

        }

        else if (title == 'Password'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => dboy_change_pass(title: '',)));
        }

        else if (title == 'Orders'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSlot()));
        }


        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        }


      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
