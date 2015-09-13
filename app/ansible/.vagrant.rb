Vagrant.configure('2') do |c|
  c.vm.provision "shell", inline: "echo 'Acquire::http { Proxy \"http://192.168.31.254:31000\"; };' | tee /etc/apt/apt.conf.d/01proxy"
  c.vm.provision "shell", inline: "apt-get install -y libssl-dev libreadline-dev zlib1g-dev"
  c.vm.provision "shell", inline: "cd /tmp && wget https://github.com/sstephenson/ruby-build/archive/v20150818.tar.gz && tar -xvf v20150818.tar.gz && cd ruby-build-20150818 && bash install.sh"
  c.vm.provision "shell", inline: "apt-get install -y gcc"
  c.vm.provision "shell", inline: "/usr/local/bin/ruby-build -4 2.2.2 /usr"
end
