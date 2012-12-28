# == Class: ventrilo::rhel::package
#  wrapper class
#
class ventrilo::rhel::package {
  Package{} -> Anchor['ventrilo::package::end']
  # end of variables
  case $ventrilo::ensure {
    present, enabled, active, disabled, stopped: {
      #everything should be installed
      package { 'Ventrilo':
        ensure => 'present',
      } -> Anchor['ventrilo::package::end']
    }#end present case
    absent: {
      #everything should be removed
      package { 'Ventrilo':
        ensure => 'absent',
      } -> Anchor['ventrilo::package::end']
    }#end absent case
    default: {
      notice "ventrilo::ensure has an unsupported value of ${ventrilo::ensure}."
    }#end default ensure case
  }#end ensure case
}#end class