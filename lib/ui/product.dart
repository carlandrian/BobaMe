import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'custom_widgets/custom_widgets.dart';



class ProductScreen extends StatefulWidget {
  static const String id = "product_screen";
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _auth = FirebaseAuth.instance;
  var firestoreDb = Firestore.instance.collection('BobaProducts').snapshots();

  @override
  void initState() {
    super.initState();
    isCurrentUserLoggedIn();
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: BobaBannerImage(),
      ),
      body: StreamBuilder(
        stream: firestoreDb,
        builder: (context, snapshots) {
          if(!snapshots.hasData) return CircularProgressIndicator();

          return ListView.builder(
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, int index) {
                  return Container(
                    child: FutureBuilder(
                      future: _getProducts(context, snapshots.data.documents[index]),//_getFirebaseImage(snapshots.data.documents[index]['imageId']),
                      builder: (context, imageSnapshots) {
                        if(imageSnapshots.connectionState == ConnectionState.done) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.85,
                            width: MediaQuery.of(context).size.width,
                            child: imageSnapshots.data,
                          );
                        }

                        if(imageSnapshots.connectionState == ConnectionState.waiting) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.85,
                            width: MediaQuery.of(context).size.width,
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  );
              }
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  child: Image.asset("images/boba_profile_icon.png"),
                  onTap: () {
                    print('profile clicked');
                  },
              ),
              InkWell(
                  child: Image.asset("images/boba_drink_icon.png"),
                  onTap: () {
                    print('shop clicked');
                  },
              ),
              InkWell(
                  child: Image.asset("images/shopping_cart_icon.png"),
                  onTap: () {
                    print('shopping cart clicked');
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isCurrentUserLoggedIn() async {
    final currentUser = await _auth.currentUser();
    if(currentUser != null) {
      print("user is logged in");
    }else{

    }
  }

  @override
  void dispose() {
    super.dispose();
    _auth.signOut();
    print("user has signed-out");
  }
}

Future<Widget> _getFirebaseImage(url) async {
  Image m;
  await FirebaseStorage.instance.ref().child(url).getDownloadURL().then((value) => {
    m = Image.network(
      value.toString()
    )
  });

  return m;
}

Future<Widget> _getProducts(context, firebaseDocument) async {
  Image productImage;
  await FirebaseStorage.instance.ref().child(firebaseDocument['imageId']).getDownloadURL()
  .then((value) => {
    productImage = Image.network(value.toString())
  });

  // put the image and its name, text and price in a stack
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      productImage,
      Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.55,
          ),
          Column(

            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 12.5,
              ),
              Text(
                firebaseDocument['name'].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height / 6.5,
                child: Text(
                  firebaseDocument['description'].toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,

                ),
              ),
            ],
          ),
        ],

      ),
    ],
  );

}
