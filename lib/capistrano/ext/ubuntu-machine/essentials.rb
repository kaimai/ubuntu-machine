namespace :essentials do
  
  desc "Install htop for visualizing server process monitor"
  task :htop do
    sudo "apt-get install -y htop"    
  end

  desc "Install dkfilter for domainkeys signing with emails"
  task :dkfilter, :roles => [:web, :app] do
    sudo "apt-get install -y dk-filter"
  end

  desc "Install sun java jdk - DO NOT CALL THIS - it requires a terminal to accept license"
  task :jdk, :roles => [:web, :app] do
    sudo "apt-get install -y sun-java6-jdk"
  end
  
  desc "Install lynx"
  task :lynx do
    sudo "apt-get install -y lynx"
  end

  desc "Install monit"
  task :monit do
    sudo "apt-get install -y monit"
  end
  
  desc "Install gems"
  task :install_gems, :roles => [:web, :app] do
    sudo "gem sources -a http://gems.github.com"
    sudo "gem install rails --no-rdoc --no-ri"
    sudo "gem install rack thin --no-rdoc --no-ri"
    sudo "gem install rails -v 2.2.2 --no-rdoc --no-ri"
    
    # dependency for feedzirra
    sudo "apt-get install -y libxml2-dev"
    #libcurl3-dev is required, but it's is a virtual package
    sudo "apt-get install -y libcurl4-openssl-dev"
    #Package libxslt-dev is a virtual package
    sudo "apt-get install -y libxslt1-dev"
    sudo "gem install pauldix-feedzirra --no-rdoc --no-ri"
    # end of dependency for feedzirra
    
    sudo "gem install capistrano capistrano-ext capitate --no-rdoc --no-ri"
    sudo "apt-get install -y libmysqlclient15-dev"
    sudo "gem install mysql --no-rdoc --no-ri"

  end

  desc "add multiverse to /etc/apt/source.list for sun jdk"
  task :update_source_list do
    sudo "echo 'deb http://archive.ubuntu.com/ubuntu/ hardy multiverse' >> /etc/apt/sources.list"
    sudo "apt-get update"
  end
  
  desc "install essential programs, include gems.  please manually install jdk first.  see the 'jdk' task"
  task :install do
    update_source_list
    htop
    dkfilter
    #jdk
    install_gems
    lynx
    monit
  end

end
