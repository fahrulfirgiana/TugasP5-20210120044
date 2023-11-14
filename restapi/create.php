<?php
header('Content-Type: application/json');

// Include your database connection
include('db.php');

// Check if the required fields are set
if (!isset($_POST['name']) || !isset($_POST['address']) || !isset($_POST['salary'])) {
    echo json_encode("No Data Sent");
} else {
    // Sanitize input to prevent SQL injection
    $name = mysqli_real_escape_string($db, $_POST['name']);
    $address = mysqli_real_escape_string($db, $_POST['address']);
    $salary = mysqli_real_escape_string($db, $_POST['salary']);

    // Assuming your table is named 'employees'
    $result = mysqli_query($db, "INSERT INTO employees (name, address, salary) VALUES ('{$name}', '{$address}', '{$salary}')");

    if ($result) {
        echo json_encode("Success");
    } else {
        echo json_encode("Failed");
    }
}

// Close the database connection
mysqli_close($db);
?>
