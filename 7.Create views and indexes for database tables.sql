-- Tables
CREATE TABLE D(
  DevID INT PRIMARY KEY,
  DevName TEXT,
  Country TEXT
);

CREATE TABLE G(
  GameID INT PRIMARY KEY,
  Title TEXT,
  Genre TEXT,
  DevID INT,
  Price REAL
);

CREATE TABLE P(
  PurID INT PRIMARY KEY,
  GameID INT,
  PurDate DATE
);

-- Data
INSERT INTO D VALUES
 (1,'Ubisoft','France'),
 (2,'EA Sports','USA'),
 (3,'Nintendo','Japan');

INSERT INTO G VALUES
 (101,'Assassin''s Creed','Action',1,59.99),
 (102,'FIFA 23','Sports',2,49.99),
 (103,'Mario Kart','Racing',3,39.99),
 (104,'Watch Dogs','Action',1,44.99);

INSERT INTO P VALUES
 (1,101,'2023-01-05'),
 (2,101,'2023-01-12'),
 (3,102,'2023-02-10'),
 (4,103,'2023-02-11'),
 (5,103,'2023-02-15'),
 (6,104,'2023-03-02');

-- Views
CREATE VIEW DevGames AS
SELECT D.DevName, G.Title
FROM D JOIN G ON D.DevID = G.DevID;

CREATE VIEW Sales AS
SELECT G.Title, COUNT(P.PurID) AS TotalSales
FROM G LEFT JOIN P ON G.GameID = P.GameID
GROUP BY G.Title;

CREATE VIEW Details AS
SELECT G.Title, G.Genre, G.Price, D.DevName
FROM G JOIN D ON G.DevID = D.DevID;

-- Indexes (optional)
CREATE INDEX idx_game_devid ON G(DevID);
CREATE INDEX idx_purchase_gameid ON P(GameID);

-- Output
SELECT * FROM DevGames;
SELECT * FROM Sales;
SELECT * FROM Details;
