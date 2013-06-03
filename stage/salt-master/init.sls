# salt-state file for creating a salt-master for drizzle-ci

add_salt_ppa:
  cmd.run:
    - name: 'sudo add-apt-repository ppa:saltstack/salt'
    - order: 1 

update_apt_salt_master:
  cmd.run:
    - name: 'apt-get update'
    - order: 2

required_salt_master_packages:
 pkg.installed:
    - pkgs:
      - git
      - debconf-utils
      - build-essential
      - python-setuptools
      - python-dev
      - salt-cloud
    - order: 1

salt:
  pkg:
    - latest
  service.running:
    - require:
      - file: /etc/salt/minion
      - pkg: salt
    - names:
      - salt-master
      - salt-minion
    - watch:
      - file:  /etc/salt/minion
      - file: /etc/salt/master

/etc/salt/master:
  file:
    - managed
    - source:  salt://salt-master/master
    - user:  root
    - group: root
    - mode: 644
    - require:
      - pkg: salt

/etc/salt/minion:
  file:
    - managed
    - source: salt://salt-master/minion
    - user:  root
    - group: root
    - mode: 644
    - require:
      - pkg: salt


