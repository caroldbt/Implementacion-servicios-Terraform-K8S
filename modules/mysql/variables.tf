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
  default     = 1
}

variable "image" {
  description = "Docker image for the application"
  type        = string
}

variable "mysql_root_password" {
  description = "MySQL root password"
  type        = string
}

variable "mysql_database" {
  description = "Name of the MySQL database"
  type        = string
}

variable "mysql_user" {
  description = "MySQL user"
  type        = string
}

variable "mysql_password" {
  description = "Password for the MySQL user"
  type        = string
}

variable "persistent_volume_claim" {
  description = "Name of the PersistentVolumeClaim"
  type        = string
}
