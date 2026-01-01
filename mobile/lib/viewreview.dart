import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'cus_home.dart';





void main() {
  runApp(const viewreviews());
}

class viewreviews extends StatelessWidget {
  const viewreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF184A2C)),
        useMaterial3: true,
      ),
      home: const viewreviews_page(title: ''),
    );
  }
}

class viewreviews_page extends StatefulWidget {
  const viewreviews_page({super.key, required this.title});

  final String title;

  @override
  State<viewreviews_page> createState() => _viewreviews_pageState();
}

class _viewreviews_pageState extends State<viewreviews_page> {

  _viewreviews_pageState(){
    viewreviews();
  }

  List<String> id_ = <String>[];
  List<String> review_= <String>[];
  List<String> date_= <String>[];
  List<String> rating_= <String>[];
  List<String> name_= <String>[];
  List<String> email_= <String>[];
  List<String> photo_= <String>[];

  get status => null;

  Future<void> viewreviews() async {

    List<String> id = <String>[];
    List<String> review= <String>[];
    List<String> date= <String>[];
    List<String> rating= <String>[];
    List<String> name= <String>[];
    List<String> email= <String>[];
    List<String> photo= <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('planid').toString();
      String url = '$urls/user_view_reviews_on_plan/';
      String img_url = sh.getString('img_url').toString();

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid
      });
      print(data.body);  // Print the raw data

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        review.add(arr[i]['review']);
        date.add(arr[i]['date']);
        name.add(arr[i]['name']);
        rating.add(arr[i]['rating']);
        email.add(arr[i]['email']);
        photo.add(img_url+arr[i]['photo']);

      }

      setState(() {
        id_ = id;
        review_ = review;
        date_ = date;
        rating_ = rating;
        name_ = name;
        email_ = email;
        photo_ = photo;
      });

      print(statuss);
    } catch (e) {
      print("Network Error: $e");
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => sendreviews(),));
            // Add your action here
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cus_home()),);


          },),

          backgroundColor: Colors.white,
          foregroundColor: Colors.black,

          title: Text("Plan reviews"),
        ),

        body: Container(decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/'), fit: BoxFit.cover),
        ),
          child: ListView.builder(

            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.all(5.0),
            // shrinkWrap: true,
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(photo_[index]),
                            ),
                            title: Text(name_[index]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(email_[index]),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Text(rating_[index]),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(review_[index]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),



      ),
    );
  }
}