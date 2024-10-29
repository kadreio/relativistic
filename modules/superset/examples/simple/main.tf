module "superset" {
    source = "kadreio/relativistic/kubernetes//modules/superset"
    #The key used for superset cookies
    superset_secret_key = random_string.cookie_key.result

    #The default user for superset, set this to the first admin's email
    superset_default_user = "admin@example.com"

    #The default password for that admin user, change this after initial login
    superset_default_password = "password"

    #The port that the superset service will be exposed on for local access
    superset_local_exposed_port = 30086
}

resource "random_string" "cookie_key" {
    length  = 32
    special = false
}