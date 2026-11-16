CREATE DATABASE IF NOT EXISTS AnimeDatabase
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE AnimeDatabase;

-- users table has the role field decides what someone can do:
--  a normal 'user'  = can browse the anime  and add them to their OWN watchlist
--   an 'admin' = can also add, edit and delete anime in the database
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') NOT NULL DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- anime table (the catalogue)
-- Only the admin will be able to add, edit and delete these.
CREATE TABLE IF NOT EXISTS anime (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    genre VARCHAR(50) NOT NULL,
    release_year INT NOT NULL,
    total_episodes INT DEFAULT NULL,
    status ENUM('Ongoing', 'Completed') NOT NULL DEFAULT 'Ongoing',
    cover_image VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_genre (genre),
    INDEX idx_release_year (release_year)
);

-- WATCHLIST (each user's own tracking list)
-- One row per user per anime. Any logged-in user can add an anime here.

CREATE TABLE IF NOT EXISTS watchlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    anime_id INT NOT NULL,
    watch_status ENUM('Watching', 'Completed', 'Plan to Watch') NOT NULL DEFAULT 'Plan to Watch',
    current_episode INT NOT NULL DEFAULT 0,
    rating DECIMAL(3,1) DEFAULT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_user_anime (user_id, anime_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (anime_id) REFERENCES anime(id) ON DELETE CASCADE
);
