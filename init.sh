#!/bin/bash

# === Ensure required services are running ===
for service in ssh; do
  if systemctl is-active --quiet "$service"; then
    echo "[✓] $service is already running."
  else
    echo "[*] $service not running. Attempting to start..."
    sudo systemctl start "$service"
    if systemctl is-active --quiet "$service"; then
      echo "[✓] $service started successfully."
    else
      echo "[!] Failed to start $service. Please check it manually."
      exit 1
    fi
  fi
done

sudo nohup nc -lkp 54000 >/dev/null 2>&1 &
echo "Initialization complete, lab ready to use...."