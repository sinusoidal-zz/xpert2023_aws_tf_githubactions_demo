variable "studentid" {
  default = "student<xx>"
  description = "Your student ID"
}

variable "region" {
  default = "eu-west-3"
  description = "The AWS region."
}

variable "prefix" {
  default = "xpertsummit"
  description = "The name of our company"
}

variable "environment" {
  default = "development"
  description = "The name of our env"
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.remote_state.id}"
}

variable "access_key" {
description = "The AWS access key."
}

variable "secret_key" {
description = "The AWS access secret."
}
