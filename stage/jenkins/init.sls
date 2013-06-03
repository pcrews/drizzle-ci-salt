# salt state file for provisioning a drizzle-jenkins server

add_jenkins_1:
  cmd.run:
    - name: wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    - order: 1 

add_jenkins_2:
  cmd.run:
    - name:  sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    - order: 2 

update_apt:
  cmd.run:
    - name:  apt-get update
    - order: 3 

required_packages:
  pkg.installed:
    - pkgs:
      - jenkins
    - order: 4 

