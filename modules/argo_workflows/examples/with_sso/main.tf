module "argo_workflows" {
  source = "kadreio/relativistic/kubernetes//modules/argo_workflows"

  # Enable SSO authentication
  auth_mode = "sso"
  
  # Configure Google OAuth
  google_oauth_client_id     = "your-client-id"
  google_oauth_client_secret = "your-client-secret"
  
  # Configure domain for SSO
  target_domain = "argo-workflows.yourdomain.com"

  # Configure allowed domains for SSO
  allowed_domains = ["yourdomain.com"]

  # Optional: Configure RBAC rule for admin access
  rbac_rule = "email == 'admin@yourdomain.com' or email == 'admin2@example.com'"
} 