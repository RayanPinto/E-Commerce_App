# Troubleshooting Guide

## TimeoutException Issues

If you're experiencing `TimeoutException after 0:00:10.000000: Future not completed` errors, follow these steps:

### 1. Check Server Status

Make sure your server is running:

```bash
# Navigate to server directory
cd server

# Install dependencies (if not done already)
npm install

# Start the server
node index.js
```

You should see:

```
Connection Successful
Server Started on port: 6000
```

### 2. Check MongoDB

Ensure MongoDB is running on localhost:27017:

```bash
# Start MongoDB (if not running)
mongod
```

### 3. Network Configuration

#### For Android Emulator:

- Use: `http://10.0.2.2:6000` (already configured in `global.dart`)

#### For iOS Simulator:

- Use: `http://localhost:6000`
- Update `global.dart` to uncomment the iOS line

#### For Physical Device:

- Use your computer's IP address
- Find your IP: `ipconfig` (Windows) or `ifconfig` (Mac/Linux)
- Update `global.dart` with your actual IP

### 4. Test Server Connection

Open your browser and go to: `http://localhost:6000`
You should see a response (even if it's an error page, it means the server is running)

### 5. Common Issues

#### Issue: "Cannot connect to server"

**Solution:**

- Check if server is running
- Verify port 6000 is not blocked by firewall
- Ensure MongoDB is running

#### Issue: "Request timed out"

**Solution:**

- Server might be overloaded
- Check server logs for errors
- Restart the server

#### Issue: "User already exists"

**Solution:**

- This is normal - the user account already exists
- Try signing in instead of signing up

### 6. Debug Steps

1. **Check server logs** for any errors
2. **Test API endpoints** using Postman or curl:
   ```bash
   curl -X POST http://localhost:6000/api/signup \
     -H "Content-Type: application/json" \
     -d '{"name":"test","email":"test@test.com","password":"password123"}'
   ```
3. **Check Flutter logs** for detailed error messages
4. **Verify network connectivity** between Flutter app and server

### 7. Quick Fix Scripts

Use the provided scripts to start the server:

- Windows: `start_server.bat`
- PowerShell: `start_server.ps1`

### 8. Environment Setup

Make sure you have:

- Node.js (v14 or higher)
- MongoDB (v4 or higher)
- Flutter SDK
- Android Studio / Xcode

### 9. Alternative Solutions

If issues persist:

1. Try using a different port (update both server and client)
2. Use ngrok for testing: `ngrok http 6000`
3. Check if antivirus/firewall is blocking connections
4. Restart your development environment
