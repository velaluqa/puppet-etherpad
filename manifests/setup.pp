class etherpad::setup {
  $etherpad_user    = $etherpad::etherpad_user
  $etherpad_root    = $etherpad::etherpad_root
  $etherpad_sources = $etherpad::etherpad_sources
  $etherpad_comment = $etherpad::etherpad_comment

  user { $etherpad_user:
    ensure   => present,
    shell    => '/bin/bash',
    password => '*',
    home     => $etherpad_root,
    comment  => $etherpad_comment,
    system   => true
  }

  file { '/etc/init.d/etherpad':
    ensure => file,
    content => template("etherpad/init.erb"),
    owner => "root",
    group => "root",
    mode => 0755,
  }

  file { $etherpad_root:
    ensure => directory,
    owner => $etherpad_user,
    group => $etherpad_user,
    mode => 0755,
  }

  file { "/var/log/etherpad":
    ensure => directory,
    owner => $etherpad_user,
    group => $etherpad_user,
    mode => 0755,
  }

  exec { 'etherpad-clone':
    path => '/bin:/usr/bin',
    unless => "[ -d '${etherpad_root}/.git' ]",
    require => File[$etherpad_root],
    command => "git clone ${etherpad_sources} ${etherpad_root}",
    user => $etherpad_user,
    group => $etherpad_user,
  }

  exec { 'etherpad-fetch':
    path => '/bin:/usr/bin',
    command => "bash -c 'cd ${etherpad_root}; git fetch'",
    require => Exec["etherpad-clone"],
    user => $etherpad_user,
    group => $etherpad_user
  }

  exec { "etherpad-upgrade":
    path => "/bin:/usr/bin",
    onlyif => "bash -c 'cd ${etherpad_root}; git diff HEAD..origin/${etherpad_branch} | grep -q ^---'",
    command => "bash -c 'cd ${etherpad_root}; git checkout origin/${etherpad_branch}'",
    require => Exec['etherpad-fetch'],
    user => $etherpad_user,
    group => $etherpad_user
  }
}
