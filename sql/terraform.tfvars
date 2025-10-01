labels = {
  environment = "production"
  team        = "devops"
  cost_center = "devops"
  owner       = "devops"
}

sql_config = {
  enabled                    = true
  instance_name_suffix       = ""
  create_service_account     = true
  master_authorized_networks = []
}

sql_instances_config = {
  analytics = {
    database_version      = "POSTGRES_16"
    machine_type          = "db-perf-optimized-N-4"
    disk_type             = "PD_SSD"
    disk_size             = 250
    disk_autoresize       = true
    disk_autoresize_limit = 0
    availability_type     = "REGIONAL"
    primary_zone          = "us-central1-b"
    deletion_protection   = true
    database_flags = [
      {
        name  = "cloudsql.iam_authentication"
        value = "on"
      },
      {
        name  = "max_connections"
        value = "200"
      },
      {
        name  = "shared_buffers"
        value = "2516582"
      },
      {
        name  = "cloudsql.enable_index_advisor"
        value = "on"
      },
      {
        name  = "cloudsql.enable_pgaudit"
        value = "on"
      }
    ]
    databases = {
      analytics_db = {
        name      = "analytics"
        charset   = "UTF8"
        collation = "en_US.UTF8"
      }
    }
    # Use Cloud SQL IAM authentication only - no password-based users
    # Applications connect using Workload Identity service accounts
    # IAM authentication is enabled via database flag: cloudsql.iam_authentication = on
    users = {}
    read_replicas = {
      replica = {
        region                = "us-west3"
        zone                  = "us-west3-c"
        machine_type          = "db-perf-optimized-N-2"
        disk_type             = "PD_SSD"
        disk_size             = 250
        disk_autoresize       = true
        disk_autoresize_limit = 0
        deletion_protection   = true
        ip_configuration = {
          ipv4_enabled                                  = false
          private_network                               = null
          require_ssl                                   = true
          enable_private_path_for_google_cloud_services = true
          authorized_networks                           = []
        }
      }
    }
  }
}
 