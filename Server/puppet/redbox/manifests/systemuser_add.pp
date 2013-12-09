define redbox::systemuser_add($username=$title, $shell='/bin/sh') {

user { $username:
    ensure     => present,
    home       => "/home/$username",
    shell      => $shell,
    system     => true,
    managehome => true,
  }                                    
}
