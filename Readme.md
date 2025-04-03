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

