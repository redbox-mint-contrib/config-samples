user {'redbox':
      ensure => present,
      managehome => true,
}
host { $::hostname:
    ip => '127.0.0.1',
}

file { "/opt/redbox":
    ensure => "directory",
    owner  => "redbox",
    group  => "redbox"
}

file { "/opt/mint":
    ensure => "directory",
    owner  => "redbox",
    group  => "redbox",
}

class { 'apache':
      default_mods => false,
}

apache::mod { 'proxy_http': }

$proxy_pass = [
  { 'path' => '/redbox', 'url' => 'http://localhost:9000/redbox' },
  { 'path' => '/mint', 'url' => 'http://localhost:9001/mint' }
]

apache::vhost { $::ipaddress:
      docroot     => '/var/www/html',
      port    => '80',
      proxy_pass => $proxy_pass,
}

package { "java-1.7.0-openjdk.x86_64":
        ensure => installed,
}

