# TEST SKILLS DEVOPS ON LOCAL ENVIRONEMENT
 ** ref: Projet final devops **
    - https://github.com/ulrich-sun/bootcamp-devops-projet
    - https://github.com/eazytraining/projet-fils-rouge.git

## Partie 1: Dockeriser le site vitrine (webapp)
### - Ecrire le dockerfile

Build: **docker build -t test-webapp .**

RUN: **docker run -d -p 8080:8080 test-webapp**

### - Ecrire les compose files
Suivre l'ordre pour lancer les services
- **docker compose -f odoo-compose.yml up -d**
- **docker compose -f pgadmin-compose.yml up -d**
- **docker compose -f webapp-compose.yml up -d**

