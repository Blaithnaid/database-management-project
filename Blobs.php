<html>

<head>
	<title>Php Picture Table Example</title>
</head>

<body>
	<h4>Select id,picture, picture_path, video, video_path, fileDB, file_path, articleDB, article_path from blobs </h4>
	<table border="1">
		<tr>
			<td>
				<h2>id</h2>
			</td>
			<td>
				<h2>Picture in DB</h2>
			</td>
			<td>
				<h2>Picture_path</h2>
			</td>
			<td>
				<h2>Video in DB</h2>
			</td>
			<td>
				<h2>Video_path</h2>
			</td>
			<td>
				<h2>PDF File in DB</h2>
			</td>
			<td>
				<h2>File_path</h2>
			</td>
			<td>
				<h2>Article in DB</h2>
			</td>
			<td>
				<h2>Article_path</h2>
			</td>
		</tr>
		<?php
		include 'dbConfig.php';
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