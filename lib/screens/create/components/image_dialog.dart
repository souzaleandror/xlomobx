import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog({@required this.image, onDelete, @required this.onDeleted});

  final dynamic image;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDeleted();
            },
            child: Text(
              "Deletar",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
