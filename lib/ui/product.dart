import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
//    getAssetsFromRemoteStorage();
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
                      future: _getFirebaseImage(snapshots.data.documents[index]['imageId']),
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
//                FirebaseStorage.instance.ref().child(snapshots.data.documents[index]['imageId']).getDownloadURL().
//                  then((value) => setState((){
//                      print("url : ${value}");
////                    return Image.network(value,
////                      width: MediaQuery.of(context).size.width,
////                    );
//                  }));

                return Text("${snapshots.data.documents[index]['imageId']}");
              }
          );
        },
      ),
//      ListView(
//        children: <Widget>[
//          Container(
////            child: chaiUrl == null ? Image.asset("images/drink.png") :
////            Image.network(
////              chaiUrl,
////              width: MediaQuery.of(context).size.width,
////            ),
//              child: getProductImageUsingImageId("chai.png"),
//          ),
//          Container(
//            child: chaiUrl == null ? Image.asset("images/drink.png") :
//            Image.network(
//              chaiUrl,
//              width: MediaQuery.of(context).size.width,
//            ),
//          ),
//          Container(
//            child: chaiUrl == null ? Image.asset("images/drink.png") :
//            Image.network(
//              chaiUrl,
//              width: MediaQuery.of(context).size.width,
//            ),
//          ),
//          Container(
//            child: chaiUrl == null ? Image.asset("images/drink.png") :
//            Image.network(
//              chaiUrl,
//              width: MediaQuery.of(context).size.width,
//            ),
//          ),
//        ],
//      ),
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


//  void getAssetsFromRemoteStorage()  {
//    FirebaseStorage.instance.ref().child("coffee.png").getDownloadURL().then(
//            (value) => setState((){
//              chaiUrl = value;
//            })
//    );
//
//  }
//
//  Widget getProductImageUsingImageId(imageId) {
//    var imgUrl;
//    FirebaseStorage.instance.ref().child(imageId).getDownloadURL().then(
//            (value) => setState((){
//              imgUrl = value;
//        })
//    );
//
//    return Image.asset(imgUrl);
//  }
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
