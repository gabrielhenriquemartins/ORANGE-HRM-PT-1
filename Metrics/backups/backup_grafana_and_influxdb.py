import os
import subprocess
from datetime import datetime

grafana_dir = '/backup/grafana'
influxdb_dir = '/backup/influxdb'

volume_grafana = 'metrics_grafana-storage'
volume_influxdb = 'metrics_influxdb-storage'

grafana_container = "metrics-grafana-1"
influx_container = "metrics-influxdb-1"

backup_dir_grafana = "your-path-to-backup-grafana-folder"
backup_dir_influxdb = "your-path-to-backup-influx-folder"

backup_grafana = f"grafana_backup_{datetime.now().strftime('%Y%m%d')}.tar.gz"
backup_influxdb = f"influxdb_backup_{datetime.now().strftime('%Y%m%d')}.tar.gz"

def stop_container(container_id):
    subprocess.run(["docker", "stop", container_id], check=True)

def start_container(container_id):
    subprocess.run(["docker", "start", container_id], check=True)

def create_backup(volume_name, backup_dir, backup_file):
    if not os.path.exists(backup_dir):
        os.makedirs(backup_dir)
    cmd = [
        "docker", "run", "--rm",
        "-v", f"{volume_name}:/volume",
        "-v", f"{backup_dir}:/backup",
        "alpine",
        "sh", "-c", f"cd /volume && tar -czf /backup/{backup_file} ."
    ]
    subprocess.run(cmd, check=True)
    print(f"Backup criado em: {backup_file}")

if __name__ == "__main__":
    stop_container(grafana_container)
    create_backup(volume_grafana, backup_dir_grafana, backup_grafana)
    start_container(grafana_container)
    
    stop_container(influx_container)
    create_backup(volume_influxdb, backup_dir_influxdb, backup_influxdb)
    start_container(influx_container)