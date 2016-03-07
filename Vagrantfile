Dotenv.load
Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.2"
  config.vm.box_url = "https://atlas.hashicorp.com/bento/boxes/centos-7.2"
  config.vm.network "public_network", ip: ENV['IP_VIRTUAL_BOX']
  config.vm.network "public_network", ip: ENV['IP_VIRTUAL_BOX_BRIDGE']
  # pipeworkで指定されているため
  config.vm.provider "virtualbox" do |v|
    # '82540EM'なのは、pipeworkの指定する'Am79C973'だと"public_network"の設定が反映されないため
    v.customize ['modifyvm', :id, '--nictype2', '82540EM']
    v.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    v.customize ['modifyvm', :id, '--nictype3', '82540EM']
    v.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
  end
  config.vm.provision :shell, :path => "install.sh"
  # dockerを2回に分けて記述しているのは1回でやろうとするとprovision時にcontainerが起動しなくなるため
  # http://bufferings.hatenablog.com/entry/2015/01/28/000833
  tagName = ENV['MAINTAINER'] + "/" + ENV['TAG_NAME']
  config.vm.provision "docker-build", type: "docker" do |d|
    d.build_image "/vagrant", args: "-t " + tagName
  end
  config.vm.provision :shell, :path => "reset_container.sh"
  config.vm.provision "docker-run", type: "docker" do |d|
    d.run tagName, args: "--privileged -d -i -t -v /vagrant/docker:/tmp/shared"
  end
  config.vm.provision :shell, :inline => "docker ps -l | awk 'NR>1 {print $1}' | xargs -i pipework br1 {} " + ENV['IP_DOCKER_CONTAINER'], run: "always"
  config.vm.provision :shell, :inline => "ip addr add " + ENV['IP_DOCKER_CONTAINER_BRIDGE']+ " dev br1", run: "always"
  config.vm.provision :shell, :inline => "brctl addif br1 enp0s9", run: "always"
end
