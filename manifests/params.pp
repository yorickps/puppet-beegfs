# == Class beegfs::params
#
# This class is meant to be called from beegfs.
# It sets variables according to platform.
#
class beegfs::params {

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          $kernel_packages = ['linux-headers-amd64']
          case $::lsbdistcodename {
            'wheezy': {
              $release = 'deb7'
            }
            'squeeze': {
              $release = 'deb6'
            }
            'jessie': {
              $release = 'deb8'
            }
            'stretch': {
              $release = 'deb9'
            }
            default: {
              $release = 'deb8'
            }
          }
        }
        'Ubuntu': {
          $kernel_packages = ['linux-headers-generic']
          case $::lsbdistcodename {
            'precise': {
              $release = 'deb7'
            }
            'trusty','xenial': {
              $release = 'deb8'
            }
            default: {
              $release = 'deb8'
            }
          }
        }
        default: {
          fail("Family: ${::osfamily} OS: ${::operatingsystem} is not supported yet") #"
        }
      }
    }
    'RedHat': {
      $kernel_packages = ['kernel-devel']
      $repo_defaults = {
        '2015.03' => {
          'descr'   => "BeeGFS 2015.03 (RHEL${::operatingsystemmajrelease})",
          'baseurl' => "http://www.beegfs.com/release/beegfs_2015.03/dists/rhel${::operatingsystemmajrelease}",
          'gpgkey'  => 'http://www.beegfs.com/release/beegfs_2015.03/gpg/RPM-GPG-KEY-beegfs',
        },
      }
      $release = 'redhat'
    }
    default: {
      fail("Family: ${::osfamily} OS: ${::operatingsystem} is not supported yet") #"
    }
  }
}
