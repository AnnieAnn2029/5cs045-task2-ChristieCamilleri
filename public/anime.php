<?php
session_start();
require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/twig.php';

$stmt = $pdo->query('SELECT id, title, genre, release_year, status FROM anime ORDER BY title');// This will get all the anime that are in the database and sort them by name
$animeList = $stmt->fetchAll();// this will turn the results into an array

echo $twig->render('anime_list.html.twig', [
    'animeList' => $animeList,
]);