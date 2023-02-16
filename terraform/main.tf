variable "rgName" {
  type = string
}

variable "planName" {
  type = string
}

variable "location" {
  type = string
}

variable "appName" {
  type = string
}

resource "azurerm_resource_group" "rg" {
    name = var.rgName
    location = var.location
}

resource "azurerm_service_plan" "appplan" {
    name = var.planName
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Linux"
    sku_name = "B1"
}

resource "azurerm_linux_web_app" "phpipam-app" {
    name = var.appName
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.appplan.id
    https_only = true
    site_config {
        application_stack {
        docker_image = "phpipam/phpipam-www"
        docker_image_tag = "latest"
        }
    }
}