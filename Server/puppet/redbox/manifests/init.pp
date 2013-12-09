# == Class: redbox
#
# Full description of class redbox here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { redbox:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class redbox {

  include variables::defaults

  Exec { 
    path => $variables::defaults::exec_path, 
    logoutput => true,
  }
  
  host { $::hostname:
      ip => '127.0.0.1',
  }
 
  anchor { 'redbox::begin:': }
  ->
  systemuser_add { $variables::defaults::redbox_user: }
  -> 
  directory_add { $variables::defaults::directories: 
    owner =>  $variables::defaults::redbox_user,
    } 
  ->
  packages { $variables::defaults::package_type: }  
  ->
  exec {'wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/deploy.sh  -O /home/redbox/deploy.sh':}
  ->
  file {"/home/redbox/deploy.sh":
    ensure  => file,
    owner   => $variables::defaults::redbox_user,
    group   => $variables::defaults::redbox_user,
    mode    => 744,
    require => Exec['wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/deploy.sh  -O /home/redbox/deploy.sh'],
  }
  -> anchor { 'redbox::end': }
}
