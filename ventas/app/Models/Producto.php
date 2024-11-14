<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;

    // Define the table name (optional, it's auto-detected if it follows conventions)
    protected $table = 'productos';  // Nombre de la tabla (si no se sigue la convención plural de Laravel)

    // Define the fillable attributes for mass assignment
    protected $fillable = ['nombre', 'descripcion', 'precio', 'stock']; // Agregando 'stock' como campo editable

    // If you have timestamps in your database, you can specify them here
    public $timestamps = true;  // Si la tabla usa created_at y updated_at

    // Cast attributes to specific data types
    protected $casts = [
        'precio' => 'float',  // Asegura que 'precio' sea tratado como un float
        'stock' => 'integer', // Asegura que 'stock' sea tratado como un entero
    ];

    // Add any custom methods, relationships, or accessors as needed

    // You can define a custom method to calculate the total value of products in stock
    public function totalStockValue()
    {
        return $this->precio * $this->stock;
    }
}
