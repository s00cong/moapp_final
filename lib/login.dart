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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);

  await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(<String, dynamic>{
    'email' : FirebaseAuth.instance.currentUser!.email.toString(),
    'name' : FirebaseAuth.instance.currentUser!.displayName.toString(),

    'uid' : FirebaseAuth.instance.currentUser!.uid.toString(),
  });
  // Once signed in, return the UserCredential
  print(FirebaseAuth.instance.currentUser?.displayName);
  if(FirebaseAuth.instance.currentUser!=null)
    Navigator.pushNamed(context, '/home');


  // return await FirebaseAuth.instance.signInWithCredential(credential);


}


// Example code of how to sign in anonymously.
void signInAnonymously(BuildContext context) async {
  try {

    final userCredential =
    await FirebaseAuth.instance.signInAnonymously();

    print("Signed in with temporary account.");

    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(<String,dynamic>{
      'uid' : FirebaseAuth.instance.currentUser!.uid.toString(),
    })
    ;

  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        print("Unknown error.");
    }
  }
  print(FirebaseAuth.instance.currentUser?.uid);

  Navigator.pushNamed(context, '/home');
}




class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

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

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {

                      signInWithGoogle(context);

                    },
                    child: const Text('Sign in with Google'),
                  ),
                ),

                TextButton(onPressed: ()async {
                  signInAnonymously(context);
                }, child: const Text('Guest'),
                )
              ],

            ),],
        ),
      ),
    );
  }
}


