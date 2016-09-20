# == Class: Komea Foundation::params
#
# This is a container class with default parameters for Komea Foundation classes.
class komea_dashboard_core::params {

  $version                = "sprint"
  $activemq_version       = "5.12.2"
  $komea_security_version = "0.1"

  $default_user           = undef
  $default_password       = undef
  $komea_security_url     = "http://localhost:8096"
  $admin_server_url       = "http://localhost:8089/admin-server"
  $cas_url                = undef
  $komea_gui_url          = undef

  $nexus_url              = undef
  $nexus_repository       = "komea"
  $nexus_third_parties_repository = "komea-third-parties"
  $nexus_user             = undef
  $nexus_password         = undef

  $base_location          = "/opt/echoes/dashboard"
  $logs_location          = "/var/log"

}
