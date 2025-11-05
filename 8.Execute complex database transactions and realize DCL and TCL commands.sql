-- View current cart
SELECT * FROM Cart WHERE UserID = 1;

-- Start purchase transaction
START TRANSACTION;

SET @UserID = 1;

-- Insert new transaction record
INSERT INTO Transactions(TransactionDate, UserID)
VALUES (NOW(), @UserID);

-- Get the last inserted TransactionID
SET @T_ID = LAST_INSERT_ID();

-- Insert purchased items into PurchaseHistory
INSERT INTO PurchaseHistory(TransactionID, GameID, SalePrice)
SELECT @T_ID, c.GameID, g.CurrentPrice
FROM Cart c
JOIN Games g ON c.GameID = g.GameID
WHERE c.UserID = @UserID;

-- Clear the user's cart
DELETE FROM Cart WHERE UserID = @UserID;

COMMIT;

-- Show inserted transaction
SELECT * FROM Transactions WHERE UserID = @UserID;

-- Show purchase history for the latest transaction
SELECT * 
FROM PurchaseHistory
WHERE TransactionID = (
    SELECT TransactionID
    FROM Transactions
    WHERE UserID = @UserID
    ORDER BY TransactionID DESC
    LIMIT 1
);

-- Verify cart is empty
SELECT * FROM Cart WHERE UserID = @UserID;

-- Create customer user (No password not recommended, but allowed)
CREATE USER 'customer'@'localhost' IDENTIFIED BY '';

-- Grant read-only access to Games table
GRANT SELECT ON yourdb.Games TO 'customer'@'localhost';

-- Revoke write permissions on Games (if existed earlier)
REVOKE INSERT, UPDATE, DELETE ON yourdb.Games FROM 'customer'@'localhost';

-- Apply privilege changes
FLUSH PRIVILEGES;
