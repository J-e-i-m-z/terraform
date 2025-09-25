variable "resource_group_name"{
    description = "Name of the existing resource group"
    type = string
    default = "rg-devops-practice"


}

variable "location"{
    description = "Azure region where resources will be created"
    type = string
    default = "southafricanorth"

}

variable "tags"{
    description = "Tags to apply to all resources"
    type = map(string)
    default = {
        Project     = "DevOps-Practice"
        Environment = "Learning"
        CostCenter  = "Student"
    }

}
