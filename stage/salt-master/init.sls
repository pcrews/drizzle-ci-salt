# salt-state file for creating a salt-master for drizzle-ci

add_salt_ppa:
  cmd.run:
    - name: 'sudo add-apt-repository ppa:saltstack/salt'
    - order: 1 

update_apt:
  cmd.run:
    - name: 'apt-get update'
    - order: 2

required_packages:
 pkg.installed:
    - pkgs:
      - git
      - debconf-utils
      - build-essential
      - python-setuptools
      - python-dev
      - salt-master
      - salt-minion
      - salt-cloud
    - order: 1
 
