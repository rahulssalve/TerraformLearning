# Ver 1.0 - Defines the basic Terraform azurerm_resource_group
# Ver 2.0 - Added New virtual machines within previously created Resource Group
resource "azurerm_resource_group" "RG" {
    name = "TFLearningRG"
    location = "ukwest"
    tags = {
        CostCenter = "HR"
        Owner ="Rahul Salve"
    }
  
}
resource "azurerm_virtual_network" "main" {
  name                = "RG-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.RG.location}"
  resource_group_name = "${azurerm_resource_group.RG.name}"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.RG.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "main" {
  name                = "RGNIC"
  location            = "${azurerm_resource_group.RG.location}"
  resource_group_name = "${azurerm_resource_group.RG.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "VM" {
    name = "TFVM"
    resource_group_name = "${azurerm_resource_group.RG.name}"
    location = "${azurerm_resource_group.RG.location}"
    network_interface_ids = ["${azurerm_network_interface.main.id}"]
    vm_size = "Standard_B1s"
    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
    CostCenter = "Cyber"
    Owner = "Rahul Salve"
  }
}


