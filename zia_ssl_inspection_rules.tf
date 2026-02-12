# SSL Inspection Rules - Consolidated with dynamic blocks
resource "zia_ssl_inspection_rules" "rules" {
  for_each = {
    for rule in local.zia_ssl_inspection_rules_processed : rule.name => rule
  }

  order       = each.value.order
  rank        = try(each.value.rank, 7)
  name        = each.value.name
  description = try(each.value.description, null)
  state       = try(each.value.enabled, true) ? "ENABLED" : "DISABLED"

  # Dynamic blocks for relationship fields
  dynamic "labels" {
    for_each = try(each.value.labels, null) != null ? each.value.labels : []
    content {
      id = [labels.value]
    }
  }

  dynamic "source_ip_groups" {
    for_each = try(each.value.source_ip_groups, null) != null ? each.value.source_ip_groups : []
    content {
      id = [source_ip_groups.value]
    }
  }

  dynamic "groups" {
    for_each = try(each.value.groups, null) != null ? each.value.groups : []
    content {
      id = [groups.value]
    }
  }

  dynamic "departments" {
    for_each = try(each.value.departments, null) != null ? each.value.departments : []
    content {
      id = [departments.value]
    }
  }

  dynamic "locations" {
    for_each = try(each.value.locations, null) != null ? each.value.locations : []
    content {
      id = [locations.value]
    }
  }

  dynamic "location_groups" {
    for_each = try(each.value.location_groups, null) != null ? each.value.location_groups : []
    content {
      id = [location_groups.value]
    }
  }

  url_categories     = try(each.value.url_categories, [])
  cloud_applications = try(each.value.cloud_applications, [])

  action {
    type                         = each.value.action.type
    override_default_certificate = try(each.value.action.override_default_certificate, false)
    show_eun                     = try(each.value.action.show_eun, each.value.action.type == "DO_NOT_DECRYPT")
    show_eunatp                  = try(each.value.action.show_eunatp, each.value.action.type == "DO_NOT_DECRYPT")

    # Decrypt sub-actions (only for DECRYPT action type)
    dynamic "decrypt_sub_actions" {
      for_each = each.value.action.type == "DECRYPT" ? [1] : []
      content {
        block_ssl_traffic_with_no_sni_enabled = try(each.value.action.decrypt_sub_actions.block_ssl_traffic_with_no_sni_enabled, true)
        block_undecrypt                       = try(each.value.action.decrypt_sub_actions.block_undecrypt, true)
        http2_enabled                         = try(each.value.action.decrypt_sub_actions.http2_enabled, true)
        min_client_tls_version                = try(each.value.action.decrypt_sub_actions.min_client_tls_version, "CLIENT_TLS_1_2")
        min_server_tls_version                = try(each.value.action.decrypt_sub_actions.min_server_tls_version, "SERVER_TLS_1_2")
        ocsp_check                            = try(each.value.action.decrypt_sub_actions.ocsp_check, true)
        server_certificates                   = try(each.value.action.decrypt_sub_actions.server_certificates, "BLOCK")
      }
    }

    # Do not decrypt sub-actions (only for DO_NOT_DECRYPT action type)
    dynamic "do_not_decrypt_sub_actions" {
      for_each = each.value.action.type == "DO_NOT_DECRYPT" ? [1] : []
      content {
        block_ssl_traffic_with_no_sni_enabled = try(each.value.action.do_not_decrypt_sub_actions.block_ssl_traffic_with_no_sni_enabled, true)
        bypass_other_policies                 = try(each.value.action.do_not_decrypt_sub_actions.bypass_other_policies, false)
        min_tls_version                       = try(each.value.action.do_not_decrypt_sub_actions.min_tls_version, "SERVER_TLS_1_2")
        ocsp_check                            = try(each.value.action.do_not_decrypt_sub_actions.ocsp_check, true)
        server_certificates                   = try(each.value.action.do_not_decrypt_sub_actions.server_certificates, "BLOCK")
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}