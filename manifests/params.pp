# Class:: etherpad::params
#
#
class etherpad::params {
  $etherpad_title                  = "Etherpad"
  $etherpad_root                   = "/srv/etherpad"
  $etherpad_favicon                = "favicon.ico"
  $etherpad_session_key            = "changeme"
  $etherpad_database_type          = "dirty"
  $etherpad_database_user          = "etherpaddbu"
  $etherpad_database_host          = "localhost"
  $etherpad_database_password      = "changeme"
  $etherpad_database_name          = "etherpaddb"
  $etherpad_dirty_filename         = "var/dirty.db"
  $etherpad_bind_ip                = "0.0.0.0"
  $etherpad_port                   = 9001
  $etherpad_user                   = "etherpad"
  $etherpad_comment                = ""
  $etherpad_pad_text               = "Welcome to etherpad!"
  $etherpad_require_authentication = false
  $etherpad_require_authorization  = false
  $etherpad_require_session        = false
  $etherpad_trust_proxy            = false
  $etherpad_disable_ip_logging     = false
  $etherpad_edit_only              = false
  $etherpad_max_age                = 21600
  $etherpad_users                  = UNDEF
  $etherpad_sources                = "git://github.com/ether/etherpad-lite.git"
  $etherpad_branch                 = "master"
  $etherpad_abiword                = false
} # Class:: etherpad::params
