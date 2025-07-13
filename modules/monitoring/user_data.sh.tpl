#!/bin/bash
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1
set -x

apt-get update
apt-get install -y apt-transport-https software-properties-common wget gnupg2 curl

PROM_VERSION="${PROM_VERSION}"

wget https://github.com/prometheus/prometheus/releases/download/v$${PROM_VERSION}/prometheus-$${PROM_VERSION}.linux-amd64.tar.gz
tar xvfz prometheus-$${PROM_VERSION}.linux-amd64.tar.gz
cp prometheus-$${PROM_VERSION}.linux-amd64/prometheus /usr/local/bin/
cp prometheus-$${PROM_VERSION}.linux-amd64/promtool /usr/local/bin/
mkdir -p /etc/prometheus
cp -r prometheus-$${PROM_VERSION}.linux-amd64/consoles /etc/prometheus
cp -r prometheus-$${PROM_VERSION}.linux-amd64/console_libraries /etc/prometheus

# Instalando Grafana
curl -fsSL https://packages.grafana.com/gpg.key | gpg --dearmor -o /usr/share/keyrings/grafana.gpg
echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list
apt-get update
apt-get install -y grafana

# Resetando senha do admin do Grafana
grafana-cli admin reset-admin-password "$${grafana_admin_password}"

systemctl enable grafana-server
systemctl start grafana-server
