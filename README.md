# Azure VM Monitoring System
**Implementation of a Cloud-Based Monitoring Stack using Prometheus, Node Exporter, and Grafana.**

## 📌 Project Overview
This project deploys a complete observability stack on a **Debian 12 Azure Virtual Machine**. [cite_start]It visualizes real-time metrics (CPU, Memory, Disk, Network) to ensure cloud services remain responsive and efficient [cite: 5-7].

### Architecture
The system follows a pull-based architecture:
* [cite_start]**Node Exporter (Port 9100):** Exposes host-level system metrics[cite: 34].
* [cite_start]**Prometheus (Port 9090):** Scrapes metrics and stores them in a time-series database[cite: 35].
* [cite_start]**Grafana (Port 3000):** Visualizes the data through interactive dashboards[cite: 36].


---

## ⚙️ Prerequisites
* **Azure VM:** Debian 12 (Bookworm).
* [cite_start]**Network Security:** Ensure the following Inbound Ports are open in your Azure NSG [cite: 40-43]:
    * `22` (SSH)
    * `9090` (Prometheus)
    * `3000` (Grafana)

---

## 🚀 Installation Guide

### 1. Setup & Repository
First, update your system and clone this repository to your VM.
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl tar git
git clone [https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git](https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git)
cd YOUR_REPO_NAME
