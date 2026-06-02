# Voting App - CI/CD Pipeline & Packer/Ansible

Ce projet a été réalisé dans le cadre du TP de DevOps. Il démontre la mise en œuvre de l'Infrastructure as Code (IaC) pour la création d'images de conteneurs, ainsi que la configuration d'un pipeline CI/CD automatisé.

---

## Création de l'image avec Packer & Ansible

Nous utilisons **Packer** (avec le builder Docker) couplé à **Ansible** pour provisionner et configurer notre image de manière reproductible.

### Structure du provisionnement Ansible
- **Playbook :** `ansible/playbook.yml` gère l'installation de Python, appelle le rôle de dépendances et copie les sources de l'application.
- **Rôle deps :** `ansible/roles/deps` installe `pip` et les packages Python requis (`flask`, `redis`, `requests`).

### Comment builder l'image localement avec Packer
1. Initialiser Packer :
   ```bash
   packer init voting-app.pkr.hcl
   ```
2. Lancer la compilation de l'image :
   ```bash
   packer build voting-app.pkr.hcl
   ```
3. Lancer le conteneur créé :
   ```bash
   docker run -d -p 5000:5000 voting-app:latest
   ```

L'application sera alors accessible sur `http://localhost:5000`.

---

## Pipeline CI/CD (GitHub Actions)

Un pipeline complet est configuré dans `.github/workflows/deploy.yml`. À chaque push sur la branche `main`, le pipeline exécute automatiquement les étapes suivantes :

1. **Analyse Statique & Sécurité du Code Python (Bandit) :** Analyse du code source Flask à la recherche de failles de sécurité.
2. **Build Docker :** Compilation de l'image Docker à partir du `Dockerfile`.
3. **Docker Scout Scan :** Analyse approfondie de l'image finale pour détecter les vulnérabilités système ou applicatives (CVEs).
4. **Push Docker Hub :** Publication automatique de l'image validée sur le registre Docker Hub sous le tag `alexkedevil/voting-app:latest`.

---

## Sécurité & Secrets GitHub
Pour que le pipeline fonctionne, les secrets suivants ont été configurés dans le dépôt GitHub :
- `DOCKER_USERNAME` : Identifiant Docker Hub (`alexkedevil`).
- `DOCKER_PASSWORD` : Token d'accès personnel (Personal Access Token) généré sur Docker Hub.
