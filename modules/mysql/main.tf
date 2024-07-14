resource "kubernetes_config_map" "mysql_initdb_config" {
  metadata {
    name      = "mysql-initdb-config"
    namespace = var.namespace
  }

  data = {
    "create_table.sql" = file("${path.module}/../../mysql/initdb/create_table.sql")
  }
}

resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = "mysql"
          image = var.image

          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = var.mysql_root_password
          }

          env {
            name  = "MYSQL_DATABASE"
            value = var.mysql_database
          }

          env {
            name  = "MYSQL_USER"
            value = var.mysql_user
          }

          env {
            name  = "MYSQL_PASSWORD"
            value = var.mysql_password
          }

          port {
            container_port = 3306
          }

          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }

          volume_mount {
            name       = "mysql-initdb"
            mount_path = "/docker-entrypoint-initdb.d"
          }
        }

        volume {
          name = "mysql-persistent-storage"

          persistent_volume_claim {
            claim_name = var.persistent_volume_claim
          }
        }

        volume {
          name = "mysql-initdb"

          config_map {
            name = "mysql-initdb-config"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "mysql_service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      protocol    = "TCP"
      port        = 3306
      target_port = 3306
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_persistent_volume" "mysql_pv" {
  metadata {
    name      = "mysql-pv"
    
  }

  spec {
    capacity = {
      storage = "1Gi"
    }

    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/mnt/data/mysql"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "mysql_pvc" {
  metadata {
    name      = "mysql-pv-claim"
    namespace = var.namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}
