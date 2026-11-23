<?php
require_once __DIR__ . '/../vendor/autoload.php';

$loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../templates');
$twig = new \Twig\Environment($loader, ['autoescape' => 'html']);

// Let every template see the session (who is logged in)
$twig->addGlobal('session', $_SESSION);