variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "instance_type_list" {
  type    = list(string)
  default = ["t3.micro", "t3.small"] # must be in your region
}


variable "instance_type_map" {
  type = map(string)
  default = {
    small  = "t3.micro"
    medium = "t3.small"
    large  = "t3.medium"
  }
}

variable "size" {
  type    = string
  default = "small"
}

