
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'model/product.dart';


bool isDescending = false;
StreamSubscription<QuerySnapshot>? productSubscription;

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  List<Product> products = [];
  get productss => products;
  Future<void> init() async {
    print("init start!");
    Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {

      productSubscription = FirebaseFirestore.instance
          .collection('product')
          .orderBy('price', descending: false)
          .snapshots()
          .listen((snapshot) {

        for (final document in snapshot.docs) {
          print(document.data()['name'] as String);
          productss.add(
            Product(
              name: document.data()['name'] as String,
              price: document.data()['price'] as int,
              img: document.data()['img'] as String,
              description: document.data()['description'] as String,
              createTime: document.data()['createTime'] as String,
              editTime: document.data()['editTime'] as String,
              userid: document.data()['userid'] as String,
              like: document.data()['like'] as List,
            ),
          );
          print("init finish");
        }

      });


    });
  }


  // List<Card> buildGridCards(BuildContext context){
  //
  //
  //   final NumberFormat formatter = NumberFormat.simpleCurrency(
  //       locale: Localizations.localeOf(context).toString());
  //
  //   return widget.productss.map((product) {
  //     return Card(
  //       clipBehavior: Clip.antiAlias,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: 18 / 11,
  //             child: Image.network(
  //               product.img,
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
  //               child: Column(
  //                 // TODO: Align labels to the bottom and center (103)
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     product.name,
  //                     maxLines: 1,
  //                   ),
  //                   const SizedBox(height: 8.0),
  //                   Text(
  //                     formatter.format(product.price),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         style: TextButton.styleFrom(
  //                           minimumSize: Size.zero,
  //                           padding: EdgeInsets.zero,
  //                           tapTargetSize:
  //                           MaterialTapTargetSize.shrinkWrap,
  //                         ),
  //                         onPressed: () { //25. The "more" button navigates to the Detail Page
  //                           // Navigator.push(context, MaterialPageRoute
  //                           //   (builder: (context)=>DetailPage(product: product,)));
  //                         },
  //                         child: const Text(
  //                           "more",
  //                           style: TextStyle(fontSize: 10.0),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {

    print("before return init");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.person,
              semanticLabel: 'profile',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          title:const Text('Main'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.add,
                  semanticLabel: 'add',
                ),
                onPressed:() async{
                  Navigator.pushNamed(context, '/add');
                }
            ),
          ],

        ),
        body:

        Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('product')
                    .snapshots(),

                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  print("builder~~!!!");
                  List<DocumentSnapshot>? list;

                  if (snapshot.hasError) {
                    print("error~~!!!");
                    return Text('Error: ${snapshot.error}');
                  }
                  if(snapshot.data == null) {
                    return const CircularProgressIndicator();
                  }
                  list = snapshot.data?.docs.cast<DocumentSnapshot<Object?>>();
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      print("waiting~~!!!"+snapshot.data!.docs.toString());
                      return Text('Loading...');
                    default:
                      print("default~~!!!");
                      // return _buildGrid(context,list!);
                      init();
                      print("in default init");
                      if(products!=null){
                        print("notnull!"+products.first.name);
                      }

                      // return productSubscription?.map((products){
                      return


                        ListView(

                            prototypeItem: Card(
                                child: Container(

                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text('name'),

                                        ElevatedButton(
                                            child: Text("See More"),
                                            onPressed: () {

                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => DetailPage(
                                              //
                                              //             )));
                                            }),

                                      ],
                                    )))
                        );




                  }
                })


        )


    );


  }

}

//
//
// class CustomCard extends StatelessWidget {
//   CustomCard({required this.title, required this.description});
//
//   final Map<String, dynamic> title;
//   final Map<String, dynamic> description;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: Container(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Column(
//               children: <Widget>[
//                 Text("title"),
//
//                 ElevatedButton(
//                     child: Text("See More"),
//                     onPressed: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => DetailPage(
//                       //             title: title, description: description)));
//                     }),
//               ],
//             )));
//   }
// }
//