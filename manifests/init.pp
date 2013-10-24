# == Class: etherpad
#
# === Parameters
#
# TODO: Add parameters
#
# === Examples
#
# TODO: Add examples
#
# === Authors
#
# Arthur Leonard Andersen <leoc.git@gmail.com>
#
# === Copyright
#
# See LICENSE file, Arthur Leonard Andersen (c) 2013

# Class:: etherpad
#
class etherpad(
  $etherpad_title                  = $etherpad::params::etherpad_title,
  $etherpad_root                   = $etherpad::params::etherpad_root,
  $etherpad_favicon                = $etherpad::params::etherpad_favicon,
  $etherpad_session_key            = $etherpad::params::etherpad_session_key,
  $etherpad_database_type          = $etherpad::params::etherpad_database_type,
  $etherpad_database_user          = $etherpad::params::etherpad_database_user,
  $etherpad_database_host          = $etherpad::params::etherpad_database_host,
  $etherpad_database_password      = $etherpad::params::etherpad_database_password,
  $etherpad_database_name          = $etherpad::params::etherpad_database_name,
  $etherpad_dirty_filename         = $etherpad::params::etherpad_dirty_filename,
  $etherpad_bind_ip                = $etherpad::params::etherpad_bind_ip,
  $etherpad_port                   = $etherpad::params::etherpad_port,
  $etherpad_user                   = $etherpad::params::etherpad_user,
  $etherpad_comment                = $etherpad::params::etherpad_comment,
  $etherpad_pad_text               = $etherpad::params::etherpad_pad_text,
  $etherpad_require_authentication = $etherpad::params::etherpad_require_authentication,
  $etherpad_require_authorization  = $etherpad::params::etherpad_require_authorization,
  $etherpad_require_session        = $etherpad::params::etherpad_require_session,
  $etherpad_trust_proxy            = $etherpad::params::etherpad_trust_proxy,
  $etherpad_disable_ip_logging     = $etherpad::params::etherpad_disable_ip_logging,
  $etherpad_edit_only              = $etherpad::params::etherpad_edit_only,
  $etherpad_max_age                = $etherpad::params::etherpad_max_age,
  $etherpad_users                  = $etherpad::params::etherpad_users,
  $etherpad_sources                = $etherpad::params::etherpad_sources,
  $etherpad_branch                 = $etherpad::params::etherpad_branch,
  $etherpad_abiword                = $etherpad::params::etherpad_abiword,
) inherits etherpad::params {

  class { 'etherpad::dependencies': }

  class { 'etherpad::setup':
    require => Class['etherpad::dependencies'],
  }

  file { "${etherpad_root}/settings.json":
    content => template("etherpad/settings.json.erb"),
    owner => $etherpad_user,
    group => $etherpad_user,
    mode => "0755",
    require => Class['etherpad::setup'],
  }

  # ensure the service is running
  service { "etherpad":
    ensure => running,
    enable => true,
    require => [ Class["etherpad::dependencies"], Class['etherpad::setup'], File["${etherpad_root}/settings.json"] ],
    subscribe => [ Class["etherpad::dependencies"], Class['etherpad::setup'], File["${etherpad_root}/settings.json"] ],
  }
} # Class:: etherpad
