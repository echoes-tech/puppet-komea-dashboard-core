# Private class
class komea_dashboard_core::install (
  $version          = $::komea_dashboard_core::version,
  $activemq_version = $::komea_dashboard_core::activemq_version,
  $komea_security_version = $::komea_dashboard_core::komea_security_version,
  $nexus_url        = $::komea_dashboard_core::nexus_url,
  $nexus_repository = $::komea_dashboard_core::nexus_repository,
  $nexus_third_parties_repository = $::komea_dashboard_core::nexus_third_parties_repository,
  $nexus_user       = $::komea_dashboard_core::nexus_user,
  $nexus_password   = $::komea_dashboard_core::nexus_password,
  $base_location    = $::komea_dashboard_core::base_location
)inherits komea_dashboard_core {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/init.d':
    ensure => 'directory',
    mode   => '0755'
  }

  file { [ '/opt/echoes', "$base_location" ]:
    ensure  => 'directory',
    mode    => '0755'
  }

  #------------ APPLICATION TIMESERIES ------------#

  $app_timeseries_name = "application-timeseries"
  $app_timeseries_path = "$base_location/$app_timeseries_name/"

  file { "$app_timeseries_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_timeseries_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/$app_timeseries_name.sh.erb")
  }

  #---------- APPLICATION ORGANIZATION ----------#

  $app_organization_name = "application-organization"
  $app_organization_path = "$base_location/$app_organization_name/"

  file { "$app_organization_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_organization_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/${app_organization_name}.sh.erb")
  }

  #------------ APPLICATION METRICS ------------#

  $app_metrics_name = "application-metrics"
  $app_metrics_path = "$base_location/$app_metrics_name/"

  file { "$app_metrics_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_metrics_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/${app_metrics_name}.sh.erb")
  }

  #------------- APPLICATION CHARTS -------------#

  $app_charts_name = "application-charts"
  $app_charts_path = "$base_location/$app_charts_name/"

  file { "$app_charts_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_charts_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/${app_charts_name}.sh.erb")
  }

  #--------------- ADMIN SERVER ---------------#

  $app_admin_name = "admin-server"
  $app_admin_path = "$base_location/$app_admin_name/"

  file { "$app_admin_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_admin_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/${app_admin_name}.sh.erb")
  }

  #--------------- API GATEWAY ---------------#

  $app_gateway_name = "api-gateway"
  $app_gateway_path = "$base_location/$app_gateway_name"

  file { "$app_gateway_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_gateway_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/${app_gateway_name}.sh.erb")
  }

  #---------------- ADMIN GUI ----------------#

  $app_gui_name = "admin-gui"
  $app_gui_path = "$base_location/$app_gui_name/"

  file { "$app_gui_path":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "/etc/init.d/$app_gui_name":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/${app_gui_name}.sh.erb")
  }

  #---------------- ACTIVEMQ ----------------#

  $activemq_path  = "${base_location}/apache-activemq"
  $activemq_zip   = "${base_location}/apache-activemq.zip"

  file { "/etc/init.d/activemq":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/activemq.sh.erb")
  }

  #---------- DEPLOY ARTIFACTS FROM NEXUS ----------#

  file { "${base_location}/nexus_deploy_core.sh":
    ensure  => "present",
    owner   => "root",
    group   => 'root',
    mode    => '0770',
    content => template("${module_name}/nexus_deploy_core.sh.erb")
  }

  exec { "deploy-nexus":
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    command => "${base_location}/nexus_deploy_core.sh ${nexus_user} ${nexus_password}",
    timeout => 0
  }

}
