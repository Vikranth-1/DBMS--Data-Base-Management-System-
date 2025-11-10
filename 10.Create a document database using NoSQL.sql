// Step 1: Connect to MongoDB
// For local server, use in terminal:
// mongo
// For MongoDB Atlas or remote connection, use the given connection string format:
// mongo "mongodb+srv://username:password@url.mongodb.net/test"

// Step 2: Use (or create) a database
use DatabaseName;

// Step 3: Create a collection (table equivalent)
db.createCollection("CollectionName");

// Step 4: Insert a single document (create operation)
db.CollectionName.insertOne({
  Attribute1: "Value1",
  Attribute2: "Value2"
});

// Step 5: Retrieve a single document (read operation)
var doc = db.CollectionName.findOne({ Attribute1: "Value1" });
printjson(doc);

// Step 6: Update a document
db.CollectionName.updateOne(
  { Attribute1: "Value1" },               // filter condition
  { $set: { Attribute2: "UpdatedValue" } } // update operation
);

// Step 7: Delete a document
db.CollectionName.deleteOne({ Attribute1: "Value1" });
