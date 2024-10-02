const mongoose = require("mongoose");
const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^[a-zA-Z0-9_.+]*[a-zA-Z][a-zA-Z0-9_.+]*@[a-zA-z0-9-]+\.[a-zA-Z0-9-.]+$/;
        return value.match(re);
      },
      message: "Enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
    validate: {
      validator: (value) => {
        return value.length >= 8;
      },
      message: "Password must be of 8 characters or more.",
    },
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  token: { // Add this field to store the token
    type: String,
    

  
},});
module.exports = mongoose.model("User", userSchema);
