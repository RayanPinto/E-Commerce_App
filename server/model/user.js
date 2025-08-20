const mongoose = require("mongoose");
const { productSchema } = require("./product");
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
        // More permissive email regex
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(value);
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
  token: {
    type: String,
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
