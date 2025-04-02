module "kms" {
  source     = "./modules/terraform-google-kms"
  key_ring   = var.keyring
  crypto_key = var.crypto_key
}