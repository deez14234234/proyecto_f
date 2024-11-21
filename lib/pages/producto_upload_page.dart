import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Para seleccionar imágenes
import 'dart:io';
import '../services/upload_service.dart';

class FileUploadPage extends StatefulWidget {
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  String? _uploadedFilePath;  // Variable para mostrar la URL de la imagen subida
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickAndUploadImage() async {
    // Seleccionar la imagen de la galería o cámara
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);  // Puedes cambiar a `ImageSource.camera` para usar la cámara
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });

      final uploadService = UploadService();
      final uploadedPath = await uploadService.uploadImage(pickedFile.path);

      setState(() {
        _uploadedFilePath = uploadedPath;  // Actualiza la UI con la URL de la imagen subida
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Imagen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: Text('Seleccionar Imagen'),
            ),
            if (_image != null) ...[
              Image.file(File(_image!.path), height: 200),  // Muestra la imagen seleccionada
              SizedBox(height: 20),
            ],
            if (_uploadedFilePath != null) ...[
              SizedBox(height: 20),
              Text('Imagen subida a: $_uploadedFilePath'),  // Muestra la URL de la imagen subida
            ]
          ],
        ),
      ),
    );
  }
}
