#!/bin/bash
cd /config || exit 1
echo "[HA Git] Pulling latest config..."
git pull origin main || exit 1

echo "[HA Git] Restarting Home Assistant..."
docker restart homeassistant