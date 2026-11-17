<?php
session_start();

// Loadding the database connection and Twig 
require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/twig.php';

$errors = [];      // will hold any error messages to show
$success = false;  // becomes true if the login works
$username = '';    // keeps the typed username in the form if login fails

// Only run the login check when the form has been submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    // The ? is a placeholder will protct against SQL injection
    $stmt = $pdo->prepare('SELECT id, username, password_hash, role FROM users WHERE username = ?');
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    // If the user exists, check the typed password against the stored hash
    if ($user && password_verify($password, $user['password_hash'])) {
        
        session_regenerate_id(true);// Giving a new session ID after the user has logged in 

        // Save who is logged in, so other pages can check it
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['role'] = $user['role'];

        $success = true;
    } else {
        // Same message for a wrong username or a wrong password,
        // so an attacker can't tell which one was correct
        $errors[] = 'Incorrect username or password.';
    }
}

// Send the data to the template and show the page
echo $twig->render('login.html.twig', [
    'errors' => $errors,
    'success' => $success,
    'username' => $username,
]);