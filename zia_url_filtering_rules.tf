# URL Filtering Rules - Consolidated with dynamic blocks
resource "zia_url_filtering_rules" "rules" {
  for_each = { for rule in local.zia_url_filtering_rules_processed : rule.name => rule }

  order       = each.value.order
  name        = each.value.name
  state       = try(each.value.state, "ENABLED")
  rank        = try(each.value.rank, 7)
  description = try(each.value.description, null)
  action      = each.value.action

  # Time validity settings
  enforce_time_validity = try(each.value.enforce_time_validity, false)
  validity_start_time   = try(each.value.validity_start_time, null)
  validity_end_time     = try(each.value.validity_end_time, null)
  validity_time_zone_id = try(each.value.validity_time_zone_id, null)

  # Quota settings
  time_quota = try(each.value.time_quota, null)
  size_quota = try(each.value.size_quota, null)

  # Override settings for BLOCK action
  block_override            = try(each.value.block_override, false)
  end_user_notification_url = try(each.value.end_user_notification_url, null)

  # Simple list attributes
  url_categories         = try(each.value.url_categories, [])
  protocols              = try(each.value.protocols, [])
  request_methods        = try(each.value.request_methods, ["OPTIONS", "GET", "HEAD", "POST", "PUT", "DELETE", "TRACE", "CONNECT", "OTHER", "PROPFIND", "PROPPATCH", "MOVE", "MKCOL", "LOCK", "COPY", "UNLOCK", "PATCH"])
  user_agent_types       = try(each.value.user_agent_types, []) # ["OPERA", "FIREFOX", "MSIE", "MSEDGE", "CHROME", "SAFARI", "MSCHREDGE"]
  source_countries       = try(each.value.source_countries, [])
  device_trust_levels    = try(each.value.device_trust_levels, []) # ["UNKNOWN_DEVICETRUSTLEVEL", "LOW_TRUST", "MEDIUM_TRUST", "HIGH_TRUST"]

  # Dynamic blocks for ID-based relationships
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

  dynamic "users" {
    for_each = try(each.value.users, null) != null ? each.value.users : []
    content {
      id = users.value
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

  dynamic "time_windows" {
    for_each = try(each.value.time_windows, null) != null ? each.value.time_windows : []
    content {
      id = [time_windows.value]
    }
  }

  dynamic "devices" {
    for_each = try(each.value.devices, null) != null ? each.value.devices : []
    content {
      id = devices.value
    }
  }

  dynamic "device_groups" {
    for_each = try(each.value.device_groups, null) != null ? each.value.device_groups : []
    content {
      id = device_groups.value
    }
  }

  # Override blocks for BLOCK action
  dynamic "override_users" {
    for_each = try(each.value.override_users, null) != null ? each.value.override_users : []
    content {
      id = [override_users.value]
    }
  }

  dynamic "override_groups" {
    for_each = try(each.value.override_groups, null) != null ? each.value.override_groups : []
    content {
      id = [override_groups.value]
    }
  }

  # Cloud Browser Isolation profile (for ISOLATE action)
  dynamic "cbi_profile" {
    for_each = each.value.action == "ISOLATE" && try(each.value.cbi_profile, null) != null ? [each.value.cbi_profile] : []
    content {
      id   = cbi_profile.value.id
      name = try(cbi_profile.value.name, null)
      url  = try(cbi_profile.value.url, null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
