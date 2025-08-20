const axios = require("axios");

// Test signup function
async function testSignup() {
  try {
    console.log("Testing signup functionality...");

    const testUser = {
      name: "Test User",
      email: "test@example.com",
      password: "password123",
    };

    console.log("Sending signup request with data:", testUser);

    const response = await axios.post(
      "http://192.168.1.36:6000/api/signup",
      testUser,
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    console.log("✅ Signup successful!");
    console.log("Response status:", response.status);
    console.log("Response data:", response.data);
  } catch (error) {
    console.log("❌ Signup failed!");
    console.log("Error status:", error.response?.status);
    console.log("Error message:", error.response?.data);
    console.log("Full error:", error.message);
  }
}

// Test server connection
async function testServerConnection() {
  try {
    console.log("Testing server connection...");
    const response = await axios.get("http://192.168.1.36:6000");
    console.log("✅ Server is accessible!");
    console.log("Response:", response.data);
  } catch (error) {
    console.log("❌ Server connection failed!");
    console.log("Error:", error.message);
  }
}

// Run tests
async function runTests() {
  console.log("=== Debugging Account Creation ===\n");

  await testServerConnection();
  console.log("\n---\n");

  await testSignup();
}

runTests();
