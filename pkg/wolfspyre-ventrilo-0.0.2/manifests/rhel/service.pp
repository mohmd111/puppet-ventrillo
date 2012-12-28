# == Class: ventrilo::rhel::service
#  wrapper class
Anchor['ventrilo::config::end'] -> Class['ventrilo::rhel::service']
class ventrilo::rhel::service {
  Service{} -> Anchor['ventrilo::service::end']
  # end of variables
  case $ventrilo::ensure {
    enabled, active: {
      #everything should be installed, but puppet is not managing the state of the service
      service {'ventrilo':
        ensure    => running,
        enable    => true,
        subscribe => File['ventrilo_conf'],
        require   => Package['Ventrilo'],
        hasstatus => true,
      }#end service definition
    }#end enabled class
    disabled, stopped: {
      service {'ventrilo':
        ensure    => stopped,
        enable    => false,
        subscribe => File['ventrilo_conf'],
        hasstatus => true,
      }#end service definition
    }#end disabled
    default: {
      #nothing to do, puppet shouldn't care about the service
    }#end default ensure case
  }#end ensure case
}#end class
