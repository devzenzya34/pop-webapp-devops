# TEST SKILLS DEVOPS ON LOCAL ENVIRONEMENT
 ** ref: Projet final devops **
    - https://github.com/ulrich-sun/bootcamp-devops-projet
    - https://github.com/eazytraining/projet-fils-rouge.git

## Partie 1: Dockeriser le site vitrine (webapp)
### - Ecrire le dockerfile

Build: **docker build -t pop-webapp:1.0 .**

RUN: **docker run -d -p 8080:8080 pop-webapp:1.0**

### - Ecrire les compose files
Suivre l'ordre pour lancer les services
- **docker compose -f odoo-compose.yml up -d**
- **docker compose -f pgadmin-compose.yml up -d**
- **docker compose -f webapp-compose.yml up -d**

