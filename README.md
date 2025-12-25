# Azure VM Monitoring System

## Overview
This project implements a cloud-based monitoring system on an Azure Linux VM (Debian 12). It uses **Prometheus** for metrics collection, **Node Exporter** for host monitoring, and **Grafana** for visualization.

## Components
* **Prometheus**: Pull-based time-series monitoring system.
* **Node Exporter**: Exposes Linux system metrics.
* **Grafana**: Visualization platform for dashboards.

## Prerequisites
Ensure your Azure Network Security Group allows inbound traffic on:
* Port 9090 (Prometheus)
* Port 3000 (Grafana)
* Port 22 (SSH)

## Usage
1. Clone this repository.
2. Run `chmod +x install.sh` to make the script executable.
3. Run `./install.sh` to install all components and services.
