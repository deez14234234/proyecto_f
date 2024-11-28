<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Response;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;

    /**
     * Método para responder con un error JSON estándar.
     *
     * @param  string  $message
     * @param  int  $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public function sendError($message, $statusCode = 400)
    {
        return Response::json([
            'error' => $message
        ], $statusCode);
    }

    /**
     * Método para responder con un éxito JSON estándar.
     *
     * @param  mixed  $data
     * @param  string  $message
     * @param  int  $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public function sendSuccess($data, $message = 'Operación exitosa', $statusCode = 200)
    {
        return Response::json([
            'success' => true,
            'message' => $message,
            'data' => $data
        ], $statusCode);
    }

    /**
     * Método para manejar excepciones de forma genérica.
     *
     * @param  \Exception  $e
     * @return \Illuminate\Http\JsonResponse
     */
    public function handleException(\Exception $e)
    {
        return $this->sendError($e->getMessage(), 500);
    }
}
