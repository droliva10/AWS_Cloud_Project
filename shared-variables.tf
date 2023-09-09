variable "environment" {
  description = "The name of the environment in which the resources will be created'"
  default     = "malware-lab"
}
variable "ami" {
  description = "The Amazon Machine Image (AMI) ID of the created FlareVM."
}

variable "account" {
  description = "The AWS account ID to use for the resources"
}

variable "region" {
  description = "The AWS region to use for the resources"
  default     = "eu-west-1"
}

variable "enable_guacamole" {
  description = "Whether to enable the Guacamole server for remote access to the instances (If enabled the FlareVM will have not Internet)"
  default     = false
}

variable "enable_inetsim" {
  description = "Whether to enable the InetSim network simulation tool on the instances"
  default     = false
}