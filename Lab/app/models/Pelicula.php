<?php

require_once __DIR__ . "/../db/Database.php";

class Pelicula {
    private $database;

    public function __construct() {
        $this->database = new Database();
    }

    public function getPeliculas($offset = 0, $limit = 5) {
        $conn = $this->database->connect();

        if (!$conn) {
            return "Error en la conexión a la base de datos.";
        }

        try {
            $stmt = $conn->prepare("SELECT nombre, genero, director, anio, imagen FROM pelicula LIMIT :offset, :limit;");
            $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
            $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
            $stmt->execute();

            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            return "Error en la consulta: " . $e->getMessage();
        }
    }

    public function getPeliculasCount() {
        $conn = $this->database->connect();

        if (!$conn) {
            return 0;
        }

        try {
            $stmt = $conn->query("SELECT COUNT(*) as total FROM pelicula;");
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            return $result['total'] ?? 0;
        } catch (PDOException $e) {
            return 0;
        }
    }
}
