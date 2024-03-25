#!/bin/bash

# Define the Atlantis project folder
ATLANTIS_FOLDER="/home/andramiq/Workspaces/az2-atlantis-poc"
# Define the Atlantis executable location
ATLANTIS_PATH="/usr/bin/atlantis"  # Change this to the full path if atlantis is not in your PATH
# Define the Atlantis configuration file location
ATLANTIS_CONFIG="${ATLANTIS_FOLDER}/atlantis.yaml"  # Change this to your Atlantis config file path

# Function to start Atlantis
start_atlantis() {
    cd ${ATLANTIS_FOLDER}
    echo "Starting Atlantis server..."
    nohup $ATLANTIS_PATH server --config $ATLANTIS_CONFIG > atlantis.log 2>&1 &
    echo $! > atlantis.pid
    cat atlantis.log"
    echo "Atlantis started with PID $(cat atlantis.pid)"
}

# Function to stop Atlantis
stop_atlantis() {
    cd ${ATLANTIS_FOLDER}
    if [ ! -f atlantis.pid ]; then
        echo "Atlantis is not running."
        return
    fi

    echo "Stopping Atlantis server..."
    kill $(cat atlantis.pid | xargs -n100)
    rm atlantis.pid
    echo "Atlantis stopped."
}

# Main logic to start/stop Atlantis based on user input
case "$1" in
    start)
        start_atlantis
        ;;
    stop)
        stop_atlantis
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac