<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use Illuminate\Http\Request;

class ProductoController extends Controller
{
    // Fetch all products
    public function index()
    {
        return Producto::all();  // Devuelve todos los productos
    }
    // Store a new product
    public function store(Request $request)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'precio' => 'required|numeric',
            'stock' => 'required|integer',
        ]);


        $producto = Producto::create($validated);

        return response()->json($producto, 201);
    }

    // Show a specific product by ID
    public function show($id)
    {
        $producto = Producto::findOrFail($id);
        return response()->json($producto);
    }

    // Update a product by ID
    public function update(Request $request, $id)
    {
        $producto = Producto::findOrFail($id);
        $producto->update($request->all());
        return response()->json($producto);
    }

    // Delete a product by ID
    public function destroy($id)
    {
        Producto::destroy($id);
        return response()->json(null, 204);
    }
}
