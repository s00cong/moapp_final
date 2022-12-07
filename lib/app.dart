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

import 'package:flutter/material.dart';
// import 'package:shrine/profile.dart';
//
// import 'add.dart';
// import 'detail.dart';
// import 'home.dart';
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

        primarySwatch: Colors.blue,
      ),

      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        // '/detail': (context) => DetailPage(index: 0,),
        // '/add': (context) => AddPage(),
        // // '/edit': (context) => EditPage(),
        // '/profile': (context) => const ProfilePage(),


      },
    );
  }
}
