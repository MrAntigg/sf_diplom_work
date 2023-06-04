variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "container-optimized-image"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "srv" {
  description = "Count of srv nodes"
  type        = number
  default     = 1
}

variable "ssh_credentials" {
  description = "Credentials for connect to instances"
  type        = object({
    user        = string
    private_key = string
    pub_key     = string
  })
  default     = {
    user        = "gitlab-runner"
    private_key = "/.ssh/id_ed25519"
    pub_key     = "/.ssh/id_ed25519.pub"
  }
}

variable "gitlab_token" {
  description = "gitlab token"
  type        = string
  default     = ""
}

variable "ya_token" {
  description = "ya token"
  type        = string
  default     = ""
}

variable "k8s_cluster_id" {
  description = "K8s cluster ID"
  type        = string
}