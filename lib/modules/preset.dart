import 'dart:io';

import 'package:flutter/material.dart';
import 'package:editbaby/Menu/menu_screen.dart';
class PresetEditor extends StatefulWidget {
  final File image;

  PresetEditor({Key key, this.image}) : super(key: key);
  @override
  _PresetEditorState createState() => _PresetEditorState(image);
}
class _PresetEditorState extends State<PresetEditor> {
  TextEditingController name = TextEditingController();
  File image;

  _PresetEditorState(this.image);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuScreen(
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
                      height: 450.0,
                      child: image == null
                          ? Text('No image selected.')
                          : Image.file(image),
                    ),
                  ],
                )),
            Positioned(
              top: screenHeight * 0.68,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 120.0,
                      child: ListView.builder(
                        // itemCount: sticker.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(left: 16.0),
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    //image: AssetImage(sticker[index].image),
                                      fit: BoxFit.fill),
                                  border: Border.all(color: Colors.pink, width:2.5)),

                              //Text(processing[index].name)
                            );
                          })),
                ],
              ),
            )
          ],
        ));
  }
}
