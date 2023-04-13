#!/bin/bash

#In order to set up a full-stack application using PostgreSQL, Node.js 
with Express, and React, you can follow this bash script. Make sure you 
have Homebrew installed before running this script. If not, visit 
https://brew.sh and follow the instructions.

# Save the file and make it executable with the following command:
# $ chmod +x setup.sh

# Run the script with
# $ ./setup.sh

# Once the script completes, you can start your Express server and React 
app in two separate terminals:

# For the server, navigate to the fullstack_app/server directory and run:
# $ node index.js
# For the React app, navigate to the fullstack_app/client directory and 
run:
# $ npm start

# Your React app will be available at http://localhost:3000, and it will 
display the server time obtained from the Express server.


# Install PostgreSQL
echo "Installing PostgreSQL..."
brew install postgresql
brew services start postgresql
echo "PostgreSQL installed and started."

# Install Node.js
echo "Installing Node.js..."
brew install node
echo "Node.js installed."

# Create project directory
echo "Creating project directory..."
mkdir fullstack_app
cd fullstack_app

# Set up Node.js Express server
echo "Setting up Node.js Express server..."
mkdir server
cd server
npm init -y
npm install express pg
touch index.js

cat > index.js <<EOL
const express = require('express');
const app = express();
const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'mydatabase',
  password: '',
  port: 5432,
});

app.get('/', (req, res) => {
  pool.query('SELECT NOW()', (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    } else {
      res.json({ data: result.rows[0] });
    }
  });
});

app.listen(3001, () => {
  console.log('Server is running on port 3001');
});
EOL

echo "Node.js Express server setup completed."

# Set up React app
echo "Setting up React app..."
cd ..
npx create-react-app client
cd client
npm install axios

cat > src/App.js <<EOL
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [data, setData] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      const response = await axios.get('http://localhost:3001');
      setData(response.data.data);
    };
    fetchData();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        {data ? <p>Server time: {data.now}</p> : <p>Loading...</p>}
      </header>
    </div>
  );
}

export default App;
EOL

echo "React app setup completed."

# Create PostgreSQL database
echo "Creating PostgreSQL database..."
createdb mydatabase
echo "PostgreSQL database created."

# Done
echo "All done! Start the server by running 'node index.js' in the 
'server' directory and the React app by running 'npm start' in the 
'client' directory."

