import 'package:flutter/material.dart';
import 'package:product_finder/login/screens/login_screen.dart';
import 'package:product_finder/view_profile.dart';
import 'package:product_finder/view_reply.dart';
import 'package:product_finder/viewcart.dart';
import 'package:product_finder/viewproduct.dart';

import 'appfeedback.dart';
import 'changepass.dart';
import 'noti_new.dart';
import 'offers_new.dart';
import 'order_history.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: cus_home(),
    );
  }
}

class cus_home extends StatefulWidget {
  @override
  _cus_homeState createState() => _cus_homeState();
}

class _cus_homeState extends State<cus_home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {

    if (index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => cus_home()));
    }

    else if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfile(title: '',)));
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
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.black), // Cart Icon
              SizedBox(width: 8), // Space between icon and text
              Text(
                'NearBuy',
                style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold,), // Text color
              ),
            ],
          ),
          backgroundColor: Colors.white, // Optional: Change AppBar color
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://pluspng.com/img-png/new-balance-logo-png--2000.png'),
                      backgroundColor: Colors.transparent, // Optional
                    ),

                    SizedBox(height: 10),
                    Text('Welcome To NearBuy!', style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text('Find Nearby products', style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => cus_home()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfile(title: '',)));
                },
              ),


              ListTile(
                leading: Icon(Icons.shop_2_outlined),
                title: Text('Products'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewproduct(title: '',)));
                },
              ),


              ListTile(
                leading: Icon(Icons.shopping_cart_outlined),
                title: Text('Cart'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Viewcart(title: '',)));
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt_outlined),
                title: Text('Previous Orders'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => U(title: '',)));
                },
              ),
              ListTile(
                leading: Icon(Icons.chat_bubble_outline),
                title: Text('Complaints'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_rply(title: '',)));
                },
              ),

              ListTile(
                leading: Icon(Icons.notifications_active_outlined),
                title: Text('Notifications'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_noti(title: '',)));
                },
              ),

              ListTile(
                leading: Icon(Icons.password_outlined),
                title: Text('Change Password'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserChangePass(title: '',)));
                },
              ),
              ListTile(
                leading: Icon(Icons.local_offer_outlined),
                title: Text('Offers'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewoffers(title: '',)));
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback_outlined),
                title: Text('App feedback'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => appfeedback(title: '',)));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log out'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),



        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [

              _buildMenuCard('Profile', Icons.person, Colors.blue),

              _buildMenuCard('Products', Icons.shop_2_outlined, Colors.green),

              _buildMenuCard('Cart', Icons.shopping_cart_outlined, Colors.green),

              _buildMenuCard('Orders', Icons.local_offer_outlined, Colors.blue),

              _buildMenuCard('Offers', Icons.percent_outlined, Colors.blue),

              _buildMenuCard('Notifictions', Icons.notifications_active_outlined, Colors.green),

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

          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfile(title: '',)));

        }

        else if (title == 'Products'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => viewproduct(title: '',)));
        }

        else if (title == 'Orders'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => U(title: '',)));
        }

        else if (title == 'Offers'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => viewoffers(title: '',)));
        }

        else if (title == 'Cart'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Viewcart(title: '',)));
        }

        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => view_noti(title: '',)));
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
