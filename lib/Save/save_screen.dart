import 'dart:core';
import 'dart:io';
import 'package:editbaby/Home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'dart:async';



class SaveScreen extends StatefulWidget {
  final File image;

  SaveScreen({Key key, this.image}) : super(key: key);


  @override
  _SaveScreenState createState() => _SaveScreenState(image);
}

class _SaveScreenState extends State<SaveScreen> {

  File image;

  _SaveScreenState(this.image);





  @override
  void initState() {
    super.initState();
  }
  var filePath;
  // String BASE64_IMAGE;

  Widget _alertDialog() => AlertDialog(
    backgroundColor: Colors.red[200],
    title: Text(
      "Exit without saving?",
      textAlign: TextAlign.center,
    ),
    titleTextStyle: TextStyle(
        color: Colors.red[100], fontSize: 30, fontWeight: FontWeight.w700),
    titlePadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    actions: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                       context,
                      MaterialPageRoute(
                         builder: (context) => HomeScreen(
                       )));
                  },
                  child: Container(
                    height: 50.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.brown[300]),
                        color: Colors.red[300]),
                    child: Center(
                        child: Text("YES", style: TextStyle(color: Colors.red[100]),), ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaveScreen(
                              image: image,
                            )));
                  },
                  child: Container(
                    height: 50.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.brown[300]),
                        color: Colors.red[300]),
                    child: Center(
                        child: Text("NO", style: TextStyle(color: Colors.red[100])),
                  ),
                ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
    shape: RoundedRectangleBorder(
        side: BorderSide(
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(10)
    ),
  );


  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.red[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home,),
            onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return _alertDialog();
              },
            );},

          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment(0.0, 0.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ),
          Positioned(
              top: 0,
              left: 16.0,
              bottom: 0,
              right: 16.0,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    height: 550.0,
                    child: image == null
                        ? Text('No image selected.')
                        : Image.file(image),
                  ),
                ],
              )),
          Positioned(
              top: 550.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _onImageDownloadButtonPressed();
                        },
                        child: Container(
                          height: 60.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.brown[300]),
                              color: Colors.red[300]),
                          child: Center(
                              child: Icon(Icons.save,
                                  size: 50.0, color: Colors.red[100])),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _shareImage();
                        },
                        child: Container(
                          height: 60.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.brown[300]),
                              color: Colors.red[300]),
                          child: Center(
                              child: Icon(Icons.share,
                                  size: 50.0, color: Colors.red[100])),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          )


        ],
      ),

    );


  }
  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load(image.path);
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My image.');
    } catch (e) {
      print('error: $e');
    }
  }

  void _onImageDownloadButtonPressed() async{

      if (image != null && image.path != null) {
        setState(() {
          _onLoading(true);
        });
        GallerySaver.saveImage(image.path).then((path) {

        });
        _onLoading(false);
      }
  }

  void _onImageShareButtonPressed() async{


  }

  void _onLoading(bool t) {
    if(t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return SimpleDialog(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("Downloading")
              ],
            );
          });
    }
    else{
      Navigator.pop(context);
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return SimpleDialog(
              backgroundColor: Colors.red[200],
              title: new Text("DOWNLOAD SUCCESS!", style: TextStyle(color: Colors.red[100]),),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SaveScreen(
                            image: image,
                          )));},
                  child: Center(child: Text('OK', style: TextStyle(color: Colors.red[100]))),
                )
              ],

            );
          });
      Future.delayed(const Duration(seconds: 3),(){
        Navigator.pop(context);
      });
    }
  }
}