terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

module "apache" {
  source = "./modules/apache"

  namespace = "default"
  app_name  = "php-webserver"
  replicas  = 1
  image     = "192.168.49.2:5000/php-webserver:latest"
  depends_on = [module.mysql]
}

module "phpmyadmin" {
  source   = "./modules/phpmyadmin"
  namespace = "default"
  app_name  = "phpmyadmin"
  replicas  = 1
  image     = "phpmyadmin/phpmyadmin:latest"
  pma_host  = "mysql-service"
  mysql_root_password = "example_password"
}

module "mysql" {
  source                   = "./modules/mysql"
  namespace                = "default"
  app_name                 = "mysql"
  replicas                 = 1
  image                    = "mysql:latest"
  mysql_root_password      = "example_password"
  mysql_database           = "my_database"
  mysql_user               = "my_user"
  mysql_password           = "my_password"
  persistent_volume_claim  = "mysql-pv-claim"
}
