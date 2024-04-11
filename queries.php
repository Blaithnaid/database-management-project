<?php
error_reporting(E_ALL); // report errors of all levels
ini_set("display_errors", 1); // display those errors
include_once 'functions.php';
// $conn = createConnection();
?>
<!DOCTYPE html>
<html>

<head>
    <title>Dentist Database Queries - G00405899</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            color: white;
            background-color: black;
            text-align: center;
        }

        table {
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
            width: 60%;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        th,
        tr,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        table img {
            width: 200px;
            height: 150px;
            object-fit: cover;
        }
    </style>
</head>

<body>
    <h2>Show bill amounts for patients, separate first and last name</h2>
    <table>
        <tr>
            <th>Patient ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Amount</th>
            <?php
            $host = "18.235.191.142";
            $username = "iarla";
            $password = "password";
            $database = "dentist_isb";
            $port = 3306;
            $conn = mysqli_connect($host, $username, $password, $database, $port);

            $query = "SELECT SUBSTRING_INDEX(p.name, ' ', 1) AS firstname,
            SUBSTRING_INDEX(p.name, ' ', -1) AS lastname, SUBSTR(b.id, -1, 1) AS id,
            b.amount AS amount FROM patient p INNER JOIN billing b ON p.id = b.patient_id";
            $result = mysqli_query($conn, $query) or die("Bad Query.");

            while ($row = $result->fetch_array()) {
                echo "<tr>";
                echo "<td>" . $row['id'] . "</td>";
                echo "<td>" . $row['firstname'] . "</td>";
                echo "<td>" . $row['lastname'] . "</td>";
                echo "<td>" . $row['amount'] . "</td>";
                echo "</tr>";
            }
            ?>
    </table>
    <br>
    <h2>List of Appointments w/ Patient and Staff</h2>
    <table>
        <tr>
            <th>Patient Name</th>
            <th>Appointment Date/Time</th>
            <th>Staff</th>
            <th>Staff License</th>
        </tr>
        <?php
        $query = "SELECT p.name AS patient_name, a.appt_datetime AS appt_datetime,
         s.name AS staff_name, AES_DECRYPT(s.license_number, 'password') AS staff_license
                    FROM patient p
                    INNER JOIN appointment a ON p.id = a.patient_id
                    INNER JOIN staff s ON a.staff_id = s.id
                    ORDER BY a.appt_datetime DESC";
        $result = mysqli_query($conn, $query) or die("Bad Query.");

        while ($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["patient_name"] . "</td>";
            echo "<td>" . $row["appt_datetime"] . "</td>";
            echo "<td>" . $row["staff_name"] . "</td>";
            echo "<td>" . $row["staff_license"] . "</td>";
            echo "</tr>";
        }
        ?>
    </table>
    <br>
    <h2>List of Dental Reports with JPEG blob output</h2>
    <table>
        <tr>
            <th>Report ID</th>
            <th>Report Date</th>
            <th>Report</th>
        </tr>
        <?php
        $query = "SELECT id, datetime, xray_image FROM dental_report";
        $result = mysqli_query($conn, $query) or die("Bad Query.");

        while ($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["id"] . "</td>";
            echo "<td>" . $row["datetime"] . "</td>";
            echo "<td><img src='data:image/jpeg;base64," . base64_encode($row["xray_image"]) . "'/></td>";
            echo "</tr>";
        }
        ?>

</body>

</html>