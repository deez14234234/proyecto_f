<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddImagenToProductosTable extends Migration
{
    /**
     * Ejecutar las migraciones.
     *
     * @return void
     */
    public function up()
    {
        // Agregamos la columna "imagen" a la tabla productos
        Schema::table('productos', function (Blueprint $table) {
            // La longitud de la URL de la imagen puede ser variable, pero normalmente se usan menos de 255 caracteres.
            $table->string('imagen', 255)->nullable();  // Columna para almacenar la URL de la imagen
        });
    }

    /**
     * Deshacer las migraciones.
     *
     * @return void
     */
    public function down()
    {
        // Si revertimos esta migración, eliminamos la columna "imagen"
        Schema::table('productos', function (Blueprint $table) {
            $table->dropColumn('imagen');
        });
    }
}
