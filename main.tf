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
  count         = ((length(var.instance) && length(var.table))) == 0 ? 0 : length(var.gc_policy)
  column_family = ""
  instance_name = ""
  table         = ""
}

resource "google_bigtable_instance" "this" {
  count = length(var.instance)
  name  = ""
}

resource "google_bigtable_instance_iam_binding" "this" {
  count    = length(var.instance) == 0 ? 0 : length(var.instance_iam_binding)
  instance = ""
  members  = []
  role     = ""
}

resource "google_bigtable_table" "this" {
  count         = length(var.instance) == 0 ? 0 : length(var.table)
  instance_name = ""
  name          = ""
}

resource "google_bigtable_table_iam_binding" "this" {
  count    = length(var.table) == 0 ? 0 : length(var.table_iam_binding)
  instance = ""
  members  = []
  role     = ""
  table    = ""
}