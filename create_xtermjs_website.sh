#!/bin/bash

# Save this script as create_xtermjs_website.sh and make it executable with chmod +x create_xtermjs_website.sh. Then run it with ./create_xtermjs_website.sh "Your Page Title".


if [ -z "$1" ]; then
  echo "Please provide a title for the first page."
  exit 1
fi

FIRST_PAGE_TITLE="$1"
DIR_NAME="xtermjs_website"

mkdir -p "$DIR_NAME"
cd "$DIR_NAME"

cat > index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>XTerm.js Demo</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xterm/css/xterm.css" />
  <script src="https://cdn.jsdelivr.net/npm/xterm"></script>
  <script src="https://cdn.jsdelivr.net/npm/xterm-addon-fit"></script>
  <style>
    #terminal-container {
      width: 100%;
      height: 80vh;
      margin: 1rem auto;
      border: 2px solid #ccc;
    }
  </style>
</head>
<body>
  <h1>$FIRST_PAGE_TITLE</h1>
  <div id="terminal-container"></div>
  <script>
    const terminalContainer = document.getElementById('terminal-container');
    const term = new Terminal();
    const fitAddon = new FitAddon.FitAddon();
    term.loadAddon(fitAddon);
    term.open(terminalContainer);
    fitAddon.fit();
    term.write('Hello from XTerm.js!');
  </script>
  <a href="settings.html">Settings</a>
</body>
</html>
EOF

cat > settings.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>XTerm.js Settings</title>
</head>
<body>
  <h1>XTerm.js Settings</h1>
  <p>Feature toggles coming soon...</p>
  <a href="index.html">Back to Demo</a>
</body>
</html>
EOF

echo "Website created successfully. Open index.html in your browser to see the result."

