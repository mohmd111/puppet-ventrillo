# == Class: ventrilo::rhel::config
#  wrapper class
#
#  iptables rule should we ever decide to add iptables rules automagically:
#      -A RH-Firewall-1-INPUT -p tcp -m tcp --dport ventriloport -j ACCEPT
#
Anchor['ventrilo::package::end'] -> Class['ventrilo::rhel::config']
class ventrilo::rhel::config {
  include ventrilo::params #make our parameters local scope
  File{} -> Anchor['ventrilo::config::end']
  $ensure        = $ventrilo::ensure
  $adminpassword = $ventrilo::adminpass
  $authmode      = $ventrilo::authmode
  $autokick      = $ventrilo::autokick
  $chanclients   = $ventrilo::chanclients
  $chandepth     = $ventrilo::chandepth
  $chanwidth     = $ventrilo::chanwidth
  $closestd      = $ventrilo::closestd
  $disablequit   = $ventrilo::disablequit
  $duplicates    = $ventrilo::duplicates
  $extrabuffer   = $ventrilo::extrabuffer
  $logontimeout  = $ventrilo::logontimeout
  $password      = $ventrilo::password
  $pingrate      = $ventrilo::pingrate
  $recvbuffer    = $ventrilo::recvbuffer
  $sendbuffer    = $ventrilo::sendbuffer
  $servername    = $ventrilo::servername
  $silentlobby   = $ventrilo::silentlobby
  $timestamp     = $ventrilo::timestamp
  $ventport      = $ventrilo::ventport
  $voicecodec    = $ventrilo::voicecodec
  $voiceformat   = $ventrilo::voiceformat
  # end of variables
  case $ensure {
    present, enabled, active, disabled, stopped: {
      #everything should be installed
      file {'ventrilo_conf':
        ensure  => 'present',
        path    =>  "/usr/local/ventsrv/${ventport}.ini",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('ventrilo/usr/local/ventsrv/ventrilo_srv.ini.erb'),
      }#end ventrilo_conf file

      file {'ventrilo_defaultconf':
        ensure  => 'present',
        path    => '/usr/local/ventsrv/ventrilo_srv.ini',
        owner   => 'ventrilo',
        group   => 'ventrilo',
        mode    => '0644',
        source  => "puppet:///modules/${module_name}/ventrilo_srv.ini"
      }#end ventrilod.conf file

      file {'/usr/local/ventsrv':
        ensure => 'directory',
        owner  => 'ventrilo',
        group  => 'ventrilo',
        mode   => '0755',
      }#End ventrilo dir

      file {'/etc/init.d/ventrilo':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template('ventrilo/etc/init.d/ventrilo_srv.ini.erb'),
      }#End init file

    }#end configfiles should be present case
    absent: {
      file {'ventrilo_conf':
        ensure  => 'absent',
        path    =>  "/usr/local/ventsrv/${ventport}.ini",
      }#end ventrilod.conf file
      file {'ventrilo_defaultconf':
        ensure  => 'absent',
        path    => '/usr/local/ventsrv/ventrilo_srv.ini',
      }#end ventrilod.conf file
      file {'/etc/init.d/ventrilo':
        ensure => 'absent',
      }#End init file
      file {'/usr/local/ventsrv':
        ensure => 'absent',
        force  => true,
      }#end ventrilodir

    }#end configfiles should be absent case
    default: {
      notice "ventrilo::params::ensure has an unsupported value of ${ventrilo::params::ensure}."
    }#end default ensure case
  }#end ensure case
}#end class