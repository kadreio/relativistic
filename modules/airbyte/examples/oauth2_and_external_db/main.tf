module "airbyte" {
  source = "kadreio/relativistic/kubernetes//modules/airbyte"

  # Enable and configure OAuth2 proxy
  enable_proxy = true
  google_oauth_client_id     = "your-client-id"
  google_oauth_client_secret = "your-client-secret"
  # cookie_secret will be auto-generated if not provided
  
  # Configure allowed users
  userlist = <<EOF
    user1@yourdomain.com
    user2@yourdomain.com
  EOF

  # Replace with your external PostgreSQL configuration
  use_external_pg = true
  db_host     = "your-postgres-host"
  db_port     = 5432
  db_name     = "airbyte"
  db_user     = "airbyte_user"
  db_password = "your-secure-password"

  # Optional: Configure custom domain
  target_domain     = "airbyte.yourdomain.com"
  deployment_domain = "yourdomain.com"
  airbyte_subdomain = "airbyte"
} 