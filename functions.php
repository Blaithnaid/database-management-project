<?php
// G00405899 - Iarla Sparrow Burke
function createConnection()
{
    $useLocal = false;
    if ($useLocal) {
        $host = "localhost";
        $username = "root";
        $password = "";
        $database = "dentist_isb";
        $conn = mysqli_connect($host, $username, $password, $database);
    } else {
        $host = "18.235.191.142";
        $username = "iarla";
        $password = "password";
        $database = "dentist_isb";
        $port = 3306;
        $conn = mysqli_connect($host, $username, $password, $database, $port);
    }
    return $conn;
}