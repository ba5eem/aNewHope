#!/bin/bash

# Install Homebrew (if not already installed)
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Docker and Docker Compose with Homebrew
brew install docker docker-compose

# Start Docker
open --background -a Docker

echo "Docker installed successfully!"

