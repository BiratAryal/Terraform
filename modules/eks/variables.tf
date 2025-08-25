variable "cluster_name"       { type = string }
variable "cluster_version"    { type = string }
variable "vpc_id"             { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "tags" { 
      type = map(string)
       default = {} 
}
variable "node_groups" {
  description = "Map of EKS managed node groups to create"
  type = map(object({
    instance_types = list(string)
    capacity_type  = optional(string, "ON_DEMAND") # ON_DEMAND or SPOT
    min_size       = number
    max_size       = number
    desired_size   = number
    ami_type       = optional(string)              # AL2_x86_64 / AL2_ARM_64 / etc.
    labels         = optional(map(string), {})
    taints         = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
    subnets        = optional(list(string))        # override cluster subnets (optional)
  }))
}

variable "cluster_enabled_log_types" {
  description = "Control plane logs to CloudWatch"
  type        = list(string)
  default     = ["api","audit","authenticator","controllerManager","scheduler"]
}
