<?php
require_once 'functions.php';
$conn = createConnection();
$image_id = $_GET['id']; // Get the id of the image
$sql = "Select picture from blobs where id=$image_id"; // Query to get the image
$resultset = mysqli_query($conn, "$sql") or die("Invalid query: " . mysqli_error()); // Execute the query
$row = mysqli_fetch_array($resultset); // Get the image from the resultset
header('Content-type: image/png'); // Set the header to image type
echo $row[0]; // Output the image
mysqli_close($conn); // Close the connection
?>