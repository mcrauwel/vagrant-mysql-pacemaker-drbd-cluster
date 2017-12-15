# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))
Vagrant.configure("2") do |config|

  (1..2).each do |i|
    config.vm.define "node#{i}" do |node|
      file_to_disk0 =  File.join(VAGRANT_ROOT, "./node#{i}-0.vdi")
      file_to_disk1 =  File.join(VAGRANT_ROOT, "./node#{i}-1.vdi")

      node.vm.box = "centos/7"
      node.vm.hostname = "node#{i}"
      node.vm.network "private_network", ip: "172.16.2.6#{i}"

      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"

        unless File.exist?(file_to_disk0)
          vb.customize ['createhd', '--filename', file_to_disk0, '--size', 20 * 1024]
        end
        unless File.exist?(file_to_disk1)
          vb.customize ['createhd', '--filename', file_to_disk1, '--size', 20 * 1024]
        end
        vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk0]
        vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', file_to_disk1]
      end

      node.vm.provision "shell", inline: <<-SHELL
        echo "hello from node #{i}"

        rpm -ivh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
        rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org
        yum -y install drbd84-utils kmod-drbd84

        echo "127.0.0.1 localhost
172.16.2.61 node1
172.16.2.62 node2
172.16.2.63 node3
172.16.2.41 virtip1
172.16.2.42 virtip2
        " > /etc/hosts

        cp /vagrant/testdata1.res /etc/drbd.d/
        drbdadm create-md testdata1
        drbdadm up testdata1
        drbdadm attach testdata1

        cp /vagrant/testdata2.res /etc/drbd.d/
        drbdadm create-md testdata2
        drbdadm up testdata2
        drbdadm attach testdata2

        systemctl start drbd
        systemctl enable drbd

        yum install -y pacemaker pcs fence-agents-all psmisc policycoreutils-python

        echo "redhat" | passwd --stdin hacluster
        systemctl start pcsd
        systemctl enable pcsd

        systemctl enable corosync.service
        systemctl enable pacemaker.service

        rpm -ivh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

        yum install -y mysql-community-server

        sed -i s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config
        semanage permissive -a drbd_t
        setenforce 0

        rm -rf /var/lib/mysql

        cp /vagrant/my.cnf /etc/my.cnf

      SHELL

    end
  end

  config.vm.define "node3" do |node|
    node.vm.box = "centos/7"
    node.vm.hostname = "node3"
    node.vm.network "private_network", ip: "172.16.2.63"

    node.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    node.vm.provision "shell", inline: <<-SHELL
      echo "hello from node 3"

      echo "
172.16.2.61 node1
172.16.2.62 node2
172.16.2.63 node3
172.16.2.41 virtip1
172.16.2.42 virtip2
      " > /etc/hosts

      yum install -y pacemaker pcs fence-agents-all psmisc policycoreutils-python

      echo "redhat" | passwd --stdin hacluster
      systemctl start pcsd
      systemctl enable pcsd

      systemctl enable corosync.service
      systemctl enable pacemaker.service

      sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
      semanage permissive -a drbd_t
      setenforce 0
    SHELL


  end

end
