<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class FileUploadController extends Controller
{
    public function upload(Request $request)
    {
        // Validar que el archivo existe y es una imagen
        $request->validate([
            'file' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',  // Validación para imágenes
        ]);

        // Subir la imagen al disco público (storage/app/public/uploads)
        $imagePath = $request->file('file')->store('uploads', 'public');

        // Devolver la URL pública del archivo subido
        return response()->json([
            'message' => 'Imagen subida exitosamente.',
            'path' => Storage::url($imagePath),  // Retorna la URL pública del archivo
        ], 200);
    }
}
