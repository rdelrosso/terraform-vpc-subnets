#Sets the region from the interpolation variable
provider "aws" {
  region     = var.region
}

#Creates a resource of tyope VPC in aws
resource "aws_vpc" "bunga2" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "main"
    Location = "ireland"
  } 
}

#Loop cycle to create one Private Subnet in each of the 3 single AZs in HA 
resource "aws_subnet" "PrivateSubnet" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  vpc_id     = aws_vpc.bunga2.id
  cidr_block = "${element(var.PrivateSubnets_CIDRs,count.index)}"

  tags = {
    Name = "PrivateSubnet-${count.index+1}"
  }
}

#Loop cycle to create one Public Subnet in each of the 3 single AZs in HA 
resource "aws_subnet" "PublicSubnet" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  vpc_id     = aws_vpc.bunga2.id
  cidr_block = "${element(var.PublicSubnets_CIDRs,count.index)}"

  tags = {
    Name = "PublicSubnet-${count.index+1}"
  }
}
