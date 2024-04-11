<?php
// G00405899 - Iarla Sparrow Burke
function createConnection()
{
    $useLocal = false;
    $conn = null;
    try {
        if ($useLocal) {
            $host = "localhost";
            $username = "root";
            $password = "";
            $database = "dentist_isb";
            $conn = mysqli_connect($host, $username, $password, $database);
        } else {
            $host = "18.235.191.142";
            $username = "root";
            $password = "";
            $database = "dentist_isb";
            $port = 3306;
            $conn = mysqli_connect($host, $username, $password, $database, $port);
        }

        // Check connection
        if ($conn->connect_error) {
            throw new Exception("Connection failed: " . mysqli_connect_error());
        }
        mysqli_select_db($conn, "dentist_isb") or die(mysqli_error());
    } catch (Exception $e) {
        echo "Connection failed: " . $e->getMessage();
    }
    return $conn;
}

function getBlobs()
{
    $conn = createConnection();
    $sql = "SELECT id, mime FROM blobs ORDER BY id";
    $result = mysqli_query($conn, $sql) or die("Invalid query: " . mysqli_error());

    $blobs = array();
    while ($row = mysqli_fetch_array($result)) {
        $blobs[] = $row;
    }

    closeConnection($conn);
    return $blobs;
}