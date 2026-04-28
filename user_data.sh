#!/bin/bash
# Script de instalación de Docker para Amazon Linux 2023
# Este script se ejecuta automáticamente al iniciar la instancia

# Actualizar los paquetes del sistema
sudo yum update -y

# Instalar el motor de Docker
sudo yum install -y docker

# Iniciar el servicio de Docker
sudo service docker start

# Permitir al usuario ec2-user usar Docker sin sudo
sudo usermod -a -G docker ec2-user
