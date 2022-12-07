import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

  }
  Future<DocumentReference> addMessageToGuestBook
      (String name, String price, String description, String img) {

    return
      FirebaseFirestore.instance
          .collection('product')
          .add(
          <String, dynamic>{
            'img': img,
            'name': name,
            'price': int.parse(price),
            'userid': FirebaseAuth.instance.currentUser!.uid,
            'description': description,
            'createTime': Timestamp.now().toString(),
            'editTime': Timestamp.now().toString(),
            'like': List<dynamic>.empty(),
          });
  }

}


class AddPage extends StatefulWidget {
  const AddPage({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddPageState();
}

class AddPageState extends State<AddPage> {

  File? image;
  PickedFile? pimage;
  final  name = TextEditingController();
  final  price = TextEditingController();

  final  description = TextEditingController();
  final picker = ImagePicker();

  Future getImage() async {

    print("gma.....!!??");
    var iimage = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    print("gma.....!!??22");
    setState(() {
      image = File(iimage!.path);
    });
  }


  Future<dynamic> imgupload(File imageFile) async {
    print('upload start!');
    final fireName = basename(image!.path);
    final destination = '/$fireName';

    return FirebaseStorage.instance.ref(destination).putFile(image!);
  }

  String baseimg = "https://handong.edu/site/handong/res/img/logo.png";

  Future<void> URLFunc() async {
    print("down URL start");

    final dbimg = basename(image!.path);


    final dbfinal = '/$dbimg';
    print("down URL start2222" + dbfinal);
    String temp = await FirebaseStorage

        .instance.ref(dbfinal).getDownloadURL();


    setState(() {
      baseimg = temp;
      print(temp);
    });
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA4D178),
          leading: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueGrey)),
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('사진 업로드'),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey)),
                child: const Text("저장", style: TextStyle(color: Colors.white, fontSize: 13,)),

                onPressed: () async {
                  print(
                      'img is not null!'
                  );
                  if(image != null){
                    await imgupload(image!);
                    await URLFunc();
                  }

                  print("add start!");

                  FirebaseFirestore.instance
                      .collection('product')
                      .add(
                      <String, dynamic>{
                        'img': baseimg,
                        'name': name.text,
                        'price': int.parse(price.text),
                        'userid': FirebaseAuth.instance.currentUser!.uid,
                        'description': description.text,
                        'createTime': DateTime.now().toString(),
                        'editTime': DateTime.now().toString(),
                        'like': List<dynamic>.empty(),
                      }).then((value) => Navigator.pop(context));
                }
            )

          ],
        ),
        body: Builder(
          builder: (context) {
            return ListView(
              children: <Widget>[
                Column(

                    children: <Widget>[
                      image != null?
                      Image.file(
                        image!,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ) :
                      Image.network(
                        "http://handong.edu/site/handong/res/img/logo.png",
                        width: MediaQuery.of(context).size.width,
                        height : 250,
                        fit: BoxFit.cover,
                      ),
                    ]
                ),

                const SizedBox(height: 20,),


                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.photo_camera),
                          onPressed: () async {
                            // image picker
                            print("gma.....!!??3333");
                            await getImage();
                            print("gma.....!!??4444");
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0,),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller:name,
                                  decoration: const InputDecoration(
                                    hintText: 'Product Name',
                                  ),


                                ),

                                const SizedBox(height: 12.0,),
                                TextFormField(controller:price,
                                  decoration: const InputDecoration(
                                    hintText: 'Price',
                                  ),


                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                ),
                                const SizedBox(height: 12.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0,),
                      TextFormField(controller: description,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),


                      ),
                      //Text(product.desc, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.blueAccent)))
                    ],
                  ),
                ),

              ],
            );
          },
        ),

      );

  }
}

