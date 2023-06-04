variable "token" {
  description = "token in yandex cloud"
  type        = string
  default     = ""
}

variable "cloud_id" {
  description = "Default cloud ID in yandex cloud"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "Default folder ID in yandex cloud"
  type        = string
  default     = ""
}

variable "zone" {
  description = "Default zone"
  type        = string
  default     = "ru-central1-b"
}

variable "k8s_version" {
  description = "Default version of K8s"
  type        = string
  default     = "1.22"
}

variable "sa_name" {
  description = "Default service account"
  type        = string
  default     = "sa-admin"
}