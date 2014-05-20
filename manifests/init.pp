# == Class: apcu
#
# This class installs the apcu package.
#
# === Parameters
#
# [*version*]
#   The version of the package to install. Defaults to '4.0.4'.
#
# === Examples
#
#   class { 'apcu': }
#
# === Requirements
#
# This class requires the apache class from PuppetLabs.
class apcu($version = '4.0.4') {  

  exec { 'apcu-install':
    command => "pecl install pecl.php.net/apcu-$version",    
    require => Package['build-essential'],
  }
  
  exec { 'apcu-prerequisites':
    command => 'apt-get install libpcre3-dev',
  }

  file { '/etc/php5/apache2/conf.d/apcu.ini':
    source  => 'puppet:///modules/apcu/apcu.ini',
    require => [Exec['apcu-install'], Exec['apcu-prerequisites']],
    notify  => Service['httpd'],    
  }
}
