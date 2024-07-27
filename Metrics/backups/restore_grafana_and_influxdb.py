import os
import subprocess
from datetime import datetime

grafana_dir = '/backup/grafana'
influxdb_dir = '/backup/influxdb'

volume_grafana = 'metrics_grafana-storage'
volume_influxdb = 'metrics_influxdb-storage'

grafana_container = "metrics-grafana-1"
influx_container = "metrics-influxdb-1"

backup_dir_grafana = "C:\\Users\\Gabriel\\Desktop\\ORANGE\\metrics\\backups\\grafana"
backup_dir_influxdb = "C:\\Users\\Gabriel\\Desktop\\ORANGE\\metrics\\backups\\influxdb"

restore_grafana_file = f"grafana_backup_20240710.tar.gz"
restore_influxdb_file = f"influxdb_backup_20240710.tar.gz"

def stop_container(container_id):
    subprocess.run(["docker", "stop", container_id], check=True)

def start_container(container_id):
    subprocess.run(["docker", "start", container_id], check=True)

def restore_backup(volume_name, backup_dir, backup_file):
    cmd = [
        "docker", "run", "--rm",
        "-v", f"{volume_name}:/volume",
        "-v", f"{backup_dir}:/backup",
        "alpine",
        "sh", "-c", f"cd /volume && tar -xzf /backup/{backup_file}"
    ]
    subprocess.run(cmd, check=True)
    print(f"Backup restaurado de: {backup_file}")

if __name__ == "__main__":
    stop_container(grafana_container)
    restore_backup(volume_grafana, backup_dir_grafana, restore_grafana_file)
    start_container(grafana_container)
    
    stop_container(influx_container)
    restore_backup(volume_influxdb, backup_dir_influxdb, restore_influxdb_file)
    start_container(influx_container)