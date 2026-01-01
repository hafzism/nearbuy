
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cus_home.dart';







void main() {
  runApp(const ViewSlot());
}

class ViewSlot extends StatelessWidget {
  const ViewSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF184A2C)),
        useMaterial3: true,
      ),
      home: const viewproduct(title: ''),
    );
  }
}

class viewproduct extends StatefulWidget {
  const viewproduct({super.key, required this.title});

  final String title;

  @override
  State<viewproduct> createState() => _viewproductState();
}

class _viewproductState extends State<viewproduct> {

  final Uri _url = Uri.parse('https://flutter.dev');


  String rating="";

  _viewproductState(){
    ViewSlot();
  }

  List<String> id_ = <String>[];
  List<String> pname_= <String>[];
  List<String> price_= <String>[];
  List<String> about_= <String>[];
  List<String> photo_= <String>[];
  List<String> cat_ = <String>[];
  List<String> shopid_ = <String>[];
  List<String> location_ = <String>[];
  List<String> place_ = <String>[];
  List<String> shopname_ = <String>[];
  List<String> district_ = <String>[];
  List<String> state_ = <String>[];
  List<String> contactno_ = <String>[];


  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> ViewSlot() async {
    List<String> id = <String>[];
    List<String> price = <String>[];
    List<String> pname = <String>[];
    List<String> about = <String>[];
    List<String> photo = <String>[];
    List<String> cat = <String>[];
    List<String> shopid = <String>[];
    List<String> place = <String>[];
    List<String> shopname = <String>[];
    List<String> location = <String>[];
    List<String> district = <String>[];
    List<String> state = <String>[];
    List<String> contactno = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('cid').toString();
      // String sid = sh.getString('shopid').toString();
      String shopidString = shopid.join(',');

      // Store the concatenated string in SharedPreferences
      sh.setString('shp', shopidString);
      // sh.setString("shp", shopid).toString();
      String url = '$urls/user_view_products/';

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,

      });
      print(data.body);  // Print the raw data

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];
      print(arr.length);
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        price.add(arr[i]['price'].toString());
        pname.add(arr[i]['name'].toString());
        cat.add(arr[i]['cat'].toString());
        about.add(arr[i]['about'].toString());
        photo.add(sh.getString('img_url').toString()+arr[i]['image']);
        shopid.add(arr[i]['shop'].toString());
        place.add(arr[i]['place'].toString());
        shopname.add(arr[i]['shopname'].toString());
        district.add(arr[i]['district'].toString());
        state.add(arr[i]['state'].toString());
        contactno.add(arr[i]['contactno'].toString());
        location.add(arr[i]['location'].toString());
      }

      setState(() {
        id_ = id;
        price_ = price;
        about_ = about;
        photo_ = photo;
        pname_ = pname;
        cat_=cat;
        shopid_ = shopid;
        place_ = place;
        shopname_ = shopname;
        location_ = location;
        district_ = district;
        state_ = state;
        contactno_ = contactno;

      });
      print(shopid);
      print('hhh');

      print(statuss);
    } catch (e) {
      print("Network Error: $e");
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  TextEditingController tc= new TextEditingController();
  final formcontroll = GlobalKey<FormState>();


  void _showInputDialog(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController tc = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: tc,
              decoration: InputDecoration(hintText: "Enter quantity"),
              keyboardType: TextInputType.number, // Only allow number input
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                // Check if the input is a valid positive number
                int? number = int.tryParse(value);
                if (number == null || number <= 0) {
                  return 'Please enter a positive number';
                }
                return null; // Validation passed
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  SharedPreferences sh = await SharedPreferences.getInstance();
                  String url = sh.getString('url').toString();
                  String lid = sh.getString('lid').toString();
                  String selmid = sh.getString('selmid').toString();

                  final urls = Uri.parse('$url/user_add_to_cart/');
                  try {
                    final response = await http.post(urls, body: {
                      'lid': lid,
                      'pid': selmid,
                      'qty': tc.text.trim(), // Use .trim() to remove whitespace
                    });

                    if (response.statusCode == 200) {
                      String status = jsonDecode(response.body)['status'];

                      if (status == 'ok') {
                        Fluttertoast.showToast(msg: 'Added to cart');
                        Navigator.of(context).pop();
                      }

                      else if (status == 'no'){
                        Fluttertoast.showToast(msg: 'Not enough stock ');
                      }

                      else {
                        Fluttertoast.showToast(msg: 'Failed to add to cart');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Error: ${response.statusCode}');
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  TextEditingController reviewController = TextEditingController();
  void _showRatingDialog(BuildContext context, id) {
    final reviewController = TextEditingController();
    double rating = 3; // Default initial rating
    String errorMessage = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send rating for shop'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  controller: reviewController,
                  decoration: InputDecoration(hintText: "Enter Review for Shop"),

                  validator:(value){
                    if (value == null || value.isEmpty){
                      return "please submit your reviews";
                    }

                    String pattern = r'^[a-zA-Z0-9]+$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'District name can only contain letters, numbers';
                    }
                    return null;
                  }
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              Container(
                height: 30,
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (ratin) {
                    rating = ratin;
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 80),
                ElevatedButton(
                  onPressed: () async {
                    // Validation logic
                    if (reviewController.text.isEmpty) {
                      setState(() {
                        errorMessage = 'Please enter a review.';
                      });
                      return; // Exit early if validation fails
                    }

                    // Assuming rating is required
                    if (rating < 1) {
                      setState(() {
                        errorMessage = 'Please provide a rating.';
                      });
                      return; // Exit early if validation fails
                    }

                    // Proceed with your API call if validations pass
                    SharedPreferences sh = await SharedPreferences.getInstance();
                    String url = sh.getString('url').toString();
                    String lid = sh.getString('lid').toString();

                    final urls = Uri.parse('$url/user_send_rating/');
                    try {
                      final response = await http.post(urls, body: {
                        'rating': rating.toString(),
                        'lid': lid,
                        'planid': id,
                        'review': reviewController.text.toString(),
                      });

                      if (response.statusCode == 200) {
                        String status = jsonDecode(response.body)['status'];
                        if (status == 'ok') {
                          Fluttertoast.showToast(msg: 'Review added');
                        } else {
                          Fluttertoast.showToast(msg: 'Failed to send');
                        }
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )

                ,
              ],
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cus_home()),);


          },),

          backgroundColor: Colors.white,
          foregroundColor: Colors.black,

          title: Text('Products'),
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
                          child: Stack(
                            children: [
                              // Background image
                              Container(
                                width: double.infinity,
                                height: 450,
                                child: Image.network(
                                  photo_[index], // Your image URL here
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Overlay text

                              Positioned(
                                top: 10,
                                right: 20,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        shopname_[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${place_[index]}, ${district_[index]}, ${state_[index]}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        contactno_[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          _launchUrl(Uri.parse(location_[index].toString()));
                                        },
                                        child: Text("Map"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              // Content below image
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  color: Colors.black.withOpacity(0.5), // Overlay color
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pname_[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        cat_[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Price: ${price_[index]}/-',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Text(
                                        about_[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),




                              // Button on top right
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: ElevatedButton(
                                  onPressed: () async {

                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    sh.setString("selmid", id_[index]);


                                    _showInputDialog(context);




                                    // Button action
                                  },
                                  child: Text(
                                    'Add to cart',
                                    style: TextStyle(
                                      // color: Colors.white,
                                      backgroundColor: Color.fromARGB(
                                          157, 255, 255, 255),

                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),


                                ),
                              ),

                              Positioned(
                                top: 10,
                                left: 0,

                                child: ElevatedButton(
                                  onPressed: () async {

                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    sh.setString("selmid", id_[index]);


                                    _showRatingDialog(context,shopid_[index]);

                                    // Button action
                                  },
                                  child: Text(
                                    'Review',
                                    style: TextStyle(
                                      // color: Colors.white,
                                      backgroundColor: Color.fromARGB(
                                          157, 255, 255, 255),

                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),



                            ],
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