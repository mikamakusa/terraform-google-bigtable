resource "google_bigtable_app_profile" "this" {
  count                             = length(var.app_profile)
  app_profile_id                    = lookup(var.app_profile[count.index], "app_profile_id")
  description                       = lookup(var.app_profile[count.index], "description")
  multi_cluster_routing_cluster_ids = lookup(var.app_profile[count.index], "multi_cluster_routing_cluster_ids")
  instance                          = element(google_bigtable_instance.this.*.name, lookup(var.app_profile[count.index], "instance_id"))
  ignore_warnings                   = lookup(var.app_profile[count.index], "ignore_warnings")
  project                           = data.google_project.this.project_id

  dynamic "data_boost_isolation_read_only" {
    for_each = try(lookup(var.app_profile[count.index], "data_boost_isolation_read_only") == null ? [] : ["data_boost_isolation_read_only"])
    content {
      compute_billing_owner = lookup(data_boost_isolation_read_only.value, "compute_billing_owner", "HOST_PAYS")
    }
  }

  dynamic "single_cluster_routing" {
    for_each = try(lookup(var.app_profile[count.index], "single_cluster_routing") == null ? [] : ["single_cluster_routing"])
    content {
      cluster_id                 = lookup(single_cluster_routing.value, "cluster_id")
      allow_transactional_writes = lookup(single_cluster_routing.value, "allow_transactional_writes")
    }
  }

  dynamic "standard_isolation" {
    for_each = try(lookup(var.app_profile[count.index], "standard_isolation") == null ? [] : ["standard_isolation"])
    content {
      priority = lookup(standard_isolation.value, "priority")
    }
  }
}

resource "google_bigtable_authorized_view" "this" {
  count               = ((length(var.instance) && length(var.table))) == 0 ? 0 : length(var.authorized_view)
  instance_name       = element(google_bigtable_instance.this.*.name, lookup(var.authorized_view[count.index], "instance_id"))
  name                = lookup(var.authorized_view[count.index], "name")
  table_name          = element(google_bigtable_table.this.*.name, lookup(var.authorized_view[count.index], "table_id"))
  project             = data.google_project.this.project_id
  deletion_protection = lookup(var.authorized_view[count.index], "deletion_protection")

  dynamic "subset_view" {
    for_each = try(lookup(var.authorized_view[count.index], "subset_view") == null ? [] : ["subset_view"])
    content {
      row_prefixes = lookup(subset_view.value, "row_prefixes")

      dynamic "family_subsets" {
        for_each = try(lookup(subset_view.value, "family_subsets") == null ? [] : ["family_subsets"])
        content {
          family_name        = lookup(family_subsets.value, "family_name")
          qualifiers         = lookup(family_subsets.value, "qualifiers")
          qualifier_prefixes = lookup(family_subsets.value, "qualifier_prefixes")
        }
      }
    }
  }
}

resource "google_bigtable_gc_policy" "this" {
  count           = ((length(var.instance) && length(var.table))) == 0 ? 0 : length(var.gc_policy)
  column_family   = lookup(var.gc_policy[count.index], "column_family")
  instance_name   = element(google_bigtable_instance.this.*.name, lookup(var.gc_policy[count.index], "instance_id"))
  table           = element(google_bigtable_table.this.*.name, lookup(var.gc_policy[count.index], "table_id"))
  project         = data.google_project.this.project_id
  mode            = lookup(var.gc_policy[count.index], "mode")
  gc_rules        = lookup(var.gc_policy[count.index], "gc_rules")
  deletion_policy = lookup(var.gc_policy[count.index], "deletion_policy")
  ignore_warnings = lookup(var.gc_policy[count.index], "ignore_warnings")

  dynamic "max_age" {
    for_each = try(lookup(var.gc_policy[count.index], "max_age") == null ? [] : ["max_age"])
    content {
      duration = lookup(max_age.value, "duration")
    }
  }

  dynamic "max_version" {
    for_each = try(lookup(var.gc_policy[count.index], "max_version") == null ? [] : ["max_version"])
    content {
      number = lookup(max_version.value, "number")
    }
  }

}

resource "google_bigtable_instance" "this" {
  count               = length(var.instance)
  name                = lookup(var.instance[count.index], "name")
  project             = data.google_project.this.project_id
  display_name        = lookup(var.instance[count.index], "display_name")
  force_destroy       = lookup(var.instance[count.index], "force_destroy")
  deletion_protection = lookup(var.instance[count.index], "deletion_protection")
  labels              = lookup(var.instance[count.index], "labels")

  dynamic "cluster" {
    for_each = lookup(var.instance[count.index], "cluster")
    content {
      cluster_id   = lookup(cluster.value, "cluster_id")
      zone         = lookup(cluster.value, "zone")
      num_nodes    = lookup(cluster.value, "num_nodes")
      storage_type = lookup(cluster.value, "storage_type")
      kms_key_name = try(element(module.kms.google_kms_crypto_key_id, lookup(cluster.value, "kms_key_id")))

      dynamic "autoscaling_config" {
        for_each = try(lookup(cluster.value, "autoscaling_config") == null ? [] : ["autoscaling_config"])
        content {
          cpu_target     = lookup(autoscaling_config.value, "cpu_target")
          max_nodes      = lookup(autoscaling_config.value, "max_nodes")
          min_nodes      = lookup(autoscaling_config.value, "min_nodes")
          storage_target = lookup(autoscaling_config.value, "storage_target")
        }
      }
    }
  }
}

resource "google_bigtable_instance_iam_binding" "this" {
  count    = length(var.instance) == 0 ? 0 : length(var.instance_iam_binding)
  instance = element(google_bigtable_instance.this.*.name, lookup(var.instance_iam_binding[count.index], "instance_id"))
  members  = lookup(var.instance_iam_binding[count.index], "members")
  role     = lookup(var.instance_iam_binding[count.index], "role")
}

resource "google_bigtable_table" "this" {
  count                   = length(var.instance) == 0 ? 0 : length(var.table)
  instance_name           = element(google_bigtable_instance.this.*.name, lookup(var.table[count.index], "instance_id"))
  name                    = lookup(var.table[count.index], "name")
  project                 = data.google_project.this.project_id
  split_keys              = lookup(var.table[count.index], "split_keys")
  deletion_protection     = lookup(var.table[count.index], "deletion_protection")
  change_stream_retention = lookup(var.table[count.index], "change_stream_retention")

  dynamic "automated_backup_policy" {
    for_each = try(lookup(var.table[count.index], "automated_backup_policy") == null ? [] : ["automated_backup_policy"])
    content {
      retention_period = lookup(automated_backup_policy.value, "retention_period")
      frequency        = lookup(automated_backup_policy.value, "frequency")
    }
  }

  dynamic "column_family" {
    for_each = try(lookup(var.table[count.index], "column_family") == null ? [] : ["column_family"])
    content {
      family = lookup(column_family.value, "family")
      type   = lookup(column_family.value, "type")
    }
  }
}

resource "google_bigtable_table_iam_binding" "this" {
  count    = length(var.table) == 0 ? 0 : length(var.table_iam_binding)
  instance = element(google_bigtable_instance.this.*.name, lookup(var.table_iam_binding[count.index], "instance_id"))
  members  = lookup(var.table_iam_binding[count.index], "members")
  role     = lookup(var.table_iam_binding[count.index], "role")
  table    = element(google_bigtable_table.this.*.name, lookup(var.table_iam_binding[count.index], "table_id"))
}