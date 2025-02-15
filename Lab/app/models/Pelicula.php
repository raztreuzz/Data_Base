<?php

require_once __DIR__."/../db/Database.php";

/**
 * Esta clase define métodos para acceder a información sobre peliculas
 * almacenadas en la bd
 */


 class Pelicula{

    private $database;

    public function __construct() {
        $this->database = new Database();
    }


    /**
     * Metodo para obtener registros de peliculas
     */
    public function getPeliculas() {
        
        $conn = $this->database.connect();
        try {

            $stmt = $conn->prepare("SELECT nombre, genero, directos, anio , imagen FROM pelicula; ");
            $stmt->excute();
            $res = $stmt->FetchAll(PDO::FETCH_ASSOC);
            
            return $res;

            //code...
        } catch (PDOExcepcion $e) {
            //throw $th;
            return "Error en la consulta. ".$e->getMessage();
        }
    }


    /**
     * Metodo para conocer la cantidad de registros de peliculas
     */
    public function getPeliculasCount() {
              
    }

 }
