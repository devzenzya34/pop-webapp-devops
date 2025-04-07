import os
import re

# File paths
ip_file = "terraform/ip_addr/kubernetes_ip.txt"
k3s_file = "ansible/host_vars/k3s.yml"
pop_webapp_cm_file = "kubernetes/pop-webapp/pop-webapp-cm.yml"

def read_ip(file_path):
    """Read the IP address from the specified file."""
    try:
        with open(file_path, "r") as file:
            content = file.read().strip()
            match = re.search(r"Your Public IP:\s*(\d{1,3}(?:\.\d{1,3}){3})", content)
            if match:
                return match.group(1)
            else:
                raise ValueError("IP address not found or invalid format in file.")
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")

def update_k3s_file(file_path, ip_public):
    """Update the ansible_host key in k3s.yml."""
    try:
        with open(file_path, "r") as file:
            content = file.read()
        
        updated_content = re.sub(r"ansible_host: .*", f"ansible_host: {ip_public}", content)
        
        with open(file_path, "w") as file:
            file.write(updated_content)
        print(f"Updated {file_path} successfully.")
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")

def update_pop_webapp_cm_file(file_path, ip_public):
    """Update the odoo_url and pgadmin_url in pop-webapp-cm.yml."""
    try:
        with open(file_path, "r") as file:
            content = file.read()
        
        updated_content = re.sub(r"odoo_url: http://.*:30010", f"odoo_url: http://{ip_public}:30010", content)
        updated_content = re.sub(r"pgadmin_url: http://.*:30011", f"pgadmin_url: http://{ip_public}:30011", updated_content)
        
        with open(file_path, "w") as file:
            file.write(updated_content)
        print(f"Updated {file_path} successfully.")
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")

def main():
    try:
        # Read the public IP
        ip_public = read_ip(ip_file)
        print(f"Fetched IP: {ip_public}")

        # Update k3s.yml
        update_k3s_file(k3s_file, ip_public)

        # Update pop-webapp-cm.yml
        update_pop_webapp_cm_file(pop_webapp_cm_file, ip_public)

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()