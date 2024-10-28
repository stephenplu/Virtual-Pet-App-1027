const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors'); 
//test
/*
steph: here is the backend which connects to the database 
you need node.js installed with npm latest version and cors (nothing will run if you dont have these)
to run the backend server type in "node server.js" in your console and a port will open
*/ 

const app = express();
app.use(cors()); 
app.use(bodyParser.json()); 

// databse information to connect
const db = mysql.createConnection({
  host: 'virtual-pet-db.c3iywe2ual94.us-east-1.rds.amazonaws.com',
  user: 'virtualpet_admin',
  password: 'Huster47812,',  
  database: 'pet_care_db',
  port: 3306
});

// Connect to the database testing (should show up in console node.js)
db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err.stack);
    return;
  }
  console.log('Connected to Amazon RDS database.');
});

// Define login route
app.post('/api/login', (req, res) => {
    console.log('incoming request body', req.body);
  const { username, password } = req.body;

  // Insert the login data into the database (as of 10/27 we do not have an SQL table so this will not work yet)
  const query = 'INSERT INTO login_attempts (username, password) VALUES (?, ?)';

  db.query(query, [username, password], (err, result) => {
    if (err) {
      console.error('Error inserting login data:', err);
      res.status(500).json({ success: false, message: 'Failed to log in.' });
    } else {
      console.log('Login data inserted:', { username, password });
      res.json({ success: true, message: 'Login data saved successfully!' });
    }
  });
});

// Starts server
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
