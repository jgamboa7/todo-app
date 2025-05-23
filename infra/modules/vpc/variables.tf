/* variable "region" {
  type = string
}
 */

 variable "azs" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

locals {
  az_subnet_index = {
    "eu-central-1a" = 2
    "eu-central-1b" = 3
    "eu-central-1c" = 4  
  }
}