# Configuración y Despliegue de Microservicios con Terraform y K8S
Este repositorio contiene configuraciones de Terraform para desplegar microservicios en un clúster de Minikube. Los microservicios incluyen MySQL, un servidor web PHP y phpMyAdmin.

## Requisitos Previos
Antes de comenzar, asegúrate de tener instalado lo siguiente en tu máquina:
- Minikube
- kubectl
- Terraform
## Configuración
Clonar el repositorio:
´´´
git clone <url-del-repositorio>
´´´
### Iniciar Minikube:
```
minikube start
```
### Configurar Docker:
```
eval $(minikube -p minikube docker-env)
```
### Construir una imagen Docker para el servicor web PHP utilizando el `Dockerfile` del proyecto, y la etiqueta con la dirección IP de minikube
```
# Build the PHP web server image
docker build --tag $(minikube ip):5000/php-webserver -f Dockerfile .
```
### Desplegar los microservicios:
```
terraform init
terraform apply -auto-approve
```
## Acceder a los servicios:
Una vez desplegados, puedes acceder a los siguientes servicios desde tu máquina local:
1. Revisa los pods y services:
   ```
   kubectl get pods
   kubectl get services
   ```
2. Lanzamos el port-fordward o minikube service:
   ```
   kubectl port-forward php-webserver-7b767748f4-xtkxc 8080:80
   minikube service phpmyadmin-service
   ```
3. En el navegador copia la url y verifica el funcionamiento, lanza un mensaje desde el formulario y comprueba la información en mysql
```
user: my_user
password: my_password
```
