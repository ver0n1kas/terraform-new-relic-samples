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
  api_key = var.api_key 
  region = "US" 
}

resource "newrelic_account_management" "foo"{
    count = var.new_account_num
    name=  element(var.new_account, count.index)
    region= "us01"
}