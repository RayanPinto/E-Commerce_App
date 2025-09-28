@echo off
echo Starting the server...
echo.
echo Make sure you have:
echo 1. Node.js installed
echo 2. MongoDB running on localhost:27017
echo 3. All dependencies installed (run 'npm install' in server folder)
echo.
cd server
echo Installing dependencies...
npm install
echo.
echo Starting server on port 6000...
echo Server will be available at: http://localhost:6000
echo For Android emulator use: http://10.0.2.2:6000
echo.
node index.js
pause
