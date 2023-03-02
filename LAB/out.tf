output "sp_id_out" {
  value = [for sp in azuread_service_principal.service_principal : sp.application_id]
}