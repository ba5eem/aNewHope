#!/bin/bash

# To run the script, save it to a file (e.g., create_website.sh), make it executable (chmod +x create_website.sh), and then run it (./create_website.sh). The script will prompt you to 
enter a title for the first page, which will be displayed as a heading above the xterm.js terminal.




# Install Node.js and Express.js
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g express

# Create a new directory for the website
mkdir mywebsite
cd mywebsite

# Create the first page with xterm.js demo
read -p "Enter title for the first page: " title
echo "<html><head><title>$title</title></head><body><h1>$title</h1><div id='terminal'></div><script src='https://cdn.jsdelivr.net/npm/xterm@4.8.0/dist/xterm.js'></script><script>var term = 
new Terminal();term.open(document.getElementById('terminal'));term.write('Hello, world!');term.fit();</script></body></html>" > index.html

# Create the second page with xterm.js toggles
echo "<html><head><title>Xterm.js Toggles</title></head><body><h1>Xterm.js Toggles</h1><input type='checkbox' id='boldToggle'> Bold</input><br><input type='checkbox' id='italicToggle'> 
Italic</input><br><input type='checkbox' id='underlineToggle'> Underline</input><br><br><div id='terminal'></div><script>var term = new 
Terminal();term.open(document.getElementById('terminal'));var boldToggle = document.getElementById('boldToggle');boldToggle.onchange = function () { term.setOption('fontWeight', 
this.checked ? 'bold' : 'normal'); };var italicToggle = document.getElementById('italicToggle');italicToggle.onchange = function () { term.setOption('fontStyle', this.checked ? 'italic' : 
'normal'); };var underlineToggle = document.getElementById('underlineToggle');underlineToggle.onchange = function () { term.setOption('cursorBlink', this.checked ? true : false); 
};</script></body></html>" > toggles.html

# Start the website using Express.js
npm init -y
npm install express --save
echo "var express = require('express');var app = express();app.use(express.static(__dirname));app.listen(3000, function () {console.log('Website is now live on port 3000!');});" > 
server.js
node server.js

