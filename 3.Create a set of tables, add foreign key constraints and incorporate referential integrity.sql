-- Users Table
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

-- Developers Table
CREATE TABLE developers (
    developer_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    PRIMARY KEY (developer_id)
);

-- Publishers Table
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    PRIMARY KEY (publisher_id)
);

-- Games Table with Foreign Keys
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
    FOREIGN KEY (developer_id) REFERENCES developers(developer_id) ON DELETE SET NULL,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE SET NULL
);

-- Shopping Cart Table with Foreign Keys
CREATE TABLE shopping_cart (
    cart_id INT AUTO_INCREMENT,
    user_id INT,
    game_id INT,
    PRIMARY KEY (cart_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

-- Transactions Table with Foreign Key
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT,
    transaction_datetime DATETIME NOT NULL,
    user_id INT,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Purchase History Table with Foreign Keys and Composite PK
CREATE TABLE purchase_history (
    transaction_id INT,
    game_id INT,
    purchase_price DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (transaction_id, game_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE SET NULL
);

-- Insert Sample Data
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

-- Insert transactions and purchase history as examples
INSERT INTO transactions (transaction_datetime, user_id) VALUES (NOW(), 1), (NOW(), 2);

INSERT INTO purchase_history (transaction_id, game_id, purchase_price) VALUES
(1, 1, 19.99),
(2, 2, 29.99);

-- Sample update/delete to test foreign keys
DELETE FROM games WHERE game_id = 1;        -- Will cascade delete from cart, set NULL in purchase_history
DELETE FROM developers WHERE developer_id = 2; -- Sets developer_id in games to NULL
DELETE FROM users WHERE user_id = 1;        -- Cascades delete from transactions and cart

-- Select to verify contents
SELECT * FROM users;
SELECT * FROM developers;
SELECT * FROM publishers;
SELECT * FROM games;
SELECT * FROM transactions;
SELECT * FROM purchase_history;
