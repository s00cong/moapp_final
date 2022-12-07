
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
int screenIndex = 0;
List<Widget> screenList = [Text('홈스크린'), Text('게시판 스크린'), Text('마이 스크린')];

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('실천 인증 게시판' , style : TextStyle(
              color : Colors.white70
          )),
          backgroundColor: Color(0xFFA4D178),
          actions: [ // 앱바 오른쪽에 아이콘 넣기
            IconButton(
                icon: Icon(Icons.add),
                onPressed: (){
                  Navigator.push (
                    context,
                    MaterialPageRoute(builder: (context) => const AddPage()),
                  );
                }
                ),
            IconButton(icon: Icon(Icons.search), onPressed: null),
          ],
        ),

        body: const Center(
          child: Text('Hello World'),
        ),
    bottomNavigationBar: BottomNavigationBar(

    currentIndex: screenIndex,
    items: [
    BottomNavigationBarItem(icon: Icon(Icons.assured_workload_sharp), label: 'Challenge'),
    BottomNavigationBarItem(icon: Icon(Icons.collections), label: 'Chat'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'My')
    ],
    onTap: (value) {
    setState(() { //상태 갱신이 되지 않으면 동작을 하지 않음
    screenIndex = value;
    }
    );
    },
        backgroundColor: Color(0xFFA4D178),
      ),
      ),
    );
  }
}