variable "aws_region" {
  default = "us-west-2"
}

variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}

variable "aws_key_pair_file" {
  default = ""
}

variable "aws_key_pair_name" {
  default = ""
}

variable "aws_image_user" {
  default = "centos"
}

variable "local_hart_dir" {
  default = "/Users/echohack/code/national-parks/results"
}

variable "np_mongodb_hart" {
  default = "echohack-np-mongodb-3.2.9-20180110194804-x86_64-linux.hart"
}

variable "national_parks_hart" {
  default = "echohack-national-parks-6.8.0-20180110193239-x86_64-linux.hart"
}
