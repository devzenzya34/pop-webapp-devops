# TEST SKILLS DEVOPS ON LOCAL ENVIRONEMENT
 ** ref: Projet final devops **
    - https://github.com/ulrich-sun/bootcamp-devops-projet
    - https://github.com/eazytraining/projet-fils-rouge.git

## Partie 1: Dockeriser le site vitrine (webapp)
### - Ecrire le dockerfile

Build: **docker build -t pop-webapp:1.0 .**

RUN: **docker run -d -p 8080:8080 pop-webapp:1.0**

### - Ecrire les compose files
configurer le server pour pgadmin comme suit
{
  "Servers": {
    "1": {
      "Name": "pop-webapp server1",
      "Group": "Server Group 1",
      "Port": 5432,
      "Host": "odoo_database",
      "Username": "odoo",
      "Password": "pwdodoo",
      "SSLMode": "prefer",
      "MaintenanceDB": "postgres",
    }
  }
}

Lancer les services dans cette ordre:
- **docker compose -f odoo-compose.yml up -d**
- **docker compose -f pgadmin-compose.yml up -d**
- **docker compose -f webapp-compose.yml up -d**

## Partie 2: Terraform
### Créer l'arborescence des fichiers
### Rédiger les différentes modules
### S'assurer que terraform est bien installer sur la machine de déploiements
### S'assurer que les accès sont bien configurer sur AWS ( ACCESS_KEY_ID et ACCESS_SECRET_KEY)
**export AWS_ACCESS_KEY && export AWS_SECRET_ACCESS_KEY**
- **terraform init**
- **terraform plan**
- **terraform fmt -recursive**
- **terraform validate**
- Ne pas oublier de update .gitignore pour la sécu
### Tester le déploiement en utilisant soit stack_name kubernetes ou stack_name docker
- **terraform apply -auto-approve**

tester la connection avec : **ssh -i terraform/keypair/kubernetes.pem ubuntu@instance_ip**


## Partie 3: Kubernetes

## Partie 4 Ansible
1- Créer une machine virtuelle sur aws pour installer l'outil ansible la stack applicative sur une autre machine déployer avec terraform
  Création d'une instance ansible (vpc):
    ubuntu - T2 médium - pair de clés - set All traffic (edit security group)

2- écrire les playbooks

3- vérifier les hosts_vars et s'assurer que ansible est bien installé sur la machine local 
    vérifier le path de la pair de clé dans ansible.cfg et modifier la permission du fichier **sudo chmod 400 ../terraform/keypair/kubernetes.pem**
    testing ping server distant **ansible all -m ping**

4- Avoir kubectl d'installer sur la machine local et créer un namespace pour la stack kubernetes avant de deployer
faire attention au restirction de firewall sur le cluster kubernetes et la machine de déploiement
5- Deployer la stack applicative sur le cluster kubernetes
    **ansible-playbook -i hosts playbooks/main.yml**
  
    La webapp est accessible sur l'url http://IP_public:30012
                  odoo_url: http://IP_public:30010
                  pgadmin_url: http://IP_public:30011
    update with a script to fetch IP_public from terraform/ip_addr/kubernetes_ip.txt and add it on ansible/host_vars/k3s.yml and kubernetes/pop-webapp/pop-webapp-cm.yml

  ### Manage ansible-roles (Déployer la stack docker sur la machine de déploiement)
  1- Initier les roles pour chaque service
  2- écrire les roles docker
  3- écrire les roles pour pop-webapp:
    option 1: deployer l'app dans un réseau bien précis (pop_network) avec la commande run
    option 2: deployer l'app dans un réseau bien précis avec un template
  4- écrire les roles pour odoo
  5- écrire les roles pour pgadmin
  6- Deployer la stack applicative sur la machine de deploiement (vérifier la configuration de ansible)
  
## Partie 5 PIPELINE CI/CD
    ### BUILD -> INFRA -> IAC
    ### APP -> Terraform
    ### DEPLOY -> Ansible
    ### ORCHESTRATION -> k3s

