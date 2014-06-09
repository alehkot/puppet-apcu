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

  ensure_packages( ['libpcre3-dev'] )

  php::pecl::module { "apcu-${version}":
    use_package         => false,
    service_autorestart => true,
    preferred_state     => 'beta',
    require             => [
      Class['php'],
    ],
  }

  php::augeas { 'augeas-apcu':
    entry  => "PHP/extension[. = \"apcu.so\"]",
    value  => 'apcu.so',
    notify  => Service['httpd'],
    require             => [
      Class['php'],
    ],
  }
}
