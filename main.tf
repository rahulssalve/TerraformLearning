# Ver 1.0 - Defines the basic Terraform azurerm_resource_group
resource "azurerm_resource_group" "RG" {
    name = "TFLearningRG"
    location = "ukwest"
    tags = {
        CostCenter = "HR"
        Owner ="Rahul Salve"
    }
  
}
