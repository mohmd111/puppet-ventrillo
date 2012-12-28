# == Class: ventrilo
#
# This module enables the configuration and management of a Ventrillo
# Server. see www.ventrillo.com for details on ventrilo
# an RPM spec file, an RPM, init script, and config template are provided.
#
# === Parameters
#
#
# [*ventrilo_ensure*]
#   whether or not to install and enable the service
#
# [*ventrilo_servername*]
#   The name the server displays
#
# [*ventrilo_authmode*]
#   This is the authentication mode. Supported values are:
#     0 = No authentication and anyone can connect.
#     1 = Global password authentication.
#     2 = Specific user/password authentication.
#
# [*ventrilo_duplicates*]
#   Enables or disables duplicate login names. Supported values are:
#     0 = Disables duplicates.
#     1 = Allows duplicate login names.
#
# [*ventrilo_adminpassword*]
#   This is the remote server administration password.
#   Leaving this option blank will disable remote admin logins.
#   This password is used by normal login accounts and they activate a menu
#   option to have admin rights assigned to their login.
#
# [*ventrilo_password*]
#   This is the global login password for when authmode=1. All users connecting
#   to this server must have this password, otherwise the server will send back
#   an error message saying that they could not be authenticated.
#
# [*ventrilo_sendbuffer*]
#   This option specifies the size of the TCP outbound buffers to each client.
#   The value is in bytes.  A value of 0 will force the program to use a
#   default value of 131072 bytes. If you have a smaller value then I recommend
#   setting it to 0 and let the program use its default.
#   In the servers log file there will be a line starting with "MSG_CONN" when
#   a new client connects. At the end of this line will be two pairs of numbers
#   (A,B) (C,D). The A number is the buffer size as defined by your platform.
#   The B number is the buffer size as reported by the system after the
#   Ventrilo server has changed it. The number could be larger or smaller
#   depending on the platform.
#
# [*ventrilo_recvbuffer*]
#    This option specifies the size of the TCP inbound buffers for each client.
#    The value is in bytes. A value of 0 will force the program to use it's
#    default settings of 131072 bytes per client connection. In the servers log
#    file there will be a line starting with "MSG_CONN" when a new client
#    connects. At the end of this line will be two pairs of numbers (A,B) (C,D)
#    The C number is the buffer size as defined by your platform. The D number
#    is the buffer size as reported by the system after the Ventrilo server has
#    changed it. The number could be larger or smaller depending on the
#    platform.
#
# [*ventrilo_LogonTimeout*]
#   This option specifies in seconds how long a client has to logon to the
#   server before it is automatically disconnected. Once logged on the option
#   has no meaning.
#
# [*ventrilo_TimeStamp*]
#  This option enables or disables timestamp's being displayed in console
#   messages. This includes remote consoles. Supported values:
#     0 = Disable console timestamp's.
#     1 = Enable console timestamp's.
#
# [*ventrilo_PingRate*]
#   This option allows the administrator to change the interval at which the
#   server pings the clients. The value is specified in seconds and defaults to
#   10. Setting to a lower value might be useful for diagnosing problem clients
#   especially when the remote console command "pingtrace" is used.
#
# [*ventrilo_ExtraBuffer*]
#   This option allows the administrator to give each outbound client data
#   stream additional buffer space but it's allocated and controlled by the
#   server instead of relying on the TCP stack implementation. A value of 0
#   instructs the server to use it's default value of 128K bytes of extra
#   buffer space. Any attempt to change the value will usually make any
#   existing problems worse. It remains intact for historical purposes.
#
# [*ventrilo_ChanWidth*]
#  This option specifies a maximum number of parallel sub-channels that can be
#  created in each channel. It has no effect on root level channels which only
#  server admin's can create. A value of 0 means there is no limit.
#
# [*ventrilo_ChanDepth*]
#   This option specifies the maximum number of nested sub-channels (depth)
#   that can be created. A value of 0 means the server will use it's default
#   max value of 8 nested channels.
#
# [*ventrilo_chanclients*]
#   This option specifies the maximum number of clients allowed in any channel.
#   A value of 0 means there is no limit to the number of clients per channel.
#
# [*ventrilo_disablequit*]
#   This option prevents remote console commands (those typed into the chat
#   window when logged in with server admin rights) from issuing the "quit"
#   command which would instruct the server to exit the system. However, if the
#   server was started in a non-daemon mode the local console can still issue
#   the quit command. Supported values:
#     0 = Allow remote consoles to issue the "quit" command.
#     1 = Disable (prevent) remote console from issuing the "quit" command.
#
# [*ventrilo_voicecodec*]
#   This option tells the server which codec all clients must use. The value
#   is a 0 based index into a list of possible codec's. To see the list of
#   currently supported codec types issue the command "ventrilo_srv -?" and the
#   program will display a table of codec's and their associated formats.
#   0 = GSM
#   1 = DSP Group TrueSpeech
#   2 = Lernout & Hauspie
#   3 = Speex
#
#
# [*ventrilo_voiceformat*]
#   This option is the second part of VoiceCodec. Each codec can have one or
#   more possible formats that control the quality and bandwidth usage of the
#   specified codec. To see the list of currently supported codec formats issue
#   the command "ventrilo_srv -?" and the program will display a table of
#   codec's and their associated formats.
#
# [*ventrilo_silentlobby*]
#   This option allows or suppresses replication of voice, wave binds and TTS
#   binds when the client is in the main lobby. Supported values:
#     0 = Allow replication.
#     1 = Suppress replication, thus making the lobby silent.
#
# [*ventrilo_autokick*]
#   This option enables auto-kicking of a client after it has been connected
#   for X number of seconds. A value of 0 disables the autokick feature,
#   otherwise it specifies the number of seconds that a client is allowed to
#   remain connected before the server will automatically disconnect them. This
#   feature is primarily intended for professional hosting services who setup
#   servers for potential customers to test the quality of the hosters network
#   and machines, while at the same time prevent people from hijacking the
#   server for their own private use.
#
# [*ventrilo_ventport*]
#    The TCP port ventrilo will listen on. Default is 3784.
#
# === Variables
#
# example hiera variable
#ventrilo_ensure:       'enabled'
#ventrilo_servername:   %{hostname}
#ventrilo_authmode:     '0'
#ventrilo_duplicates:   '0'
#ventrilo_adminpassword:
#ventrilo_password:
#ventrilo_sendbuffer:   '0'
#ventrilo_recvbuffer:   '0'
#ventrilo_logontimeout: '5'
#ventrilo_closestd:     '1'
#ventrilo_timestamp:    '0'
#ventrilo_pingrate:     '10'
#ventrilo_extrabuffer:  '0'
#ventrilo_chanwidth:    '0'
#ventrilo_chandepth:    '0'
#ventrilo_chanclients:  '0'
#ventrilo_disablequit:  '1'
#ventrilo_ventport:     '3784'
#ventrilo_voicecodec:   '0'
#ventrilo_voiceformat:  '1'
#ventrilo_silentlobby:  '0'
#ventrilo_autokick:     '0'
# === Examples
#
#  class { ventrilo:
#    ventrilo_adminpassword => 'c@llMEmayb?'
#  }
#
# === Authors
#
# Wolf Noble <wolfspyre@wolfspaw.com>
#
# === Copyright
#
# Copyright 1999 Flagship Industries, unless otherwise noted.
#
class ventrilo(
  $ventrilo_ensure        = hiera('ventrilo_ensure',       'enabled'),
  $ventrilo_adminpassword = hiera('ventrilo_adminpass',    UNDEF ),
  $ventrilo_authmode      = hiera('ventrilo_authmode',     '0'),
  $ventrilo_autokick      = hiera('ventrilo_autokick',     '0' ),
  $ventrilo_chanclients   = hiera('ventrilo_chanclients',  '0' ),
  $ventrilo_chandepth     = hiera('ventrilo_chandepth',    '0' ),
  $ventrilo_chanwidth     = hiera('ventrilo_chanwidth',    '0' ),
  $ventrilo_closestd      = hiera('ventrilo_closestd',     '1' ),
  $ventrilo_disablequit   = hiera('ventrilo_disablequit',  '1' ),
  $ventrilo_duplicates    = hiera('ventrilo_duplicates',   '0'),
  $ventrilo_extrabuffer   = hiera('ventrilo_extrabuffer',  '0' ),
  $ventrilo_logontimeout  = hiera('ventrilo_logontimeout', '5' ),
  $ventrilo_password      = hiera('ventrilo_password',     UNDEF ),
  $ventrilo_pingrate      = hiera('ventrilo_pingrate',     '10' ),
  $ventrilo_recvbuffer    = hiera('ventrilo_recvbuffer',   '0' ),
  $ventrilo_sendbuffer    = hiera('ventrilo_sendbuffer',   '0' ),
  $ventrilo_servername    = hiera('ventrilo_servername',   $::fqdn ),
  $ventrilo_silentlobby   = hiera('ventrilo_silentlobby',  '0' ),
  $ventrilo_timestamp     = hiera('ventrilo_timestamp',    '0' ),
  $ventrilo_ventport      = hiera('ventrilo_ventport',     '3784' ),
  $ventrilo_voicecodec    = hiera('ventrilo_voicecodec',   '0' ),
  $ventrilo_voiceformat   = hiera('ventrilo_voiceformat',  '1' )
  ) {
  #take advantage of the Anchor pattern
  anchor{'ventrilo::begin':}
  -> anchor {'ventrilo::package::begin':}
  -> anchor {'ventrilo::package::end':}
  -> anchor {'ventrilo::config::begin':}
  -> anchor {'ventrilo::config::end':}
  -> anchor {'ventrilo::service::begin':}
  -> anchor {'ventrilo::service::end':}
  -> anchor {'ventrilo::end':}
  #clean up our parameters
  $ensure        = $ventrilo_ensure
  $adminpassword = $ventrilo_adminpassword
  $authmode      = $ventrilo_authmode
  $autokick      = $ventrilo_autokick
  $chanclients   = $ventrilo_chanclients
  $chandepth     = $ventrilo_chandepth
  $chanwidth     = $ventrilo_chanwidth
  $closestd      = $ventrilo_closestd
  $disablequit   = $ventrilo_disablequit
  $duplicates    = $ventrilo_duplicates
  $extrabuffer   = $ventrilo_extrabuffer
  $logontimeout  = $ventrilo_logontimeout
  $password      = $ventrilo_password
  $pingrate      = $ventrilo_pingrate
  $recvbuffer    = $ventrilo_recvbuffer
  $sendbuffer    = $ventrilo_sendbuffer
  $servername    = $ventrilo_servername
  $silentlobby   = $ventrilo_silentlobby
  $timestamp     = $ventrilo_timestamp
  $voicecodec    = $ventrilo_voicecodec
  $voiceformat   = $ventrilo_voiceformat
  case $::osfamily {
    #RedHat Debian Suse Solaris Windows
    RedHat: {
      include ventrilo::rhel::package
      include ventrilo::rhel::config
      include ventrilo::rhel::service
    }#end RHEL variant case
    default: {
      notice "There is not currently a ventrilo module for $::osfamily"
    }#end default unsupported OS case
  }
}#end of ventrilo class