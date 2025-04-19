#!/bin/bash

# Stop and remove existing container if it exists
echo "Stopping and removing existing Home Assistant container..."
docker stop homeassistant 2>/dev/null
docker rm homeassistant_backup 2>/dev/null
docker rename homeassistant homeassistant_backup 2>/dev/null

# Pull the latest image
echo "Pulling latest Home Assistant image..."
docker pull ghcr.io/home-assistant/home-assistant:stable

# Run the container
echo "Starting Home Assistant..."
docker run -d \
  --name homeassistant \
  --restart unless-stopped \
  --privileged \
  --network host \
  -e TZ=America/New_York \
  -v /home/melanie/homeassistant/config:/config \
  -v /run/dbus:/run/dbus:ro \
  --device=/dev/serial/by-id/usb-Zooz_800_Z-Wave_Stick_533D004242-if00:/dev/zwave \
  --device=/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_ae4b8f1dac6bef11b006a3adc169b110-if00-port0:/dev/ttyZigbee \
  ghcr.io/home-assistant/home-assistant:stable
