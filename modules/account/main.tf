resource "newrelic_account_management" "foo"{
    count = var.new_account_num
    name=  element(var.new_account, count.index)
    region= "us01"
}