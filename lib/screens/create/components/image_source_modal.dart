import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModel extends StatelessWidget {
  final Function(File file) onImageSelected;

  ImageSourceModel(this.onImageSelected);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              onPressed: getFromCamera,
              child: Text(
                'Camera',
              ),
            ),
            FlatButton(
              onPressed: getFromGallery,
              child: Text(
                'Galeria',
              ),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text("Selecionar foto para o anuncio"),
        message: const Text("Escolha a origem da foto"),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: Text(
            'Camera',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: Text(
              'Camera',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: Text(
              'Galeria',
            ),
          ),
        ],
      );
    }
  }

  Future<void> getFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    imageSelected(File(pickedFile.path));
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    imageSelected(File(pickedFile.path));
  }

  Future<void> imageSelected(File image) async {
    print(image.path);
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );

    if (croppedFile != null) {
      onImageSelected(croppedFile);
    }
  }
}
