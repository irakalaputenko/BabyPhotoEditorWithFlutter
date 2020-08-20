import 'dart:core';
import 'dart:io';
import 'package:editbaby/Menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  // HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;

  @override
  void initState() {
    super.initState();
  }

  getImageFile(ImageSource source) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: source);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 1.0,
      //ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuScreen(
                    image: croppedFile,
                  )));
      // _image = croppedFile;
      print(_image.lengthSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_image?.lengthSync());
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 90,
            child: Image.asset("assets/logo.png"),
          ),
          Positioned(
            top: 570.0,
            bottom: 0,
            left: 50.0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => getImageFile(ImageSource.gallery),
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.brown[400]),
                            color: Colors.red[200]),
                        child: Center(
                            child: Icon(Icons.photo,
                                size: 70.0, color: Colors.red[100])),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => getImageFile(ImageSource.camera),
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.brown[400]),
                            color: Colors.red[200]),
                        child: Center(
                            child: Icon(Icons.camera,
                                size: 70.0, color: Colors.red[100])),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
