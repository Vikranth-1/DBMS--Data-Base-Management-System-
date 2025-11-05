-- DROP existing objects if present (safe to run repeatedly)
DROP TABLE IF EXISTS Offers;
DROP TABLE IF EXISTS Games;

-- 1) Create Games table (includes CurrentPrice column)
CREATE TABLE Games (
  GameID INT PRIMARY KEY,
  Title VARCHAR(100),
  Price DECIMAL(10,2),
  CurrentPrice DECIMAL(10,2)
) ENGINE=InnoDB;

-- Insert initial game with CurrentPrice same as Price
INSERT INTO Games (GameID, Title, Price, CurrentPrice) VALUES
(101, 'Super Mario Bros', 40.00);

-- 2) Create Offers table that references Games
CREATE TABLE Offers (
  GameID INT PRIMARY KEY,
  PercentOff INT NOT NULL,
  CONSTRAINT fk_offers_games FOREIGN KEY (GameID) REFERENCES Games(GameID)
) ENGINE=InnoDB;

-- 3) Triggers: AFTER INSERT, AFTER UPDATE, AFTER DELETE on Offers
DELIMITER $$

CREATE TRIGGER trg_offer_insert
AFTER INSERT ON Offers
FOR EACH ROW
BEGIN
  UPDATE Games
  SET CurrentPrice = Price - (Price * NEW.PercentOff / 100)
  WHERE GameID = NEW.GameID;
END $$

CREATE TRIGGER trg_offer_update
AFTER UPDATE ON Offers
FOR EACH ROW
BEGIN
  UPDATE Games
  SET CurrentPrice = Price - (Price * NEW.PercentOff / 100)
  WHERE GameID = NEW.GameID;
END $$

CREATE TRIGGER trg_offer_delete
AFTER DELETE ON Offers
FOR EACH ROW
BEGIN
  UPDATE Games
  SET CurrentPrice = Price
  WHERE GameID = OLD.GameID;
END $$

DELIMITER ;

-- 4) Test steps (run these queries to see the expected changes)

-- a) Initial state
SELECT 'Initial' AS stage, GameID, Title, Price, CurrentPrice FROM Games;

-- b) Insert an offer (10% off)
INSERT INTO Offers (GameID, PercentOff) VALUES (101, 10);
SELECT 'After INSERT (10% off)' AS stage, GameID, Title, Price, CurrentPrice FROM Games;

-- c) Update the offer (change to 15%)
UPDATE Offers SET PercentOff = 15 WHERE GameID = 101;
SELECT 'After UPDATE (15% off)' AS stage, GameID, Title, Price, CurrentPrice FROM Games;

-- d) Delete the offer (offer removed -> price resets)
DELETE FROM Offers WHERE GameID = 101;
SELECT 'After DELETE (offer removed)' AS stage, GameID, Title, Price, CurrentPrice FROM Games;
