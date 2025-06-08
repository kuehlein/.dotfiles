#!/bin/bash
echo "PLEASE MAKE SURE YOU ARE DISCONNECTED FROM THE INTERNET!!!"
while true; do
  # Generate a random 6-byte MAC address
  mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
  # Extract the first byte
  first_byte=$(echo "$mac" | cut -d: -f1)
  # Convert to decimal and check if it's even (unicast)
  if [ $((16#$first_byte % 2)) -eq 0 ]; then
    echo "Valid MAC: $mac"
    sudo ifconfig en0 ether "$mac"
    break
  else
    echo "Invalid MAC (multicast): $mac"
  fi
done

