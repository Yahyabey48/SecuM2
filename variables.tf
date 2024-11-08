variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "mail" {
  type    = string
  default = "zlahcene1@myges.fr"
}

variable "ip_vpc" {
  type    = string
  default = "10.80.0.0/16"
}

variable "ip_subnet" {
  type    = string
  default = "10.80.1.0/24"
}

variable "ip_all" {
  type    = string
  default = "0.0.0.0/0"
}
