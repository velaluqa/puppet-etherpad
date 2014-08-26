# == Class: etherpad
#
# === Parameters
#
# [etherpad_title] Etherpad title (default: "Etherpad").
# [etherpad_root] Where to install etherpad to (default: "/srv/etherpad").
# [etherpad_favicon] Etherpad favicon (default: "favicon.ico").
# [etherpad_session_key] Etherpad session key (default: "changeme").
# [etherpad_database_type] Etherpad database type (default: "dirty").
# [etherpad_database_user] Etherpad database user (default: "etherpaddbu").
# [etherpad_database_host] Etherpad database host (default: "localhost").
# [etherpad_database_password] Etherpad database password (default: "changeme").
# [etherpad_database_name] Etherpad database name (default: "etherpaddb").
# [etherpad_dirty_filename] Etherpad dirty filename (default: "var/dirty.db").
# [etherpad_bind_ip] Bind etherpad to a specific ip (default: "0.0.0.0").
# [etherpad_port] The port to run etherpad with (default: 9001).
# [etherpad_user] The username for the etherpad user (default: "etherpad").
# [etherpad_comment] The user comment for etherpad user (default: "").
# [etherpad_pad_text] The default content for a new pad (default: "Welcome to etherpad!").
# [etherpad_require_authentication] Require authentication (default: false).
# [etherpad_require_authorization] Require authorization (default: false).
# [etherpad_require_session] Require session (default: false).
# [etherpad_trust_proxy] (default: false)
# [etherpad_disable_ip_logging] Disable IP logging (default: false).
# [etherpad_edit_only] Edit only (default: false).
# [etherpad_max_age] Maximum session age (default: 21600).
# [etherpad_users] Hash of users (default: UNDEF).
# [etherpad_sources] Etherpad repository (default: "git://github.com/ether/etherpad-lite.git").
# [etherpad_branch] Etherpad repository branch (default: "master").
# [etherpad_abiword] Etherpad abiword support (default: false).
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
