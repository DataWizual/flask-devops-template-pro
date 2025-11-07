<h1 align="center">🚀 DevOps Infrastructure Template — Flask + CI/CD + Monitoring</h1>

<p align="center">
  <img src="https://img.shields.io/badge/build-passing-brightgreen?style=for-the-badge" alt="Build Status">
  <img src="https://img.shields.io/badge/docker-ready-blue?style=for-the-badge&logo=docker" alt="Docker">
  <img src="https://img.shields.io/badge/grafana-dashboard-orange?style=for-the-badge&logo=grafana" alt="Grafana">
  <img src="https://img.shields.io/badge/prometheus-metrics-red?style=for-the-badge&logo=prometheus" alt="Prometheus">
</p>

<p align="center">
  <strong>Production-ready DevOps environment template</strong> featuring  
  <br>Flask application, GitHub Actions CI/CD pipeline, Dockerized deployment, and real-time Prometheus + Grafana monitoring.
</p>

---

## ✨ Features at a Glance
- 🧩 **Modular structure** — clean separation between `app`, `monitoring`, and `scripts`
- 🐳 **Fully containerized** — runs entirely via Docker Compose
- 🔄 **Automated CI/CD** — GitHub Actions builds and pushes to Docker Hub
- 📊 **Real-time monitoring** — Prometheus + Grafana + cAdvisor
- 🚀 **One-command deploy** — `./scripts/deploy.sh`
- 🧠 **Perfect for learning, demos, or production bootstrap**
- 🎨 **Dark Grafana dashboard** — presentation-ready visuals

---

## 🧱 Overview
A fully integrated DevOps infrastructure template including:
- Backend demo app: **Flask (`flaskr`)**
- CI/CD: **GitHub Actions** (build & push Docker image)
- Deployment: **`deploy.sh`** — one command for updates
- Monitoring: **Prometheus + Grafana + cAdvisor**
- Config files: `docker-compose.yml`, `prometheus.yml`, and Grafana templates

---

<details>
<summary>📁 Project Structure (click to expand)</summary>

```text
📦 packaged_solution
├── 🚀 app
│   ├── ⚙️ deploy.sh
│   ├── 🐳 docker-compose.yml
│   ├── 🧱 Dockerfile
│   ├── 🧩 flaskr
│   │   ├── 🔐 auth.py
│   │   ├── 📰 blog.py
│   │   ├── 🗄️ db.py
│   │   ├── 📄 __init__.py
│   │   ├── 🧾 schema.sql
│   │   ├── 🎨 static
│   │   │   └── style.css
│   │   └── 🖼️ templates
│   │       ├── 🔑 auth
│   │       │   ├── login.html
│   │       │   └── register.html
│   │       ├── 🧩 base.html
│   │       └── 📰 blog
│   │           ├── create.html
│   │           ├── index.html
│   │           └── update.html
│   ├── 📜 LICENSE.txt
│   ├── 🧾 pyproject.toml
│   ├── 📘 README.md
│   ├── 📗 README.rst
│   └── 🧪 tests
│       ├── conftest.py
│       ├── data.sql
│       ├── test_auth.py
│       ├── test_blog.py
│       ├── test_db.py
│       └── test_factory.py
├── 🧰 ci
├── 📚 docs
├── 📊 monitoring
│   ├── 🐳 docker-compose.yml
│   ├── 📈 grafana
│   └── 📡 prometheus
│       └── prometheus.yml
└── ⚙️ scripts
    └── deploy.sh
```
</details>

> **Legend**
> 
> | Emoji | Meaning | Description |
> |:------:|:---------|:-------------|
> | 📦 | **Root folder** | Main project directory |
> | 🚀 | **Application layer** | Flask app, Docker build, and dependencies |
> | 🧩 | **Module / Template** | Flask components or HTML templates |
> | ⚙️ | **Script / Tooling** | Deployment or automation scripts |
> | 🐳 | **Docker / Compose** | Container and environment configuration |
> | 🧾 | **Config / Manifest** | Application configuration or schema |
> | 🧪 | **Tests** | Pytest test cases and fixtures |
> | 📊 | **Monitoring stack** | Prometheus, Grafana, cAdvisor setup |
> | 📡 | **Prometheus** | Metrics collection and targets config |
> | 📈 | **Grafana** | Dashboards and visualization templates |
> | 📚 | **Docs** | Documentation, images, or diagrams |
> | 🧰 | **CI/CD** | GitHub Actions, pipelines, automation |
> | 📘 / 📗 / 📜 | **Docs & License** | README and license files |

---

## 🚀 Quick Start

Run the complete DevOps stack — including Flask app, Prometheus, Grafana, and cAdvisor — with a single command:

```bash
./scripts/healthcheck.sh

```
This script will:

- automatically start any missing containers
- verify that all core services are running (Flask, Prometheus, Grafana, cAdvisor)
- ensure the monitoring network is active and correctly linked
- check connectivity on:
    - **Flask App:** http://localhost:5000
    - **Prometheus:** http://localhost:9090
    - **Grafana:** http://localhost:3000  (admin / admin)

🧩 Ideal for first-time setup, local testing, and environment validation.

## 📊 Grafana Dashboard Customization
The included dashboard (flask_monitoring_dashboard.json)
is optimized for **aggregated metrics** from cAdvisor and Prometheus.

**Legend Settings**
| Panel                 | Legend                 | Description                  |
| --------------------- | ---------------------- | ---------------------------- |
| **CPU Usage (%)**     | `{{job}}`              | Displays Prometheus job      |
| **Memory Usage (MB)** | `Total`                | Aggregated container memory  |
| **Network Traffic**   | `Receive` / `Transmit` | Inbound and outbound network |
| **Uptime**            | `Uptime`               | Process uptime metric        |
| **Targets**           | `{{instance}}`         | Lists monitored services     |
---

**Recommended Visualization**
- Theme: **Dark**
- Time range: `Last 1 hour`
- Refresh interval: 5s
- Legend placement: **Table (bottom)**
- Color thresholds: 🟢 Normal • 🟡 Warning • 🔴 Critical

## 🧭 About
This template demonstrates a **complete DevOps lifecycle** —
from CI/CD automation to monitoring and deployment orchestration.

Ideal for:

- 🔍 Learning modern DevOps practices
- 💼 Building a professional GitHub portfolio
- 🧩 Rapid prototyping of real infrastructure setups

## 🏷️ Tags
`devops` • `docker` • `flask` • `prometheus` • `grafana` • `monitoring` • `cicd` • `template`

<p align="center"> <em>Made with ❤️ by <strong>Eldor Zufarov</strong></em> </p>
