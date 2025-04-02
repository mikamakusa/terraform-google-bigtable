## google_bigtable_app_profile
output "google_bigtable_app_profile_name" {
  value = try(google_bigtable_app_profile.this.*.name)
}

output "google_bigtable_app_profile_instance" {
  value = try(google_bigtable_app_profile.this.*.instance)
}

## google_bigtable_authorized_view
output "google_bigtable_authorized_view_name" {
  value = try(google_bigtable_authorized_view.this.*.name)
}

output "google_bigtable_authorized_view_id" {
  value = try(google_bigtable_authorized_view.this.*.id)
}

## google_bigtable_gc_policy
output "google_bigtable_gc_policy_id" {
  value = try(google_bigtable_gc_policy.this.*.id)
}

output "google_bigtable_gc_policy_mode" {
  value = try(google_bigtable_gc_policy.this.*.mode)
}

## google_bigtable_instance
output "google_bigtable_instance_name" {
  value = try(google_bigtable_instance.this.*.name)
}

output "google_bigtable_instance_cluster" {
  value = try(google_bigtable_instance.this.*.cluster)
}

## google_bigtable_instance_iam_binding
output "google_bigtable_instance_iam_binding_id" {
  value = try(google_bigtable_instance_iam_binding.this.*.id)
}

output "google_bigtable_instance_iam_binding_instance" {
  value = try(google_bigtable_instance_iam_binding.this.*.instance)
}

## google_bigtable_table
output "google_bigtable_table_name" {
  value = try(google_bigtable_table.this.*.name)
}

output "google_bigtable_table_column_family" {
  value = try(google_bigtable_table.this.*.column_family)
}

## google_bigtable_table_iam_binding
output "google_bigtable_table_iam_binding_id" {
  value = try(google_bigtable_table_iam_binding.this.*.id)
}

output "google_bigtable_table_iam_binding_instance" {
  value = try(google_bigtable_table_iam_binding.this.*.instance)
}
