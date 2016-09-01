# Private class
class komea_dashboard_core::config (
  $activemq_version   = $::komea_dashboard_core::activemq_version,
  $default_user       = $::komea_dashboard_core::default_user,
  $default_password   = $::komea_dashboard_core::default_password,
  $komea_security_url = $::komea_dashboard_core::komea_security_url,
  $base_location      = $::komea_dashboard_core::base_location,
  $logs_location      = $::komea_dashboard_core::logs_location
) inherits komea_dashboard_core {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  #------------ APPLICATION TIMESERIES ------------#

  $app_timeseries_name = "application-timeseries"
  $app_timeseries_path = "$base_location/$app_timeseries_name/"
  $app_timeseries_logs_location = "$logs_location/$app_timeseries_name/"

  file { "${app_timeseries_path}application.properties":
    ensure  => file,
    content => template("${module_name}/$app_timeseries_name.properties.erb"),
  }

  file { "$app_timeseries_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_timeseries_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_timeseries_name}-logback.xml.erb"),
    notify  => Service['application-timeseries']
  }

  #---------- APPLICATION ORGANIZATION ----------#

  $app_organization_name = "application-organization"
  $app_organization_path = "$base_location/$app_organization_name/"
  $app_organization_logs_location = "$logs_location/$app_organization_name/"

  file { "${app_organization_path}application.properties":
    ensure  => file,
    content => template("${module_name}/$app_organization_name.properties.erb"),
  }

  file { "$app_organization_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_organization_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_organization_name}-logback.xml.erb"),
    notify  => Service['application-organization']
  }

  #------------ APPLICATION METRICS ------------#

  $app_metrics_name = "application-metrics"
  $app_metrics_path = "$base_location/$app_metrics_name/"
  $app_metrics_logs_location = "$logs_location/$app_metrics_name/"

  file { "${app_metrics_path}application.properties":
    ensure  => file,
    content => template("${module_name}/$app_metrics_name.properties.erb"),
  }

  file { "$app_metrics_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_metrics_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_metrics_name}-logback.xml.erb"),
    notify  => Service['application-metrics']
  }

  #------------- APPLICATION CHARTS -------------#

  $app_charts_name = "application-charts"
  $app_charts_path = "$base_location/$app_charts_name/"
  $app_charts_logs_location = "$logs_location/$app_charts_name/"

  file { "${app_charts_path}application.properties":
    ensure  => file,
    content => template("${module_name}/$app_charts_name.properties.erb"),
  }

  file { "$app_charts_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_charts_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_charts_name}-logback.xml.erb"),
    notify  => Service['application-charts']
  }

  #-------------- ADMIN SERVER --------------#

  $app_admin_name = "admin-server"
  $app_admin_path = "$base_location/$app_admin_name/"
  $app_admin_logs_location = "$logs_location/$app_admin_name/"

  file { "${app_admin_path}application.properties":
    ensure  => file,
    content => template("${module_name}/$app_admin_name.properties.erb"),
  }

  file { "$app_admin_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_admin_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_admin_name}-logback.xml.erb"),
    notify  => Service['admin-server']
  }

  #--------------- ADMIN GUI ---------------#

  $app_gui_name = "admin-gui"
  $app_gui_path = "$base_location/$app_gui_name/"
  $app_gui_logs_location = "$logs_location/$app_gui_name/"

  file { "${app_gui_path}application.properties":
    ensure  => file,
    content => template("${module_name}/$app_gui_name.properties.erb"),
  }

  file { "$app_gui_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_gui_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_gui_name}-logback.xml.erb"),
    notify  => Service['admin-gui']
  }

  #------------- API GATEWAY --------------#

  $app_gateway_name = "api-gateway"
  $app_gateway_path = "$base_location/$app_gateway_name/"
  $app_gateway_logs_location = "$logs_location/$app_gateway_name/"

  file { "${app_gateway_path}/application.properties":
    ensure => file,
    content => template("${module_name}/$app_gateway_name.properties.erb")
  }

  file { "$app_gateway_logs_location":
    ensure  => 'directory',
    mode    => '0755'
  }

  file { "${app_gateway_path}logback.xml":
    ensure  => file,
    content => template("${module_name}/${app_gateway_name}-logback.xml.erb"),
    notify  => Service['api-gateway']
  }

  #--------------- ACTIVEMQ ---------------#

  $activemq_path  = "${base_location}/apache-activemq"
  #$activemq_location = "${activemq_path}-${activemq_version}"

  file { "${activemq_path}-${activemq_version}/conf/activemq.xml":
    ensure  => file,
    content => template("${module_name}/activemq.xml.erb"),
    notify => Service['activemq']
  }

}
