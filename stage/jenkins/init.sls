# salt state file for provisioning a drizzle-jenkins server

add_jenkins_1:
  cmd.run:
    - name: wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    - order: 1 

add_jenkins_2:
  cmd.run:
    - name:  sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    - order: 2 

update_apt_jenkins:
  cmd.run:
    - name:  apt-get update
    - order: 3 

required_jenkins_packages:
  pkg.installed:
    - pkgs:
      - jenkins
    - order: 4 

job_builder_git:
   git.latest:
    - cwd: /home/ubuntu
    - name: https://github.com/openstack-infra/jenkins-job-builder.git 
    - target: /home/ubuntu/jenkins-job-builder
    - force: True
    - order: 10

install_job_builder:
  cmd.run:
    - name: python setup.py install
    - cwd:  /home/ubuntu/jenkins-job-builder
    - order: 11

/etc/jenkins_jobs/jenkins_jobs.ini:
  file:
    - managed
    - source: salt://jenkins/jenkins_jobs.ini
    - order: 12 

