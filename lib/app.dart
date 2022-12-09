// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:finalproject/profile.dart';
import 'package:flutter/material.dart';
// import 'package:shrine/profile.dart';
//
// import 'add.dart';
// import 'detail.dart';
// import 'home.dart';
import 'add.dart';
import 'challenge.dart';
import 'home.dart';
import 'login.dart';

// TODO: Convert ShrineApp to stateful widget (104)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeChanger',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),

      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        // '/detail': (context) => DetailPage(index: 0,),
        '/add': (context) => AddPage(),
        '/challenge': (context) => challenge(),
        '/tappage': (context) => TabPage(),
        '/profile': (context) => const ProfilePage(),


      },
    );
  }
}

// 앱이 실행 될때 표시할 화면의 함수
class MyWidget extends StatelessWidget {

  // scaffold = 구성된 앱에서 디자인적인 부분을 도와주는 뼈대

  // 화면 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱의 body 부분
      body: Center(
        child: TabPage(),
      ),
    );
  }
}

// Bottom Navigation Bar
// 동적으로 화면을 변화하므로 StatefulWdiget 사용
class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 1; // 처음에 나올 화면 지정 홈임

  // 이동할 페이지
  List _pages = [challenge(), HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: _pages[_selectedIndex], // 페이지와 연결
        ),

        // BottomNavigationBar 위젯
        bottomNavigationBar: BottomNavigationBar(
          //type: BottomNavigationBarType.fixed, // bottomNavigationBar item이 4개 이상일 경우

          // 클릭 이벤트
          onTap: _onItemTapped,

          currentIndex: _selectedIndex, // 현재 선택된 index

          // BottomNavigationBarItem 위젯
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.assured_workload_sharp), label: 'Challenge'),
            BottomNavigationBarItem(icon: Icon(Icons.collections), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'My')

          ],
          backgroundColor: Color(0xFFA4D178),
        )
    );
  }

  void _onItemTapped(int index) {
    // state 갱신
    setState(() {
      _selectedIndex = index; // index는 item 순서로 0, 1, 2로 구성
    });
  }
}
