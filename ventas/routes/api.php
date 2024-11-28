<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductoController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FileUploadController;

/*
|----------------------------------------------------------------------
| API Routes
|----------------------------------------------------------------------
| Aquí es donde puedes registrar las rutas API para tu aplicación.
| Estas rutas se cargan por el RouteServiceProvider y todas se asignan
| al grupo de middleware "api". ¡Haz algo increíble!
|
*/

// Rutas de autenticación
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:sanctum')->get('/user', [AuthController::class, 'user']);

// Rutas de productos
Route::get('productos', [ProductoController::class, 'index']); // Obtener todos los productos
Route::get('productos/search', [ProductoController::class, 'search']); // Buscar productos
Route::post('productos', [ProductoController::class, 'store']); // Crear un producto
Route::get('productos/{id}', [ProductoController::class, 'show']); // Obtener un producto por ID
Route::put('productos/{id}', [ProductoController::class, 'update']); // Actualizar un producto
Route::delete('productos/{id}', [ProductoController::class, 'destroy']); // Eliminar un producto

// Rutas de carga de archivos
Route::post('/upload', [FileUploadController::class, 'upload']);

// Rutas de paneles (con autenticación y roles)
Route::middleware(['auth:sanctum', 'role:admin'])->get('/admin-dashboard', function () {
    return response()->json(['message' => 'Bienvenido al panel de administrador']);
});

Route::middleware(['auth:sanctum', 'role:cliente'])->get('/client-dashboard', function () {
    return response()->json(['message' => 'Bienvenido al panel de cliente']);
});
