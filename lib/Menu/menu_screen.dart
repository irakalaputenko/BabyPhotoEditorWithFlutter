import 'dart:convert';
import 'dart:core';
import 'dart:async' show Future;
import 'dart:io';
import 'package:editbaby/Save/save_screen.dart';

//import 'package:editbaby/entities/note.dart';
import 'package:editbaby/modules/addsticker.dart';
import 'package:editbaby/modules/frame.dart';
import 'package:path/path.dart';

import 'package:editbaby/modules/preset.dart';
//import 'package:editbaby/modules/sticker.dart';
import 'package:editbaby/modules/textview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imageLib;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:editbaby/filter/photofilters.dart';



//import 'package:editbaby/modules/text.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatefulWidget {
  final File image;

  MenuScreen({Key key, this.image}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState(image);
}

class _MenuScreenState extends State<MenuScreen> {
  File image;

  _MenuScreenState(this.image);

  Future _future;

  // List<Processing> processing;
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;


  Future getImage(context) async {
    imageFile = image;
    fileName = basename(imageFile.path);
    var image1 = imageLib.decodeImage(imageFile.readAsBytesSync());
    image1 = imageLib.copyResize(image1, width: 600);
    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          appBarColor: Colors.red[200],
          title: Center( child: Text("Filters")),
          image: image1,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      print(imageFile.path);
    }
  }

  Future<String> loadJson() async =>
      await rootBundle.loadString('assets/preset_filters.json');

  @override
  void initState() {
    _future = loadJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save,),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaveScreen(
                              image: image,
                            )));
              },
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
              top: screenHeight * 0.797,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 64.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48.0),
                            topRight: Radius.circular(48.0)),
                        color: Colors.red[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          onPressed: () => _textEditor(context),
                          child: Container(
                            child: Center(
                                child: Icon(Icons.text_format,
                                    size: 40.0, color: Colors.red[100])),
                          ),
                        ),
                    FlatButton(
                      onPressed: () => _stickerEditor(context),
                      child: Container(
                        child: Center(
                            child: Icon(Icons.star_border,
                                size: 40.0, color: Colors.red[100])),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => _frameEditor(context),
                      child: Container(
                        child: Center(
                            child: Icon(Icons.filter_frames,
                                size: 40.0, color: Colors.red[100])),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => getImage(context),
                      child: Container(
                        child: Center(
                            child: Icon(Icons.filter_vintage,
                                size: 40.0, color: Colors.red[100])),
                      ),
                    ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  _textEditor(context) async {
    final value = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TextEditor(
                  image: image,
                )));
  }

  _stickerEditor(context) async {

    final value = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StickerEditor1(
                  image: image,
                )));
  }

  _frameEditor(context) async {
    final value = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FrameEditor(
                  image: image,
                )));
  }

  _presetEditor(context) async {
      final value = await Navigator.push(
        context,
       MaterialPageRoute(
          builder: (context) => PresetEditor(
           image: image,
       )));
  }
}
