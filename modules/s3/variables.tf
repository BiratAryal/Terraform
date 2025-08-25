variable "bucket_name"        { type = string }
variable "enable_access_logs" { 
    type = bool
    default = true 
}
variable "tags"               { 
    type = map(string)
    default = {} 
}
