module "airbyte" {
    source = "kadreio/relativistic/kubernetes//modules/airbyte"

    use_external_pg = false
    enable_proxy = false
}
