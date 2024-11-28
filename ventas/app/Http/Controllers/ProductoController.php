<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductoController extends Controller
{
    // Fetch all products
    public function index()
    {
        $productos = Producto::all();

        // Añadir la URL de la imagen para cada producto
        foreach ($productos as $producto) {
            $producto->imagen = $producto->imagen ? Storage::url($producto->imagen) : null;
        }

        return response()->json($productos);
    }

    // Store a new product
    public function store(Request $request)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'precio' => 'required|numeric',
            'stock' => 'required|integer',
            'imagen' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validación de imagen
        ]);

        // Subir la imagen si existe
        $imagePath = null;
        if ($request->hasFile('imagen')) {
            // Subir la imagen y almacenarla en el directorio 'public/images'
            $imagePath = $request->file('imagen')->store('public/images');
        }

        // Crear el producto con los datos validados y la ruta de la imagen
        $producto = Producto::create([
            'nombre' => $validated['nombre'],
            'descripcion' => $validated['descripcion'],
            'precio' => $validated['precio'],
            'stock' => $validated['stock'],
            'imagen' => $imagePath,  // Guardar el path de la imagen
        ]);

        // Añadir la URL de la imagen en la respuesta
        $producto->imagen = $producto->imagen ? Storage::url($producto->imagen) : null;

        return response()->json($producto, 201);
    }

    // Show a specific product by ID
    public function show($id)
    {
        $producto = Producto::findOrFail($id);
        
        // Obtener la URL de la imagen para hacerla accesible
        $producto->imagen = $producto->imagen ? Storage::url($producto->imagen) : null;
        
        return response()->json($producto);
    }

    // Update a product by ID
    public function update(Request $request, $id)
    {
        $producto = Producto::findOrFail($id);

        // Validación de los datos de entrada
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'precio' => 'required|numeric',
            'stock' => 'required|integer',
            'imagen' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:2048',  // Validación de imagen
        ]);

        // Verificar si se ha subido una nueva imagen
        if ($request->hasFile('imagen')) {
            // Eliminar la imagen anterior si existe
            if ($producto->imagen) {
                Storage::delete($producto->imagen);
            }
            // Subir la nueva imagen
            $imagePath = $request->file('imagen')->store('public/images');
            $producto->imagen = $imagePath;  // Actualizar la ruta de la imagen
        }

        // Actualizar el resto de los campos
        $producto->update($validated);

        // Añadir la URL de la imagen
        $producto->imagen = $producto->imagen ? Storage::url($producto->imagen) : null;

        return response()->json($producto);
    }

    // Delete a product by ID
    public function destroy($id)
    {
        $producto = Producto::findOrFail($id);

        // Eliminar la imagen si existe
        if ($producto->imagen) {
            Storage::delete($producto->imagen);
        }

        // Eliminar el producto
        Producto::destroy($id);

        return response()->json(null, 204);
    }

    // Search products by name or description
    public function search(Request $request)
    {
        $query = $request->get('query');

        // Búsqueda en los campos 'nombre' y 'descripcion'
        $productos = Producto::where('nombre', 'LIKE', "%$query%")
                             ->orWhere('descripcion', 'LIKE', "%$query%")
                             ->get();

        // Devolver los productos con las URLs de las imágenes
        foreach ($productos as $producto) {
            $producto->imagen = $producto->imagen ? Storage::url($producto->imagen) : null;
        }

        return response()->json($productos);
    }
}
