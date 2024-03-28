resource "newrelic_account_management" "foo"{
    count = var.count
    name=  element(var.new_account, count.index)
    region= "us01"
}