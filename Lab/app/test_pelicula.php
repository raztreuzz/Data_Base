<?php
// Habilitar la visualización de errores
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "/home/raztreuzz/Documentos/Github/Data_Base/Lab/app/models/Pelicula.php";

echo "<p>Pelicula.php incluido correctamente.</p>";

// Crear instancia de la clase Pelicula
$pelicula = new Pelicula();

// Obtener el número de página desde el parámetro GET (por defecto es la página 1)
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$limit = 5; // Número de películas por página
$start = ($page - 1) * $limit; // Calcular el offset para la consulta

// Obtener las películas paginadas
$peliculas = $pelicula->getPeliculas($start, $limit);

// Verificar si la consulta fue exitosa
if (is_array($peliculas)) {
    echo "<h2>Lista de Películas</h2>";
    echo "<ul>";
    foreach ($peliculas as $p) {
        echo "<li><strong>{$p['nombre']}</strong> - {$p['genero']} ({$p['anio']}) <br><img src='{$p['imagen']}' alt='{$p['nombre']}' width='200'></li>";
    }
    echo "</ul>";

    // Mostrar los controles de paginación
    $totalPeliculas = $pelicula->getPeliculasCount();
    $totalPages = ceil($totalPeliculas / $limit);

    echo "<div>";
    if ($page > 1) {
        echo "<a href='?page=" . ($page - 1) . "'>Anterior</a> | ";
    }
    if ($page < $totalPages) {
        echo "<a href='?page=" . ($page + 1) . "'>Siguiente</a>";
    }
    echo "</div>";
} else {
    echo "<p>Error: $peliculas</p>";
}
?>
