const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./auth");
const dash = require("./dash");
const cors = require("cors");
app.use(cors());

const PORT = 5444;
const db = "mongodb://localhost:27017/rayan"; // Connect to 'rayan' database

const app = express();
app.use(dash);

app.use(express.json()); // Middleware to parse JSON requests

app.get("/", (req, res) => {
  res.send("Home Page");
});

app.use(authRouter); // Use authRouter for routes

mongoose
  .connect(db)
  .then(() => {
    console.log(`Connection Successful`);
    app.listen(PORT, "0.0.0.0", (err) => {
      if (err) {
        console.error(`Error starting server: ${err.message}`);
        return;
      }
      console.log("Server Started on port:", PORT);
    });
  })
  .catch((e) => {
    console.error("Error connecting to database:", e);
  });
