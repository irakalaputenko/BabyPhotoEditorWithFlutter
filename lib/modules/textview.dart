import 'dart:io';
import 'package:editbaby/modules/text.dart';
import 'package:editbaby/Menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zefyr/zefyr.dart';
import 'package:screenshot/screenshot.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'Dart:ui' as ui;
import 'Dart:async';
import 'Dart:typed_data';

import 'package:flutter/services.Dart';
import 'package:path_provider/path_provider.Dart';


class TextEditor extends StatefulWidget {
  final File image;

  TextEditor({Key key, this.image}) : super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState(image);
}

class _TextEditorState extends State<TextEditor> {
  File image;
  NotusDocument text;

  int _counter = 0;
  File _imageFile;

  ScreenshotController screenshotController = ScreenshotController();

  Matrix4 matrix = Matrix4.identity();
  ValueNotifier<int> notifier = ValueNotifier(0);

  _TextEditorState(this.image);

  final GlobalKey key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  static GlobalKey previewContainer = new GlobalKey();


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async{

                RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
                ui.Image image = await boundary.toImage();
                final directory = (await getApplicationDocumentsDirectory()).path;
                ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                Uint8List pngBytes = byteData.buffer.asUint8List();
                print(pngBytes);
                File imgFile =new File('$directory/screenshot.png');
                imgFile.writeAsBytes(pngBytes);
                  final result =
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuScreen(
                            image: imgFile,
                          )));

                })


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
                bottom: 150.0,
                right: 16.0,
                child:
                RepaintBoundary(
                        key: previewContainer,
                        child: Container(
                          margin: EdgeInsets.only(top: 16.0),
                          height: 450.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: FileImage(image))),
                          child: MatrixGestureDetector(
                            onMatrixUpdate: (m, tm, sm, rm) {
                              notifier.value = m;
                            },
                            child: AnimatedBuilder(
                              animation: notifier,
                              builder: (ctx, child) {
                                return Transform(
                                  transform: notifier.value,
                                  child: Stack(
                                    children: <Widget>[
                                      ConstrainedBox(
                                        constraints: BoxConstraints(maxHeight: 50, maxWidth: 250),
                                        child: Container(
                                          //   color:  Colors.red,
                                            child: text == null
                                                ? Container()
                                                : ZefyrView(document: text)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ))
                    //_imageFile != null ? Image.file(_imageFile) : Container(),
                  ),
            Positioned(
                top: screenHeight * 0.7,
                bottom: 90.0,
                left: 50.0,
                right: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    _text(context);
                  },
                  textColor: Colors.red[100],
                  padding: const EdgeInsets.all(0.0),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Colors.red[300],
                  child: Container(

                    padding: const EdgeInsets.only(
                        left: 83.0, right: 83.0, top: 13.0, bottom: 13.0),
                    child:
                        const Text('ADD TEXT', style: TextStyle(fontSize: 20)),
                  ),
                ))
          ],
        ));
  }

  takeScreenShot() async{
    RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile =new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }

  _text(context) async {
    final value = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddText()));

    setState(() {
      text = value;
    });
  }
}
