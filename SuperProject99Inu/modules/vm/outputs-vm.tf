 #output "password" {
 #    value = {
 #  for pwd_key, pwd in random_password.password: pwd_key => random_password.password[pwd_key].result
 #  }
 #  sensitive = true
 #}

 # output "password" {
 #    value = {
 #  for pwd_key, pwd in azurerm_windows_virtual_machine.admin_password: pwd_key => azurerm_windows_virtual_machine.admin_password[pwd_key].result
 #  }
 #  sensitive = true
 #}