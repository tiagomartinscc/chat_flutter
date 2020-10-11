import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File image}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}
    
class _TextComposerState extends State<TextComposer> {

  bool _isComposing = false;
  TextEditingController _controller = TextEditingController();

  void reset () {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File image = await ImagePicker.pickImage(source: ImageSource.camera);
              if (image == null) return;
              widget.sendMessage(image: image);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                this.reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing ? () {
              widget.sendMessage(text: _controller.text);
              this.reset();
            } : null,
          )
        ],
      ),
    );
  }
}
    