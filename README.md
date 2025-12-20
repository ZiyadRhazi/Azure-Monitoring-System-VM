# Azure VM Monitoring System (Prometheus, Node Exporter, Grafana)

**Author:** Ziyad Rhazi
**Date:** December 6, 2025

## 📌 Project Overview
This project implements a fully automated monitoring stack on a **Microsoft Azure Linux VM (Debian 12)**. It uses a shell script to deploy **Prometheus**, **Node Exporter**, and **Grafana** in minutes.

### Architecture
* **Node Exporter (Port 9100):** Metrics collector.
* **Prometheus (Port 9090):** Time-series database.
* **Grafana (Port 3000):** Visualization dashboard.

---

## 🚀 Installation Guide

### 1. Prerequisites
Ensure your Azure VM Network Security Group (NSG) allows inbound traffic on:
* `22` (SSH)
* `9090` (Prometheus)
* `3000` (Grafana)

### 2. Deploy the Stack
Login to your VM and run the following commands:

```bash
# 1. Clone the repository
git clone [https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git](https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git)
cd YOUR_REPO_NAME

# 2. Make the script executable
chmod +x install.sh

# 3. Run the installer
sudo ./install.sh
