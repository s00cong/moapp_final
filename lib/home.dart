
import 'dart:async';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();
}

StreamSubscription<QuerySnapshot>? productSubscription;
int screenIndex = 0;
List<Widget> screenList = [Text('홈스크린'), Text('게시판 스크린'), Text('마이 스크린')];

class HomePageState extends State<HomePage> {




  List<Product> products = [];

  get productss => products;

  Future<void> init() async {
    print("init start!");
    Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      productSubscription = FirebaseFirestore.instance
          .collection('product')
          .orderBy('createTime', descending: false)
          .snapshots()
          .listen((snapshot) {
        for (final document in snapshot.docs) {
          print(document.data()['name'] as String);
          productss.add(
            Product(
              img: document.data()['img'] as String,
              name: document.data()['name'] as String,
              Day:document.data()['Day'] as int,
              userid: document.data()['userid'] as String,
              description: document.data()['description'] as String,
              createTime: document.data()['createTime'] as String,
              editTime: document.data()['editTime'] as String,
              like: document.data()['like'] as List,
            ),
          );
          print("init finish");
        }
      });
    });
  }


    @override
    Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Welcome to Flutter',
          home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('실천 인증 게시판', style: TextStyle(
                    color: Colors.white
                )),
                backgroundColor: Color(0xFFA4D178),
                actions: [ // 앱바 오른쪽에 아이콘 넣기
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPage()),
                        );
                      }
                  ),
                  IconButton(icon: Icon(Icons.search), onPressed: null),
                ],
              ),

              body:ListView(
                  children: <Widget>[
                    SizedBox(height: 8.0,),
                    SizedBox(height: 8.0,),
                    // Container(child: _buildBody(context)),
                  ]
              ),
            resizeToAvoidBottomInset: false,
          )
          );


    }


}



  class Product {
    Product( {
      required this.name,
      required this.img,
      required this.description,
      required this.userid,
      required this.createTime,
      required this.editTime,
      required this.like,
      required this.Day,});

    final String name;
    final String img;
    final int Day;
    final String description;
    final String createTime;
    final String editTime;
    final String userid;
    final List like;


    Product.fromMap(Map<String, dynamic>? map,)
        :
          name = map!['name'],
          img = map['img'],
          description = map['description'],
          createTime = map['createTime'],
          editTime = map['editTime'],
          Day = map['Day'],
          userid = map['userid'],
          like = map['like'];

  }