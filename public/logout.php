<?php
session_start();
$_SESSION = [];     // clear everything saved about the user
session_destroy();  // end the session
header('Location: login.php');
exit;