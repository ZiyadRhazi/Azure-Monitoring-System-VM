# Cloud-Based Monitoring System on Azure

## Abstract
[cite_start]This project implements a production-style monitoring stack on a Microsoft Azure Virtual Machine running Debian 12 (Bookworm)[cite: 5, 39]. [cite_start]The system integrates Prometheus for time-series metrics collection, Node Exporter for host-level monitoring, and Grafana for interactive dashboards[cite: 6].

## Architecture
[cite_start]The monitoring stack runs directly on the VM (without containers) and consists of the following components[cite: 13, 50]:

* [cite_start]**Node Exporter (Port 9100):** Exposes OS metrics (CPU, memory, disk, network)[cite: 34].
* [cite_start]**Prometheus (Port 9090):** Scrapes metrics from Node Exporter and stores them in a time-series database[cite: 35].
* [cite_start]**Grafana (Port 3000):** Visualizes the data stored in Prometheus[cite: 36].


## Prerequisites
* [cite_start]**OS:** Debian 12 (Bookworm)[cite: 39].
* **Network Security Group (Inbound Rules):**
    * [cite_start]TCP 22 (SSH) [cite: 41]
    * [cite_start]TCP 9090 (Prometheus UI) [cite: 42]
    * [cite_start]TCP 3000 (Grafana UI) [cite: 43]

## Grafana Dashboard Metrics
[cite_start]The following PromQL queries were used to build the dashboard[cite: 161]:

| Metric | Query Logic |
| :--- | :--- |
| **CPU Usage** | [cite_start]`100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)` [cite: 166, 167] |
| **Memory Usage** | [cite_start]`100 * (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes))` [cite: 170, 171] |
| **Disk Usage (Root)** | [cite_start]Calculated using `node_filesystem_size_bytes` and `node_filesystem_free_bytes` for mountpoint "/" [cite: 173-175] |
| **Network RX** | [cite_start]`rate(node_network_receive_bytes_total[1m])` [cite: 178] |
| **Network TX** | [cite_start]`rate(node_network_transmit_bytes_total[1m])` [cite: 179] |

## Author
[cite_start]Ziyad Rhazi [cite: 2]
