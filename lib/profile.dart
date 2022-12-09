
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  bool guest = true;
  String photoUrl = FirebaseAuth.instance.currentUser!.photoURL.toString();


  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser!.email.toString() != 'null'){
      print("null??? "+ FirebaseAuth.instance.currentUser!.email.toString());
      guest = false;
    }else {

      photoUrl = "https://handong.edu/site/handong/res/img/logo.png";
      guest = true;
    }
    print("is guest?"+guest.toString());

    // TODO: implement build
    return Scaffold(

        appBar: AppBar(
          actions:<Widget> [
            IconButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(Icons.logout)
            ),
          ],
        ),

        body: Padding(
            padding: const EdgeInsets.all(50.0),

            child:ListView(

              children: <Widget> [
                Center(
                  child:
                  Image.network(guest ? photoUrl
                      : FirebaseAuth.instance.currentUser!.photoURL.toString()),

                ),
                const SizedBox(height: 45,),
                Center(
                  child:   Text(guest? "게스트" : "< "+FirebaseAuth.instance.currentUser!.displayName.toString()+" >",
                    style: const TextStyle(fontSize: 25),),
                ),

                const SizedBox(height: 15,),
                Center(
                  child:
                      guest? const SizedBox(height: 5.0,):
                  TextButton(

                    child: const Text(
                        " 프로필 변경 ", style: TextStyle(fontSize: 15)),
                    onPressed: () {  },),
                ),
                const SizedBox(height: 10,),
                Center(
                  child:
                  guest? ElevatedButton(onPressed:(){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/login');

                  }, child: Text("구글 로그인 하기")):
                  ElevatedButton(onPressed:(){
                    Navigator.pushNamed(context, '/challenge');

                  },
                      child: Text("내 challenge 보기")
                  ),
                ),
                Center(
                  child:
                  guest? const SizedBox(height: 5.0,):
                  ElevatedButton(onPressed:(){},

                      child: Text("내 달력보기")
                  ),
                ),







              ],
            )

        )
    );


  }

}