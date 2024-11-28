<?php

return [

    /*
    |----------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |----------------------------------------------------------------------
    |
    | This configures CORS headers for your app. You can adjust these
    | settings as necessary. CORS will allow or block requests from
    | different domains, depending on how it's set.
    |
    */
    'paths' => ['api/*'], // Aplica CORS solo a las rutas de la API

    'allowed_methods' => ['*'], // Permite todos los métodos HTTP (GET, POST, PUT, DELETE, etc.)

    'allowed_origins' => [
        // Es recomendable restringir el acceso a tus dominios específicos
        'http://localhost:3000', // Si tu frontend está en localhost, cambia el puerto si es necesario
        'https://tudominio.com', // Agrega aquí el dominio de producción de tu frontend
    ],

    'allowed_origins_patterns' => [
        // Si necesitas permitir orígenes que siguen un patrón específico, puedes agregarlo aquí
        // Ejemplo: 'https://*.tudominio.com'
    ],

    'allowed_headers' => ['*'], // Permite todos los encabezados HTTP

    'exposed_headers' => [], // Puedes exponer encabezados adicionales si lo necesitas

    'max_age' => 0, // Configura el tiempo de cache para las respuestas CORS. 0 significa no almacenar en caché

    'supports_credentials' => true, // Si tu aplicación usa cookies o credenciales, habilita esto

];
