<?php
function createConnection() {
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "dentist_isb";

    $conn = mysqli_connect($host,$username,$password,$database);
    mysqli_select_db($conn, "dentist_isb") or die(mysqli_error());
    return $conn;
}

function closeConnection($conn) {
    mysqli_close($conn);
}

function getBlobs() {
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

function insertBlob($filePath, $mime) {
    $conn = createConnection();
    $blob = fopen($filePath, 'rb');

    $sql = "INSERT INTO blobs (mime, picture) VALUES ('$mime', ?)";
    $stmt = mysqli_prepare($conn, $sql);

    mysqli_stmt_bind_param($stmt, "s", $blob);
    mysqli_stmt_execute($stmt);

    closeConnection($conn);
}