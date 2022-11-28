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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 150.0),
            Column(
              children:  <Widget>[
                const Text('삶을 바꾸는 작은 습관', textScaleFactor: 1.5,),
                const SizedBox(height: 16.0),
                const Text('Life controller' , textScaleFactor: 3.5,),
                const SizedBox(height: 32.0),
                const Text('   why not',  textScaleFactor: 1.5,),
                const Text('Change your life?',  textScaleFactor: 1.5,),
                SizedBox(height: 70.0),
                Image.asset('images/google.jpg', height: 70, width: 350),
                Image.asset('images/kakao.jpg', height: 70, width: 350),
                Image.asset('images/naver.jpg', height: 70, width: 350),
              ],

            ),],
        ),
      ),
    );
  }
}
