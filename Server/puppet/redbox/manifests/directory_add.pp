define redbox::directory_add($end_path = $title, $owner) {
    file { "/opt/${end_path}":
      ensure  => directory,
      recurse => true,
      owner   => $owner,
      require => Systemuser_add[$owner],
    }                                    
}

