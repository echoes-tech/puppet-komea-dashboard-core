# Private class
class komea_dashboard_core::service inherits komea_dashboard_core {

  if $caller_module_name != $module_name {
      fail("Use of private class ${name} by ${caller_module_name}")
  }

  #------------ APPLICATION TIMESERIES ------------#

  service { 'application-timeseries':
    ensure => running,
    start   => "/etc/init.d/application-timeseries start",
    stop    => "/etc/init.d/application-timeseries stop",
    status  => "/etc/init.d/application-timeseries status",
  }

  #----------- APPLICATION ORGANIZATION -----------#

  service { 'application-organization':
    ensure => running,
    start   => "/etc/init.d/application-timeseries start",
    stop    => "/etc/init.d/application-timeseries stop",
    status  => "/etc/init.d/application-timeseries status",
  }

  #------------- APPLICATION METRICS --------------#

  service { 'application-metrics':
    ensure => running,
    start   => "/etc/init.d/application-metrics start",
    stop    => "/etc/init.d/application-metrics stop",
    status  => "/etc/init.d/application-metrics status",
  }

  #-------------- APPLICATION CHARTS ---------------#

  service { 'application-charts':
    ensure => running,
    start   => "/etc/init.d/application-charts start",
    stop    => "/etc/init.d/application-charts stop",
    status  => "/etc/init.d/application-charts status",
  }

  #---------------- ADMIN SERVER ------------------#

  service { 'admin-server':
    ensure => running,
    start   => "/etc/init.d/admin-server start",
    stop    => "/etc/init.d/admin-server stop",
    status  => "/etc/init.d/admin-server status",
  }

  #----------------- ADMIN GUI -------------------#

  service { 'admin-gui':
    ensure => running,
    start   => "/etc/init.d/admin-gui start",
    stop    => "/etc/init.d/admin-gui stop",
    status  => "/etc/init.d/admin-gui status",
  }

  #------------------ ACTIVEMQ --------------------#

  service { 'activemq':
    ensure => running,
    start   => "/etc/init.d/activemq start",
    stop    => "/etc/init.d/activemq stop",
    status  => "/etc/init.d/activemq status",
  }

}
