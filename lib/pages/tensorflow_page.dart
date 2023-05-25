import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TensorflowPage extends StatefulWidget {
  const TensorflowPage({super.key});

  @override
  State<TensorflowPage> createState() => _TensorflowPageState();
}

class _TensorflowPageState extends State<TensorflowPage> {
  File? _storedImage;

  openCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Row(
          children: [
            Text(
              'TensorFlow App',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: _storedImage != null
            ? Image.file(
                _storedImage!,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : const Text(
                'Nenhuma imagem selecionada',
                style: TextStyle(fontSize: 24.0),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCamera,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
