-- 1. Create tables with primary keys and constraints
CREATE TABLE users (
    user_id INT AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    location VARCHAR(100),
    PRIMARY KEY (user_id),
    UNIQUE (username),
    UNIQUE (email)
);

CREATE TABLE developers (
    developer_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    PRIMARY KEY (developer_id)
);

CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    PRIMARY KEY (publisher_id)
);

CREATE TABLE games (
    game_id INT AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    release_date DATE,
    developer_id INT,
    publisher_id INT,
    genre VARCHAR(50),
    description TEXT,
    price DECIMAL(8,2) NOT NULL,
    rating DECIMAL(3,2),
    PRIMARY KEY (game_id),
    CHECK (price > 0),
    FOREIGN KEY (developer_id) REFERENCES developers(developer_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE shopping_cart (
    cart_id INT AUTO_INCREMENT,
    user_id INT,
    game_id INT,
    PRIMARY KEY (cart_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT,
    transaction_datetime DATETIME NOT NULL,
    user_id INT,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE purchase_history (
    transaction_id INT,
    game_id INT,
    purchase_price DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (transaction_id, game_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

-- 2. Insert sample data
INSERT INTO users (username, email, password, date_of_birth, location) VALUES
('alice', 'alice@email.com', 'secretpass1', '1995-03-21', 'New York'),
('bob', 'bob@email.com', 'superbob2', '1992-07-15', 'San Francisco'),
('carol', 'carol@email.com', 'strongpass3', '2000-12-02', 'Chicago');

INSERT INTO developers (name, location) VALUES
('Epic Games', 'Cary'),
('Valve', 'Bellevue'),
('Ubisoft', 'Montreal'),
('Naughty Dog', 'Santa Monica'),
('CD Projekt', 'Warsaw');

INSERT INTO publishers (name, location) VALUES
('Electronic Arts', 'Redwood City'),
('Activision', 'Santa Monica');

INSERT INTO games (title, release_date, developer_id, publisher_id, genre, description, price, rating) VALUES
('Portal', '2007-10-10', 2, 2, 'Puzzle', 'A unique puzzle-platform game.', 19.99, 4.8),
('Assassin''s Creed', '2007-11-13', 3, 1, 'Action', 'Historic action adventure.', 29.99, 4.5);

-- 3. Update data
UPDATE users SET location = 'Los Angeles' WHERE username = 'bob';
UPDATE users SET location = 'Houston' WHERE user_id = 3;
UPDATE games SET price = 24.99 WHERE game_id = 1;

-- 4. Delete a row from developers
DELETE FROM developers WHERE name = 'CD Projekt';

-- 5. Select to verify
SELECT * FROM users;
SELECT * FROM developers;
SELECT * FROM publishers;
SELECT * FROM games;
