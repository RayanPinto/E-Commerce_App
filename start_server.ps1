Write-Host "Starting the server..." -ForegroundColor Green
Write-Host ""
Write-Host "Make sure you have:" -ForegroundColor Yellow
Write-Host "1. Node.js installed" -ForegroundColor White
Write-Host "2. MongoDB running on localhost:27017" -ForegroundColor White
Write-Host "3. All dependencies installed (run 'npm install' in server folder)" -ForegroundColor White
Write-Host ""

Set-Location server

Write-Host "Installing dependencies..." -ForegroundColor Cyan
npm install

Write-Host ""
Write-Host "Starting server on port 6000..." -ForegroundColor Green
Write-Host "Server will be available at: http://localhost:6000" -ForegroundColor White
Write-Host "For Android emulator use: http://10.0.2.2:6000" -ForegroundColor White
Write-Host ""

node index.js

Read-Host "Press Enter to exit"
