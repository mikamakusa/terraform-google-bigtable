## Modules

variable "keyring" {
  type    = any
  default = []
}

variable "crypto_key" {
  type    = any
  default = []
}

## Resources

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
    id              = any
    column_family   = string
    instance_id     = any
    table_id        = any
    mode            = optional(string)
    gc_rules        = optional(map(string))
    deletion_policy = optional(string)
    ignore_warnings = optional(bool)
    max_age = optional(list(object({
      duration = optional(string)
    })), [])
    max_version = optional(list(object({
      number = number
    })), [])
  }))
  default = []
}

variable "instance" {
  type = list(object({
    id                  = any
    name                = string
    display_name        = optional(string)
    force_destroy       = optional(bool)
    deletion_protection = optional(bool)
    labels              = optional(map(string))
    cluster = list(object({
      cluster_id   = string
      zone         = optional(string)
      num_nodes    = optional(number)
      storage_type = optional(string)
      kms_key_id   = optional(any)
      autoscaling_config = optional(list(object({
        cpu_target     = number
        max_nodes      = number
        min_nodes      = number
        storage_target = optional(number)
      })), [])
    }))
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
    id                      = any
    instance_id             = any
    name                    = string
    split_keys              = optional(list(string))
    deletion_protection     = optional(string)
    change_stream_retention = optional(string)
    automated_backup_policy = optional(list(object({
      retention_period = optional(string)
      frequency        = optional(string)
    })), [])
    column_family = optional(list(object({
      family = string
      type   = optional(string)
    })), [])
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
