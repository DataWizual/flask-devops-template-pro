#!/usr/bin/env bash
# -------------------------------------------------------------------
#  DevOps Healthcheck & Self-Healing Script
#  Checks Flask App, Docker, Prometheus, and Grafana
#  Auto-restarts failed containers if needed
# -------------------------------------------------------------------

set -e
echo "🚀 Starting full system healthcheck..."
echo "--------------------------------------"

# Colors
GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

FAILED=false

check() {
    if [ "$1" -eq 0 ]; then
        echo -e "${GREEN}✔ $2${NC}"
    else
        echo -e "${RED}✖ $2${NC}"
        FAILED=true
    fi
}

restart_container() {
    local name="$1"
    echo -e "${YELLOW}↻ Restarting container: ${name}${NC}"
    docker restart "$name" >/dev/null 2>&1 || docker compose up -d "$name"
    sleep 5
}

# 1️⃣ Docker daemon
docker info >/dev/null 2>&1
check $? "Docker daemon is running"

# 2️⃣ Flask application
FLASK_CONTAINER=$(docker ps --filter "ancestor=eldordevops/flask-devops:latest" --format "{{.Names}}")
if [ -z "$FLASK_CONTAINER" ]; then
    echo -e "${YELLOW}ℹ Flask container not running, starting...${NC}"
    docker run -d -p 5000:5000 --name flask_app eldordevops/flask-devops:latest >/dev/null 2>&1
    sleep 5
    FLASK_CONTAINER="flask_app"
fi

curl -s http://localhost:5000 >/dev/null
if [ $? -ne 0 ]; then
    restart_container "$FLASK_CONTAINER"
fi
curl -s http://localhost:5000 >/dev/null
check $? "Flask app responding on port 5000"

# 3️⃣ Prometheus
PROM=$(docker ps --filter "ancestor=prom/prometheus" --format "{{.Names}}")
if [ -z "$PROM" ]; then
    echo -e "${YELLOW}ℹ Prometheus not running, starting...${NC}"
    docker compose -f ~/devops_practice/flask-devops-template/monitoring/docker-compose.yml up -d prometheus
    sleep 5
fi
curl -s http://localhost:9090/api/v1/query?query=up >/dev/null
if [ $? -ne 0 ]; then
    restart_container "prometheus"
fi
check $? "Prometheus API reachable (port 9090)"

# --------------------------------------------------------
# 🧠 Check cAdvisor
# --------------------------------------------------------
echo "Checking cAdvisor..."
if ! docker ps | grep -q cadvisor; then
  echo "ℹ cAdvisor not running, starting..."
  docker compose -f ~/devops_practice/flask-devops-template/monitoring/docker-compose.yml up -d cadvisor
  sleep 5
else
  echo "✔ cAdvisor already running"
fi

# Проверим доступность порта
if curl -s http://localhost:8080/metrics > /dev/null; then
  echo "✔ cAdvisor metrics available on port 8080"
else
  echo "❌ cAdvisor not responding on port 8080"
fi

# 4️⃣ Grafana
GRAFANA=$(docker ps --filter "ancestor=grafana/grafana" --format "{{.Names}}")
if [ -z "$GRAFANA" ]; then
    echo -e "${YELLOW}ℹ Grafana not running, starting...${NC}"
    docker compose -f ~/devops_practice/flask-devops-template/monitoring/docker-compose.yml up -d grafana
    sleep 10
fi
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 | grep -q "200"
if [ $? -ne 0 ]; then
    restart_container "grafana"
fi
check $? "Grafana web UI responding (port 3000)"

# 5️⃣ Count containers
RUNNING=$(docker ps --format '{{.Names}}' | wc -l)
if [ "$RUNNING" -ge 3 ]; then
    echo -e "${GREEN}✔ $RUNNING containers are running${NC}"
else
    echo -e "${RED}✖ Not all expected containers are up (${RUNNING}/3)${NC}"
    FAILED=true
fi

# 6️⃣ Docker image check
docker image inspect eldordevops/flask-devops:latest >/dev/null 2>&1
check $? "Docker image eldordevops/flask-devops:latest exists locally"

# 7️⃣ Prometheus metric test
METRIC=$(curl -s http://localhost:9090/api/v1/query?query=up | grep -o '"value"')
if [ -n "$METRIC" ]; then
    echo -e "${GREEN}✔ Prometheus returning live metrics${NC}"
else
    echo -e "${RED}✖ Prometheus metrics query failed${NC}"
    FAILED=true
fi

echo "--------------------------------------"

if [ "$FAILED" = true ]; then
    echo -e "${RED}❌ Some checks failed or containers were restarted.${NC}"
    echo -e "${YELLOW}System restored where possible.${NC}"
    exit 1
else
    echo -e "${GREEN}✅ All systems operational and healthy!${NC}"
    exit 0
fi
