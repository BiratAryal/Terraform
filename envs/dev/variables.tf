variable "env"             { type = string }
variable "aws_region"      { type = string }

variable "name"            { type = string }  # vpc name base
variable "cidr"            { type = string }
variable "azs"             { type = list(string) }
variable "public_subnets"  { type = list(string) }
variable "private_subnets" { type = list(string) }

variable "cluster_name"    { type = string }
variable "cluster_version" { type = string }

variable "app_bucket"      { type = string }
variable "enable_access_logs" {
  type = bool
  default = true 
}

variable "tags"            {
   type = map(string)
   default = {} 
}

variable "ha_enabled" {
  description = "If true, use 3-AZ spread and HA node-group shape"
  type        = bool
  default     = false
}

variable "node_groups" {
  description = "EKS managed node groups map for this environment"
  type = map(object({
    instance_types = list(string)
    capacity_type  = optional(string, "ON_DEMAND")
    min_size       = number
    max_size       = number
    desired_size   = number
    ami_type       = optional(string)
    labels         = optional(map(string), {})
    taints         = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
    subnets        = optional(list(string))
  }))
}
