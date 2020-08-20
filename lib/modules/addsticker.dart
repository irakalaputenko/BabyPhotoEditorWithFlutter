import 'dart:io';
import 'package:editbaby/flutter_simple_sticker_view/flutter_simple_sticker_view.dart';
import 'package:flutter/material.dart';
import 'package:editbaby/Menu/menu_screen.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as I;


class StickerEditor1 extends StatefulWidget {
  File image;

  StickerEditor1({Key key, this.image}) : super(key: key);
  @override
  _StickerEditor1State createState() => _StickerEditor1State(image);
}
class _StickerEditor1State extends State<StickerEditor1> {

   File image;
   _StickerEditor1State(this.image);

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
        body:_stickerView = FlutterSimpleStickerView(
          Container(
            child: Image.file(image),
          ),
          [
            Image.asset("assets/15_pack15/1.png"),
            Image.asset("assets/15_pack15/2.png"),
            Image.asset("assets/15_pack15/3.png"),
            Image.asset("assets/15_pack15/4.png"),
            Image.asset("assets/15_pack15/5.png"),
            Image.asset("assets/15_pack15/6.png"),
            Image.asset("assets/15_pack15/7.png"),
            Image.asset("assets/15_pack15/8.png"),
            Image.asset("assets/15_pack15/9.png"),
            Image.asset("assets/15_pack15/10.png"),
            Image.asset("assets/15_pack15/11.png"),
            Image.asset("assets/15_pack15/12.png"),
            Image.asset("assets/15_pack15/13.png"),
            Image.asset("assets/15_pack15/14.png"),
            Image.asset("assets/15_pack15/15.png"),
            Image.asset("assets/15_pack15/16.png"),
            Image.asset("assets/15_pack15/17.png"),
            Image.asset("assets/15_pack15/18.png"),
            Image.asset("assets/15_pack15/19.png"),
            Image.asset("assets/15_pack15/20.png"),
            Image.asset("assets/15_pack15/21.png"),
            Image.asset("assets/15_pack15/22.png"),
            Image.asset("assets/15_pack15/23.png"),
            Image.asset("assets/15_pack15/24.png"),
            Image.asset("assets/15_pack15/25.png"),
            Image.asset("assets/15_pack15/26.png"),
            Image.asset("assets/15_pack15/27.png"),
            Image.asset("assets/15_pack15/28.png"),
            Image.asset("assets/15_pack15/29.png"),
            Image.asset("assets/15_pack15/30.png"),
            Image.asset("assets/15_pack15/31.png"),
            Image.asset("assets/15_pack15/32.png"),
            Image.asset("assets/15_pack15/33.png"),
            Image.asset("assets/15_pack15/34.png"),
            Image.asset("assets/15_pack15/35.png"),
            Image.asset("assets/15_pack15/36.png"),
            Image.asset("assets/15_pack15/37.png"),
            Image.asset("assets/15_pack15/38.png"),
            Image.asset("assets/15_pack15/39.png"),
            Image.asset("assets/15_pack15/40.png"),
          ],
          // panelHeight: 150,
          // panelBackgroundColor: Colors.blue,
          // panelStickerBackgroundColor: Colors.pink,
          // panelStickercrossAxisCount: 4,
          // panelStickerAspectRatio: 1.0,
        ));
  }
}