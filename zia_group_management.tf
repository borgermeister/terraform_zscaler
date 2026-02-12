data "zia_group_management" "borgermeister" {
  name = "Borgermeister"
}

data "zia_group_management" "borgermeister_contractors" {
  name = "Borgermeister Contractors"
}

output "borgermeister" {
  value = data.zia_group_management.borgermeister
}

output "borgermeister_contractors" {
  value = data.zia_group_management.borgermeister_contractors
}
