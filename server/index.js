const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./auth");
const dash = require("./dash");
const cors = require("cors");
const adminRouter = require("./admin")
const productRouter=require('./products');
const userRouter = require("./user");

const PORT = 6000;
const db = "mongodb://localhost:27017/rayan"; // Connect to 'rayan' database

const app = express();
app.use(cors());
app.use(dash);

app.use(express.json()); // Middleware to parse JSON requests


app.use(adminRouter);
app.use(authRouter); 
app.use(productRouter);// Use authRouter for routes
app.use(userRouter);

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
