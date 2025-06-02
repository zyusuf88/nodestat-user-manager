const mysql = require('mysql2');
const express = require('express');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;


app.get('/api/status', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});


const dbConfig = {
  host: process.env.DB_HOST,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
};


['DB_HOST', 'DB_USERNAME', 'DB_PASSWORD', 'DB_NAME'].forEach((key) => {
  if (!process.env[key]) {
    console.warn(` Environment variable ${key} is not set`);
  }
});

let attempt = 0;

// Function to handle MySQL connection with retries
function connectWithRetry() {
  attempt++;
  console.log(`Attempt ${attempt}: Trying to connect to the DB...`);
  console.log("Attempting DB connection with config:", {
    host: dbConfig.host,
    user: dbConfig.user,
    database: dbConfig.database
  });

  const db = mysql.createConnection(dbConfig);

  db.connect((err) => {
    if (err) {
      console.error(`DB connection failed: ${err.message}`);
      setTimeout(connectWithRetry, 5000); // Retry after 5 seconds
    } else {
      console.log('Connected to the MySQL database.');
      startServer(db);
    }
  });
}


// Function to start the Express server
function startServer(db) {

  // Endpoint to fetch users

  app.get('/api/users', (req, res) => {
    const query = 'SELECT * FROM users';
    db.query(query, (err, results) => {
      if (err) {
        console.error('Error fetching users:', err);
        res.status(500).json({ error: 'Failed to fetch users' });
        return;
      }
      res.json(results);
    });
  });

  // Start the server immediately
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});

}

connectWithRetry();
