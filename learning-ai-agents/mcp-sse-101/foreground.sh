#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status
set +x  # turns OFF command echoing

echo "Waiting for init-script to finish..."
while [ ! -f /tmp/background0 ]; do sleep 1; done

echo "*************************************"
echo "Hello and welcome to MCP Demo!"
echo "*************************************"
