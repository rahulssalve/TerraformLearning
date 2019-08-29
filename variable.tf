# Ver 1.0 - Defines the basic Terraform variables

provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id =  "${var.client_id}"
    client_secret = "${var.client_secret}"
    tenant_id = "${var.tenant_id}"
}

variable "subscription_id" {
    description ="This variable provides your the subscription ID"
  
}

variable "client_id" {
    description = "This variable provides the client ID"
  
}

variable "client_secret" {
  description = "This variable provides the client secret"
}
variable "tenant_id" {
  description = "This variable provides the tenant ID"
}

