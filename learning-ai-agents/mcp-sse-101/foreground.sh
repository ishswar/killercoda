# Hid commands
set -e
set -o xtrace

echo waiting for init-script to finish
while [ ! -f /tmp/background0 ]; do sleep 1; done
echo "*************************************"
echo Hello and welcome to MCP Demo!
echo "*************************************"