class etherpad::dependencies {
  if !defined(Package['gzip']) {
    package { 'gzip':
      ensure   => installed
    }
  }
  if !defined(Package['git-core']) {
    package { 'git-core':
      ensure   => installed
    }
  }
  if !defined(Package['curl']) {
    package { 'curl':
      ensure   => installed
    }
  }
  if !defined(Package['python']) {
    package { 'python':
      ensure   => installed
    }
  }
  if !defined(Package['libssl-dev']) {
    package { 'libssl-dev':
      ensure   => installed
    }
  }
  if !defined(Package['pkg-config']) {
    package { 'pkg-config':
      ensure   => installed
    }
  }
  if !defined(Package['build-essential']) {
    package { 'build-essential':
      ensure   => installed
    }
  }

  # - make sure nodejs is installed correctly
  class { 'nodejs':
    version => 'v0.10.15',
  }
}
