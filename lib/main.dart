import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'        // new
    hide EmailAuthProvider, PhoneAuthProvider;           // new
import 'package:firebase_core/firebase_core.dart';       // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';                 // new

import 'firebase_options.dart';                          // new

import 'app.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


