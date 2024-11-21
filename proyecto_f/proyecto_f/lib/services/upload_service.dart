import 'dart:io';
import 'package:dio/dio.dart';

class UploadService {
  final Dio _dio = Dio();

  Future<String?> uploadImage(String filePath) async {
    try {
      final file = File(filePath);  // Obtiene el archivo desde el path
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
      });

      final response = await _dio.post(
        'http://localhost:8000/api/upload',  // URL de tu servidor Laravel
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['path'];  // Retorna la URL pública de la imagen subida
      }
    } catch (e) {
      print('Error al subir la imagen: $e');
      return null;
    }
    return null;
  }
}
