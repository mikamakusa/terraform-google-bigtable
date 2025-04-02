## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.11 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | ./modules/terraform-google-kms | n/a |

## Resources

| Name | Type |
|------|------|
| [google_bigtable_app_profile.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_app_profile) | resource |
| [google_bigtable_authorized_view.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_authorized_view) | resource |
| [google_bigtable_gc_policy.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_gc_policy) | resource |
| [google_bigtable_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_instance) | resource |
| [google_bigtable_instance_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_instance_iam_binding) | resource |
| [google_bigtable_table.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_table) | resource |
| [google_bigtable_table_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_table_iam_binding) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_profile"></a> [app\_profile](#input\_app\_profile) | n/a | <pre>list(object({<br/>    id                                = any<br/>    app_profile_id                    = string<br/>    description                       = optional(string)<br/>    multi_cluster_routing_cluster_ids = optional(list(string))<br/>    instance_id                       = optional(any)<br/>    ignore_warnings                   = optional(bool)<br/>    data_boost_isolation_read_only = optional(list(object({<br/>      compute_billing_owner = string<br/>    })), [])<br/>    single_cluster_routing = optional(list(object({<br/>      cluster_id                 = any<br/>      allow_transactional_writes = optional(bool)<br/>    })), [])<br/>    standard_isolation = optional(list(object({<br/>      priority = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_authorized_view"></a> [authorized\_view](#input\_authorized\_view) | n/a | <pre>list(object({<br/>    id                  = any<br/>    instance_id         = any<br/>    name                = string<br/>    table_id            = any<br/>    deletion_protection = optional(string)<br/>    subset_view = optional(list(object({<br/>      row_prefixes = optional(list(string))<br/>      family_subsets = optional(list(object({<br/>        family_name        = string<br/>        qualifiers         = optional(list(string))<br/>        qualifier_prefixes = optional(list(string))<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_crypto_key"></a> [crypto\_key](#input\_crypto\_key) | n/a | `any` | `[]` | no |
| <a name="input_gc_policy"></a> [gc\_policy](#input\_gc\_policy) | n/a | <pre>list(object({<br/>    id              = any<br/>    column_family   = string<br/>    instance_id     = any<br/>    table_id        = any<br/>    mode            = optional(string)<br/>    gc_rules        = optional(map(string))<br/>    deletion_policy = optional(string)<br/>    ignore_warnings = optional(bool)<br/>    max_age = optional(list(object({<br/>      duration = optional(string)<br/>    })), [])<br/>    max_version = optional(list(object({<br/>      number = number<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | <pre>list(object({<br/>    id                  = any<br/>    name                = string<br/>    display_name        = optional(string)<br/>    force_destroy       = optional(bool)<br/>    deletion_protection = optional(bool)<br/>    labels              = optional(map(string))<br/>    cluster = list(object({<br/>      cluster_id   = string<br/>      zone         = optional(string)<br/>      num_nodes    = optional(number)<br/>      storage_type = optional(string)<br/>      kms_key_id   = optional(any)<br/>      autoscaling_config = optional(list(object({<br/>        cpu_target     = number<br/>        max_nodes      = number<br/>        min_nodes      = number<br/>        storage_target = optional(number)<br/>      })), [])<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_instance_iam_binding"></a> [instance\_iam\_binding](#input\_instance\_iam\_binding) | n/a | <pre>list(object({<br/>    id          = any<br/>    instance_id = any<br/>    members     = list(string)<br/>    role        = string<br/>  }))</pre> | `[]` | no |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | n/a | `any` | `[]` | no |
| <a name="input_table"></a> [table](#input\_table) | n/a | <pre>list(object({<br/>    id                      = any<br/>    instance_id             = any<br/>    name                    = string<br/>    split_keys              = optional(list(string))<br/>    deletion_protection     = optional(string)<br/>    change_stream_retention = optional(string)<br/>    automated_backup_policy = optional(list(object({<br/>      retention_period = optional(string)<br/>      frequency        = optional(string)<br/>    })), [])<br/>    column_family = optional(list(object({<br/>      family = string<br/>      type   = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_table_iam_binding"></a> [table\_iam\_binding](#input\_table\_iam\_binding) | n/a | <pre>list(object({<br/>    id          = any<br/>    instance_id = any<br/>    members     = list(string)<br/>    role        = string<br/>    table_id    = any<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_bigtable_app_profile_instance"></a> [google\_bigtable\_app\_profile\_instance](#output\_google\_bigtable\_app\_profile\_instance) | n/a |
| <a name="output_google_bigtable_app_profile_name"></a> [google\_bigtable\_app\_profile\_name](#output\_google\_bigtable\_app\_profile\_name) | # google\_bigtable\_app\_profile |
| <a name="output_google_bigtable_authorized_view_id"></a> [google\_bigtable\_authorized\_view\_id](#output\_google\_bigtable\_authorized\_view\_id) | n/a |
| <a name="output_google_bigtable_authorized_view_name"></a> [google\_bigtable\_authorized\_view\_name](#output\_google\_bigtable\_authorized\_view\_name) | # google\_bigtable\_authorized\_view |
| <a name="output_google_bigtable_gc_policy_id"></a> [google\_bigtable\_gc\_policy\_id](#output\_google\_bigtable\_gc\_policy\_id) | # google\_bigtable\_gc\_policy |
| <a name="output_google_bigtable_gc_policy_mode"></a> [google\_bigtable\_gc\_policy\_mode](#output\_google\_bigtable\_gc\_policy\_mode) | n/a |
| <a name="output_google_bigtable_instance_cluster"></a> [google\_bigtable\_instance\_cluster](#output\_google\_bigtable\_instance\_cluster) | n/a |
| <a name="output_google_bigtable_instance_iam_binding_id"></a> [google\_bigtable\_instance\_iam\_binding\_id](#output\_google\_bigtable\_instance\_iam\_binding\_id) | # google\_bigtable\_instance\_iam\_binding |
| <a name="output_google_bigtable_instance_iam_binding_instance"></a> [google\_bigtable\_instance\_iam\_binding\_instance](#output\_google\_bigtable\_instance\_iam\_binding\_instance) | n/a |
| <a name="output_google_bigtable_instance_name"></a> [google\_bigtable\_instance\_name](#output\_google\_bigtable\_instance\_name) | # google\_bigtable\_instance |
| <a name="output_google_bigtable_table_column_family"></a> [google\_bigtable\_table\_column\_family](#output\_google\_bigtable\_table\_column\_family) | n/a |
| <a name="output_google_bigtable_table_iam_binding_id"></a> [google\_bigtable\_table\_iam\_binding\_id](#output\_google\_bigtable\_table\_iam\_binding\_id) | # google\_bigtable\_table\_iam\_binding |
| <a name="output_google_bigtable_table_iam_binding_instance"></a> [google\_bigtable\_table\_iam\_binding\_instance](#output\_google\_bigtable\_table\_iam\_binding\_instance) | n/a |
| <a name="output_google_bigtable_table_name"></a> [google\_bigtable\_table\_name](#output\_google\_bigtable\_table\_name) | # google\_bigtable\_table |
