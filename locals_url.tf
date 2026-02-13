locals {
  # URL Filtering Rules configuration
  zia_url_filtering_rules = [
    {
      name        = "Terraform / Block Social Media"
      order       = 1
      description = "Block access to social media"
      state       = "DISABLED"
      action      = "BLOCK"
      rank        = 7

      # Relationship fields - using IDs
      labels           = [data.zia_rule_labels.automation.id]         # Add label IDs here
      groups           = [data.zia_group_management.borgermeister.id] # Add group IDs here
      departments      = []                                           # Add department IDs here
      locations        = []                                           # Add location IDs here
      location_groups  = []                                           # Add location group IDs here
      source_ip_groups = []                                           # Add source IP group IDs here
      users            = []                                           # Add user IDs here
      time_windows     = []                                           # Add time window IDs here
      devices          = []                                           # Add device IDs here
      device_groups    = []                                           # Add device group IDs here

      # Override settings (for BLOCK action)
      block_override  = false
      override_users  = [] # Users who can override the block
      override_groups = [] # Groups who can override the block

      # Categories and filtering
      url_categories   = ["SOCIAL_NETWORKING", "ENTERTAINMENT"]
      source_countries = [] # e.g., ["US", "CA"]

      # Protocol and request settings
      protocols       = ["HTTPS_RULE", "HTTP_RULE"]
      # request_methods = []

      # Device and user settings
      device_trust_levels    = [] # ["LOW_TRUST", "MEDIUM_TRUST", "HIGH_TRUST"]
      user_agent_types       = [] # ["CHROME", "FIREFOX", "SAFARI"]
      user_risk_score_levels = [] # ["LOW", "MEDIUM", "HIGH", "CRITICAL"]

      # Time validity
      enforce_time_validity = false
      validity_start_time   = null # "Mon, 17 Jun 2024 23:30:00 UTC"
      validity_end_time     = null # "Tue, 17 Jun 2025 23:00:00 UTC"
      validity_time_zone_id = null # "US/Pacific"

      # Quota settings
      time_quota = null # Time quota in minutes
      size_quota = null # Size quota in MB

      # CIPA compliance
      cipa_rule = false
    },
    {
      name        = "Terraform / Block Adult Stuff"
      order       = 2
      description = "Block access to adult sites"
      state       = "DISABLED"
      action      = "BLOCK"
      rank        = 7

      # Relationship fields - using IDs
      labels           = [data.zia_rule_labels.automation.id]         # Add label IDs here
      groups           = [data.zia_group_management.borgermeister.id] # Add group IDs here
      departments      = []                                           # Add department IDs here
      locations        = []                                           # Add location IDs here
      location_groups  = []                                           # Add location group IDs here
      source_ip_groups = []                                           # Add source IP group IDs here
      users            = []                                           # Add user IDs here
      time_windows     = []                                           # Add time window IDs here
      devices          = []                                           # Add device IDs here
      device_groups    = []                                           # Add device group IDs here

      # Override settings (for BLOCK action)
      block_override  = false
      override_users  = [] # Users who can override the block
      override_groups = [] # Groups who can override the block

      # Categories and filtering
      url_categories   = ["ADULT", "NUDITY"]
      source_countries = [] # e.g., ["US", "CA"]

      # Protocol and request settings
      protocols       = ["HTTPS_RULE", "HTTP_RULE"]
      # request_methods = []

      # Device and user settings
      device_trust_levels    = [] # ["LOW_TRUST", "MEDIUM_TRUST", "HIGH_TRUST"]
      user_agent_types       = [] # ["CHROME", "FIREFOX", "SAFARI"]
      user_risk_score_levels = [] # ["LOW", "MEDIUM", "HIGH", "CRITICAL"]

      # Time validity
      enforce_time_validity = false
      validity_start_time   = null # "Mon, 17 Jun 2024 23:30:00 UTC"
      validity_end_time     = null # "Tue, 17 Jun 2025 23:00:00 UTC"
      validity_time_zone_id = null # "US/Pacific"

      # Quota settings
      time_quota = null # Time quota in minutes
      size_quota = null # Size quota in MB

      # CIPA compliance
      cipa_rule = false
    }
  ]

  # Use the local directly (no processing needed if using IDs)
  zia_url_filtering_rules_processed = local.zia_url_filtering_rules
}
