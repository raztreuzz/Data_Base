<?php


class Database{
    //db parameters
    private $host = 'localhost';
    private $db_name = 'peliculas';
    private $username = 'root';
    private $password = 'caldo_pollo1';
    private $conn;

    public function connect(){
        $this->conn = null;

        try{
            $this->conn = new PDO("mysql:host=".$this->host.";dbname=".$this->db_name.";charset=utf8",
                                    $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }catch(PDOException $e){
            echo "Connection error: ".$e->getMessage();
        }
        return $this->conn;
    }
}
