<?php
// Habilitar la visualización de errores
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "/home/raztreuzz/Documentos/Github/Data_Base/Lab/app/models/Pelicula.php";

// Crear instancia de la clase Pelicula
$pelicula = new Pelicula();

// Obtener el número de página desde el parámetro GET (por defecto es la página 1)
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$limit = 5; // Número de películas por página
$start = ($page - 1) * $limit; // Calcular el offset para la consulta

// Obtener las películas paginadas
$peliculas = $pelicula->getPeliculas($start, $limit);

// Obtener el total de películas para la paginación
$totalPeliculas = $pelicula->getPeliculasCount();
$totalPages = ceil($totalPeliculas / $limit);

// Verificar si la consulta fue exitosa
if (is_array($peliculas)) {
    echo json_encode([
        'peliculas' => $peliculas,
        'totalPages' => $totalPages,
        'currentPage' => $page
    ]);
} else {
    echo json_encode(['error' => $peliculas]);
}
?>
