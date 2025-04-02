variable "app_profile" {
  type = list(object({
    id                                = any
    app_profile_id                    = string
    description                       = optional(string)
    multi_cluster_routing_cluster_ids = optional(list(string))
    instance_id                       = optional(any)
    ignore_warnings                   = optional(bool)
    data_boost_isolation_read_only = optional(list(object({
      compute_billing_owner = string
    })), [])
    single_cluster_routing = optional(list(object({
      cluster_id                 = any
      allow_transactional_writes = optional(bool)
    })), [])
    standard_isolation = optional(list(object({
      priority = string
    })), [])
  }))
  default = []
}

variable "authorized_view" {
  type = list(object({
    id                  = any
    instance_id         = any
    name                = string
    table_id            = any
    deletion_protection = optional(string)
    subset_view = optional(list(object({
      row_prefixes = optional(list(string))
      family_subsets = optional(list(object({
        family_name        = string
        qualifiers         = optional(list(string))
        qualifier_prefixes = optional(list(string))
      })), [])
    })), [])
  }))
  default = []
}

variable "gc_policy" {
  type = list(object({
    id            = any
    column_family = string
    instance_id   = any
    table_id      = any
  }))
  default = []
}

variable "instance" {
  type = list(object({
    id   = any
    name = string
  }))
  default = []
}

variable "instance_iam_binding" {
  type = list(object({
    id          = any
    instance_id = any
    members     = list(string)
    role        = string
  }))
  default = []
}

variable "table" {
  type = list(object({
    id          = any
    instance_id = any
    name        = string
  }))
  default = []
}

variable "table_iam_binding" {
  type = list(object({
    id          = any
    instance_id = any
    members     = list(string)
    role        = string
    table_id    = any
  }))
  default = []
}
