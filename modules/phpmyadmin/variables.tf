variable "namespace" {
  description = "Namespace for the application"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
}

variable "image" {
  description = "Docker image for the application"
  type        = string
}

variable "pma_host" {
  description = "Host for phpMyAdmin to connect to"
  type        = string
}

variable "mysql_root_password" {
  description = "MySQL root password"
  type        = string
}
