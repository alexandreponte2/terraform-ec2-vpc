variable "region" {
  default = "us-east-1"
}

variable "cdirs_acesso_remoto" {
  type    = list(string)
  default = ["your-ip/32"]
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Name        = "goku",
    project     = "goku",
    environment = "gohan"
  }
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}


variable "key_name" {
  default = "your-key"
}