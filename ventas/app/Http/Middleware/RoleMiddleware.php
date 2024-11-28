<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class RoleMiddleware
{
    public function handle(Request $request, Closure $next, $role)
    {
        if (auth()->user()->role !== $role) {
            return response()->json(['message' => 'No tienes permiso para acceder a esta ruta'], 403);
        }

        return $next($request);
    }
}
