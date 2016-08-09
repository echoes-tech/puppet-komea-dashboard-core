# puppet-komea-dashboard-core

Manage Komea Dashboard core functionalities installation and configuration from Puppet.

## Requirements

* **java** 1.7 or higher
* package **curl**
* package **zip/unzip**
* a running **ElasticSearch** _(version 2.3 or higher)_ database that can be accessed by the machine that will host Komea Dashboard 

## Parameters

| Parameter              | Value type | Default value | Description | 
|:----------------------:|:----------:|:-------------:|-------------|
| version                | _String_ | _sprint_ | Komea Dashboard's version that will be installed | 
| activemq_version       | _String_ | _5.12.2_ | Apache ActiveMQ's version                        | 
| komea_security_version | _String_ | _0.1_    | Komea Security's version                         |
| default_user           | _String_ | _undef_  | The username of a valid Komea Security's user that will be used by the microservices to communicate with each other |
| default_password       | _String_ | _undef_  | The password of the Komea Security's user that will be used by the microservices to communicate with each other |
| nexus_url              | _String_ | _undef_  | The url of the Nexus server that will be used to retrieve Komea Dashboard's artifacts |
| nexus_repository       | _String_ | _komea_  | The name of the Nexus repository that contains Komea Dashboard Core's artifacts       |
| nexus_third_parties_repository | _String_ | _komea-third-parties_ | The name of the Nexus repository that contains Komea Dashboard's third parties components _(Apache ActiveMQ, etc)_ |
| nexus_user             | _String_ | _undef_  | The username of a valid Nexus user with the necessary privileges to download all required artifacts |
| nexus_password         | _String_ | _undef_  | The password of the Nexus user that will be used to download the required artifacts |
| base_location          | _String_ | _/opt/echoes/dashboard_ | The path of the directory where Komea Dashboard Core components will be installed (the directory will be automatically created if it does not exist) |
| log_location           | _String_ | _/var/log_ | The path of the directory that will contains all output logs of each Komea Dashboard's microservice |
