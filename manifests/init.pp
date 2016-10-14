class komea_dashboard_core (
  $version            = $::komea_dashboard_core::params::version,
  $activemq_version   = $::komea_dashboard_core::params::activemq_version,
  $komea_security_version = $komea_dashboard_core::params::komea_security_version,
  $default_user       = $::komea_dashboard_core::params::default_user,
  $default_password   = $::komea_dashboard_core::params::default_password,
  $komea_security_url = $::komea_dashboard_core::params::komea_security_url,
  $admin_server_url   = $::komea_dashboard_core::params::admin_server_url,
  $cas_url            = $::komea_dashboard_core::params::cas_url,
  $komea_gui_url      = $::komea_dashboard_core::params::komea_gui_url,
  $nexus_repository   = $::komea_dashboard_core::params::nexus_repository,
  $nexus_third_parties_repository = $::komea_dashboard_core::params::nexus_third_parties_repository,
  $nexus_url          = $::komea_dashboard_core::params::nexus_url,
  $nexus_user         = $::komea_dashboard_core::params::nexus_user,
  $nexus_password     = $::komea_dashboard_core::params::nexus_password,
  $nexus_komea_group_id = $::komea_dashboard_core::params::nexus_komea_group_id,
  $nexus_security_group_id = $::komea_dashboard_core::params::nexus_security_group_id,
  $nexus_apache_group_id = $::komea_dashboard_core::params::nexus_apache_group_id,
  $base_location      = $::komea_dashboard_core::params::base_location,
  $logs_location      = $::komea_dashboard_core::params::logs_location
) inherits komea_dashboard_core::params {

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::install": } ->
  class { "${module_name}::config": } ~>
  class { "${module_name}::service": } ->
  anchor { "${module_name}::end": }

}
