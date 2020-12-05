# Prerequisites: In order for this script to work you need Terraform installed
# AWS cli must be configured with the key beforehand so no keys are stored as variables within the scripts, instead they get picked from the aws conf which is encrypted

#VPC Region
variable "region" {
  default = "eu-west-1"
}
#Main VPC CIDR Block
variable "vpc_cidr" {
  default = "10.203.0.0/16"
}

# Retrieves dynamically a list of AWS Availability Zones available on a given Region
# In this case the Region is set to eu-west-1
# It will only be necessary to change the Region variable value to change az attributes values in each subnet
data "aws_availability_zones" "azs" {
  state = "available"
}

# List of CIDR for all Private Subnets
variable "PrivateSubnets_CIDRs" {
  type = list
  default = ["10.203.23.0/25","10.203.23.128/25","10.203.24.0/25"]
}

# List of CIDR for all Public Subnets
variable "PublicSubnets_CIDRs" {
  type = list
  default = ["10.203.25.0/25","10.203.25.128/25","10.203.26.0/25"]
}



# ALL FOLLOWING SINGLE VARIABLES HAVE BEEN REPLACED BY THE LIST FOR LOOPING THROUGH DYNAMICALLY
/* #Subnets CIDR Blocks
variable "PrivateSubnet1_cidr" {
  default = "10.203.23.0/25"
}
variable "PrivateSubnet2_cidr" {
  default = "10.203.23.128/25"
}
variable "PrivateSubnet3_cidr" {
  default = "10.203.24.0/25"
}
variable "PublicSubnet1_cidr" {
  default = "10.203.25.0/25"
}
variable "PublicSubnet2_cidr" {
  default = "10.203.25.128/25"
}
variable "PublicSubnet3_cidr" {
  default = "10.203.26.0/25"
} */

