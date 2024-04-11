<?php
include_once 'functions.php';
$conn = createConnection();

?>
<!DOCTYPE html>
<html>

<head>
	<title>Php Picture Table Example</title>
	<style>
		table {
			width: 100%;
			border-collapse: collapse;
		}

		table,
		td,
		th {
			border: 1px solid black;
		}

		th,
		td {
			text-align: left;
			padding: 8px;
		}

		th {
			background-color: #f2f2f2;
		}
	</style>
</head>

<body>
	<h4></h4>
	<table>
		<?php
		$query = "SELECT id,picture, picture_path, video, video_path, fileDB, file_path, articleDB, article_path from blobs ";
		$connect = mysqli_connect($host, $username, $password, $database) or die("Problem connecting.");
		$result = mysqli_query($connect, $query) or die("Bad Query.");
		mysqli_close($connect);

		while ($row = $result->fetch_array()) {
			echo "<tr>";
			echo "<td><h2>" . $row['id'] . "</h2></td>";
			echo "<td><h2><img src=image_blobs.php?id=" . $row['id'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><img src=http://" . $host . $row['picture_path'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><embed src=video.php?id=" . $row['id'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><embed src=http://" . $host . $row['video_path'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><embed src=PDFFile.php?id=" . $row['id'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><embed src=http://" . $host . $row['file_path'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><embed src=article_blobs.php?id=" . $row['id'] . " width=200 height=150/></h2></td>";
			echo "<td><h2><embed src=http://" . $host . $row['article_path'] . " width=200 height=150/></h2></td>";
			echo "</tr>";
		}
		?>
	<table>
</body>

</html>