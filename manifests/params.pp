# Class:: etherpad::params
#
#
class etherpad::params {
  $etherpad_title                  = "Etherpad"
  $etherpad_root                   = "/srv/etherpad"
  $etherpad_favicon                = "favicon.ico"
  $etherpad_session_key            = "changeme"
  $etherpad_db_type                = "dirty"
  $etherpad_mysql_user             = "etherpaddbu"
  $etherpad_mysql_host             = "localhost"
  $etherpad_mysql_password         = "changeme"
  $etherpad_mysql_database         = "etherpaddb"
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
