locals {
  # SSL Inspection Rules configuration
  zia_ssl_inspection_rules = [
    {
      name               = "Terraform / Finance"
      order              = 1
      description        = "Do not inspect finance categories - e.g., banking, financial services, etc."
      enabled            = false
      labels             = [data.zia_rule_labels.automation.id]
      groups             = [data.zia_group_management.borgermeister.id]
      departments        = []
      locations          = []
      location_groups    = []
      url_categories     = ["FINANCE"]
      cloud_applications = []
      action = {
        type = "DO_NOT_DECRYPT"
        do_not_decrypt_sub_actions = {
          min_tls_version = "SERVER_TLS_1_2"
        }
      }
      state = "present"
    },
    {
      name               = "Terraform / Microsoft Apps"
      order              = 2
      description        = "Inspect Microsoft Apps - to enable tenant restrictions"
      enabled            = false
      labels             = [data.zia_rule_labels.automation.id]
      groups             = [data.zia_group_management.borgermeister_contractors.id]
      departments        = []
      locations          = []
      location_groups    = []
      url_categories     = []
      cloud_applications = ["MSLOGINSERVICES", "SHAREPOINTONLINE"]
      action = {
        type = "DECRYPT"
      }
      state = "present"
    },
    {
      name               = "Terraform / Test"
      order              = 3
      description        = "Inspect Microsoft Apps - to enable tenant restrictions"
      enabled            = false
      labels             = [data.zia_rule_labels.automation.id]
      groups             = [data.zia_group_management.borgermeister_contractors.id]
      departments        = []
      locations          = []
      location_groups    = []
      url_categories     = []
      cloud_applications = ["MSLOGINSERVICES", "SHAREPOINTONLINE"]
      action = {
        type = "DECRYPT"
        decrypt_sub_actions = {
          block_ssl_traffic_with_no_sni_enabled = true
          block_undecrypt                       = true
          http2_enabled                         = true
          min_client_tls_version                = "CLIENT_TLS_1_3"
          min_server_tls_version                = "SERVER_TLS_1_3"
          ocsp_check                            = true
          server_certificates                   = "BLOCK"
        }
      }
      state = "present"
    }
  ]

  # Use the local directly (no processing needed if using IDs)
  zia_ssl_inspection_rules_processed = local.zia_ssl_inspection_rules
}
