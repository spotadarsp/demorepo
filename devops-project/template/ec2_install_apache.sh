#!/bin/bash

# Update and install necessary packages
sudo apt update && sudo apt install -y python3 python3-pip git python3-venv

# Clone the repository if it doesn't exist
if [ ! -d "/home/ubuntu/python-mysql-db-proj-1" ]; then
    git clone https://github.com/spotadarsp/testrepo.git /home/ubuntu/python-mysql-db-proj-1
else
    echo "Repository already exists. Pulling latest changes..."
    cd /home/ubuntu/python-mysql-db-proj-1
    git pull
fi

# Change to the project directory
cd /home/ubuntu/python-mysql-db-proj-1 || exit 1

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

# Activate the virtual environment
source venv/bin/activate

# Upgrade pip inside the virtual environment
pip install --upgrade pip

# Install the required Python packages
pip install -r requirements.txt

# Start the app using nohup
echo 'Starting the application...'
nohup python3 -u app.py > app.log 2>&1 &

# Wait for a short period to ensure the application starts
sleep 5

echo 'Application is running in the background.'
