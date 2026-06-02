FROM ubuntu:22.04

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Installer les packages pip
RUN pip3 install redis flask requests

# Définir le dossier de travail
WORKDIR /app

# Copier le code source de l'application
COPY azure-vote/ /app/

# Exposer le port de l'application
EXPOSE 5000

# Lancer l'application
CMD ["python3", "app.py"]
