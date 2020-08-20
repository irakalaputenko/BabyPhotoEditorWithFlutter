import 'dart:io';

import 'package:editbaby/flutter_frame/flutter_simple_frame_view.dart';
import 'package:flutter/material.dart';
import 'package:editbaby/Menu/menu_screen.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as I;

class FrameEditor extends StatefulWidget {
  final File image;

  FrameEditor({Key key, this.image}) : super(key: key);
  @override
  _FrameEditorState createState() => _FrameEditorState(image);
}
class _FrameEditorState extends State<FrameEditor> {
  File image;

  _FrameEditorState(this.image);

  FlutterSimpleStickerView  _stickerView;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done_outline),
              onPressed: () async {
                Uint8List image1 = await _stickerView.exportImage();

                final directory = (await getApplicationDocumentsDirectory()).path;
                File imgFile =new File('$directory/screenshot.png');
                imgFile.writeAsBytes(image1);
               // I.Image _img = I.decodeImage(image1);
               // var image2 = new Image.memory(_img.getBytes());

              //  var buffer = image1.buffer;
               // ByteData byteData = ByteData.view(buffer);
               // var tempDir = await getTemporaryDirectory();
               // File image3 = await File('${tempDir.path}/img').writeAsBytes(
                //    buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuScreen(
                          image: imgFile,
                        )));



              },
            )
          ],
        ),
        body: _stickerView = FlutterSimpleStickerView(
          Container(
            child: image == null
                ? Text('No image selected.')
                : Image.file(image),
          ),
          [
            Image.asset("assets/frame/1.png"),
            Image.asset("assets/frame/2.png"),
            Image.asset("assets/frame/3.png"),
            Image.asset("assets/frame/4.png"),
            Image.asset("assets/frame/5.png"),
            Image.asset("assets/frame/6.png"),
            Image.asset("assets/frame/7.png"),
            Image.asset("assets/frame/8.png"),
            Image.asset("assets/frame/9.png"),
            Image.asset("assets/frame/10.png"),
            Image.asset("assets/frame/11.png"),
            Image.asset("assets/frame/12.png"),
            Image.asset("assets/frame/13.png"),
            Image.asset("assets/frame/14.png"),
            Image.asset("assets/frame/15.png"),
            Image.asset("assets/frame/16.png"),
            Image.asset("assets/frame/17.png"),
            Image.asset("assets/frame/18.png"),
            Image.asset("assets/frame/19.png"),
            Image.asset("assets/frame/20.png"),
            Image.asset("assets/frame/21.png"),
            Image.asset("assets/frame/22.png"),
            Image.asset("assets/frame/23.png"),
            Image.asset("assets/frame/24.png"),
            Image.asset("assets/frame/25.png"),
            Image.asset("assets/frame/26.png"),
            Image.asset("assets/frame/27.png"),
            Image.asset("assets/frame/28.png"),
            Image.asset("assets/frame/29.png"),
            Image.asset("assets/frame/30.png"),
            Image.asset("assets/frame/31.png"),
            Image.asset("assets/frame/32.png"),
            Image.asset("assets/frame/33.png"),
            Image.asset("assets/frame/34.png"),
            Image.asset("assets/frame/35.png"),
            Image.asset("assets/frame/36.png"),
            Image.asset("assets/frame/37.png"),
            Image.asset("assets/frame/38.png"),
            Image.asset("assets/frame/39.png"),
            Image.asset("assets/frame/40.png"),
            Image.asset("assets/frame/41.png"),
            Image.asset("assets/frame/42.png"),
            Image.asset("assets/frame/43.png"),
            Image.asset("assets/frame/44.png"),
            Image.asset("assets/frame/45.png"),
            Image.asset("assets/frame/46.png"),
            Image.asset("assets/frame/47.png"),
            Image.asset("assets/frame/48.png"),
            Image.asset("assets/frame/49.png"),
            Image.asset("assets/frame/50.png"),

          ],
          // panelHeight: 150,
          // panelBackgroundColor: Colors.blue,
          // panelStickerBackgroundColor: Colors.pink,
          // panelStickercrossAxisCount: 4,
          // panelStickerAspectRatio: 1.0,
        ) );
  }
}
