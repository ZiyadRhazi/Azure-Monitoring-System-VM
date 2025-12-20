#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Azure Monitoring Stack Installation..."

# Variables
PROM_VERSION="2.54.1"
NODE_EXP_VERSION="1.8.2"

# 1. System Updates
echo ">>> Updating System..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl tar software-properties-common gnupg2

# 2. Install Prometheus
echo ">>> Installing Prometheus v$PROM_VERSION..."

# Create user and directories
sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus || true
sudo mkdir -p /etc/prometheus /var/lib/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# Download and Install
cd /tmp
wget -q https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-amd64.tar.gz
tar xvf prometheus-$PROM_VERSION.linux-amd64.tar.gz
cd prometheus-$PROM_VERSION.linux-amd64

sudo mv prometheus /usr/local/bin/
sudo mv promtool /usr/local/bin/
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus

# Clean up default config and use the one from the repo
# We assume this script is run from the root of the cloned repo
echo ">>> Applying Prometheus Configuration..."
cd - # Go back to previous directory (repo root hopefully, or /tmp)
# We need to find where the script was called from to find the configs folder
REPO_DIR=$(dirname "$0")

sudo cp "$REPO_DIR/configs/prometheus.yml" /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus

# Setup Systemd Service
sudo cp "$REPO_DIR/services/prometheus.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# 3. Install Node Exporter
echo ">>> Installing Node Exporter v$NODE_EXP_VERSION..."

cd /tmp
wget -q https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXP_VERSION/node_exporter-$NODE_EXP_VERSION.linux-amd64.tar.gz
tar xvf node_exporter-$NODE_EXP_VERSION.linux-amd64.tar.gz
sudo mv node_exporter-$NODE_EXP_VERSION.linux-amd64/node_exporter /usr/local/bin/

sudo useradd --no-create-home --shell /usr/sbin/nologin node_exporter || true

# Setup Systemd Service
sudo cp "$REPO_DIR/services/node_exporter.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# 4. Install Grafana
echo ">>> Installing Grafana..."
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt update
sudo apt install -y grafana

sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

echo ">>> Installation Complete!"
echo "Prometheus is running on port 9090"
echo "Grafana is running on port 3000 (Login: admin/admin)"
