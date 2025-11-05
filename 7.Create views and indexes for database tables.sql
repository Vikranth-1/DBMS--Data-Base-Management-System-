CREATE TABLE D(i INT PRIMARY KEY, n TEXT, c TEXT);
CREATE TABLE G(i INT PRIMARY KEY, t TEXT, g TEXT, d INT, p REAL);
CREATE TABLE P(i INT PRIMARY KEY, gid INT, dt DATE);

INSERT INTO D VALUES
 (1,'Ubisoft','France'),(2,'EA Sports','USA'),(3,'Nintendo','Japan');

INSERT INTO G VALUES
 (101,'Assassin''s Creed','Action',1,59.99),
 (102,'FIFA 23','Sports',2,49.99),
 (103,'Mario Kart','Racing',3,39.99),
 (104,'Watch Dogs','Action',1,44.99);

INSERT INTO P VALUES
 (1,101,'2023-01-05'),(2,101,'2023-01-12'),
 (3,102,'2023-02-10'),(4,103,'2023-02-11'),
 (5,103,'2023-02-15'),(6,104,'2023-03-02');

CREATE VIEW DevGames AS SELECT D.n, G.t FROM D JOIN G ON D.i=G.d;
CREATE VIEW Sales AS SELECT G.t, COUNT(P.i) AS total FROM G LEFT JOIN P ON G.i=P.gid GROUP BY G.t;
CREATE VIEW Details AS SELECT G.t, G.g, G.p, D.n FROM G JOIN D ON G.d=D.i;

SELECT * FROM DevGames;
SELECT * FROM Sales;
SELECT * FROM Details;
