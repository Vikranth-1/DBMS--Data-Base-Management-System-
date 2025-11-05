CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50)
);

CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(50)
);

CREATE TABLE Games (
    GameID INT PRIMARY KEY,
    Title VARCHAR(100),
    GenreID INT,
    PublisherID INT,
    Rating DECIMAL(3,1),
    CopiesSold INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

INSERT INTO Genres VALUES
(1,'Action'),
(2,'Adventure'),
(3,'Sports'),
(4,'RPG');

INSERT INTO Publishers VALUES
(101,'Nintendo'),
(102,'Ubisoft'),
(103,'EA Sports'),
(104,'Rockstar');

INSERT INTO Games VALUES
(1,'Zelda',2,101,9.6,25000000),
(2,'Mario Kart',3,101,9.2,30000000),
(3,'Assassin Creed',1,102,8.7,15000000),
(4,'FIFA 23',3,103,8.5,35000000),
(5,'GTA V',1,104,9.8,200000000),
(6,'Skyrim',4,104,9.3,35000000);

SELECT Title, Rating
FROM Games
WHERE Rating > (SELECT AVG(Rating) FROM Games);

SELECT Title
FROM Games
WHERE PublisherID = (
    SELECT PublisherID FROM Publishers WHERE PublisherName='Nintendo'
);

SELECT GenreName
FROM Genres
WHERE GenreID = (
    SELECT GenreID FROM Games ORDER BY CopiesSold DESC LIMIT 1
);


SELECT g.Title, p.PublisherName
FROM Games g
INNER JOIN Publishers p ON g.PublisherID = p.PublisherID;

SELECT g.Title, ge.GenreName
FROM Games g
INNER JOIN Genres ge ON g.GenreID = ge.GenreID;


SELECT p.PublisherName, g.Title
FROM Publishers p
LEFT JOIN Games g ON p.PublisherID = g.PublisherID;

Ithu online compilar la 
Then nee MySQL use panna starting la database create panna nu
