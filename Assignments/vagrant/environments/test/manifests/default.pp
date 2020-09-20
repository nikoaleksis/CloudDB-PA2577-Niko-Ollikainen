# Execute on all nodes

node default {

    # Execute apt-get update

    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
    }

# Ensure curl is installed
  package { 'curl':
    require => Exec['apt-get update'],
    ensure => installed,
  }

  #Install node.js
    exec { 'get-node':
        require => [Exec['apt-get update'], Package['curl']],
        command => '/usr/bin/curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -',
    }

    package { 'nodejs': 
        require => Exec['get-node'],
        ensure => installed,
    }

}
