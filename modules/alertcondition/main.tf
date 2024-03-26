terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

# Configure the New Relic provider
provider "newrelic" {
  account_id = var.account_id
  api_key = var.api_key   # Usually prefixed with 'NRAK'
  region = "US"                    # Valid regions are US and EU
}

resource "newrelic_nrql_alert_condition" "host_memory_usage" {
  account_id = var.account_id
  policy_id = var.alert_policy_id
  type = "static"
  name = "Host Memory Usage"
  enabled = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "SELECT average(memoryUsedPercent) FROM SystemSample FACET entityName"
  }

  critical {
    operator = "above"
    threshold = 99
    threshold_duration = 300
    threshold_occurrences = "all"
  }

  warning {
    operator = "above"
    threshold = 80
    threshold_duration = 300
    threshold_occurrences = "all"
  }
  fill_option = "none"
  aggregation_window = 60
  aggregation_method = "event_flow"
  aggregation_delay = 120
}