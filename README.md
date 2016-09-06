#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with Komea Dashboard](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Komea Dashboard Core](#beginning-with-komea-dashboard-core)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors](#contributors)

## Overview

Puppet module to manage Komea Dashboard core functionalities installation and configuration.

## Module Description

This module installs and configures the following [Komea Dashboard](https://echoes.fr/ksf/)'s components:

* **application-timeseries**: REST API for accessing and storing _TimeSeries_ ;
* **application-organization**: REST API for accessing and storing _Organization_ data ;
* **application-metrics**: REST API for accessing and storing data about _metrics, kpis and connectors' options_ ; 
* **application-charts**: REST API used by Liferay Portal to build charts from _TimeSeries_ and _Organization_ data ;
* **api-gateway**: The front door for all requests from connectors and web sites to _Komea Dashboard_'s microservices ; 
* **admin-server**: Application used for monitoring Komea Dashboard's microservices statuses ;
* **admin-gui**: Application used for managing Komea Dashboard's entities, kpis and metrics ;
* **ActiveMQ**: Message system used to handle asynchronous communication between _Komea Dashboard_'s components.

## Setup

### Setup Requirements

* **java** 1.7 or higher
* package **curl**
* package **zip/unzip**
* a running **ElasticSearch** _(version 2.3 or higher)_ database that can be accessed by the machine that will host Komea Dashboard 

Supports Puppet v3 (optionally with future parser) and v4 with Ruby versions 1.8.7 (Puppet v3 only), 1.9.3, 2.0.0 and 2.1.0.

### Beginning with Komea Dashboard Core

```puppet
include ::komea_dashboard_core
```

## Reference

### Classes

#### Public classes

* komea_dashboard_core: Main class, includes all other classes.

#### Private classes

* komea_dashboard_core::params: Sets parameter defaults per operating system.
* komea_dashboard_core::install: Handles the packages.
* komea_dashboard_core::config: Handles the configuration file.
* komea_dashboard_core::service: Handles the services.

#### Parameters

The following parameters are available in the `::komea_dashboard_core` class:

##### `version`

Specifies the Komea Dashboard's version that will be installed. Valid options: string. Default value: 'sprint'.

##### `activemq_version`

Specifies the Apache ActiveMQ's version that will be used by Komea Dashboard. Valid options: string. Default value: '5.12.2'.

##### `komea_security_version`

Specifies the Komea Security's version that will be used by Komea Dashboard. Valid options: string. Default value: '0.1'.

##### `default_user`

Specifies the username of a valid Komea Security's user that will be used by the microservices to communicate with each other. Valid options: string. Default value: _undef_.

##### `default_password`

Specifies the password of the Komea Security's user that will be used by the microservices to communicate with each other. Valid options: string. Default value: _undef_.

##### `nexus_url`

Specifies the url of the Nexus server that will be used to retrieve Komea Dashboard's artifacts. Valid options: string. Default value: _undef_.

##### `nexus_repository`

Specifies the name of the Nexus repository that contains Komea Dashboard Core's artifacts. Valid options: string. Default value: 'komea'.

##### `nexus_third_parties_repository`

Specifies the name of the Nexus repository that contains Komea Dashboard's third parties components _(ex: Apache ActiveMQ)_. Valid options: string. Default value: 'komea-third-parties'.

##### `nexus_user`

Specifies the username of a valid Nexus user with the necessary privileges to download all required artifacts. Valid options: string. Default value: _undef_.

##### `nexus_password`

Specifies the password of the Nexus user that will be used to download the required artifacts. Valid options: string. Default value: _undef_.

##### `base_location`

Specifies the path of the directory where Komea Dashboard Core components will be installed (the directory will be automatically created if it does not exist). Valid options: string. Default value: '/opt/echoes/dashboard'.

##### `logs_location`

Specifies the path of the directory that will contains all output logs of each Komea Dashboard's microservice. Valid options: string. Default value: '/var/log'.

## Limitations

Debian family OSes are officially supported. Tested and built on Debian.

## Development

[Echoes Technologies](https://echoes.fr) modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great.

## Contributors

The list of contributors can be found at: https://github.com/echoes-tech/puppet-komea-dashboard-core/graphs/contributors
