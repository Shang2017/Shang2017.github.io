# ST-Linux_MP 

## help 


1. confirm proxy: wget -q www.google.com && echo "OK" || echo "KO"
2. git confirm: git ls-remote git://git.openembedded.org/openembedded-core && echo "OK" || echo "KO"
3. repo install:  
     export REPO=$(mktemp /tmp/repo.XXXXXXXXX)  
     curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo  
     gpg --recv-key 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65  
     curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo   
     need change gpg server:  
     gpg --keyserver keyserver.ubuntu.com --recv-key xxxxx  

4. git proxy:  
     git config --global http(s).proxy 192.168.1.132:800  
     git config --global http(s)_proxy socks5 192.168.1.132:800  

5. ssh proxy:
     echo 'exec corkscrew 192.168.1.132 800 $*' > $HOME/git-config.sh  
     chmod 700 $HOME/bin/git-proxy.sh

6. git socks5 error:  
     git config --global --unset http.proxy
     git config --global --unset https.proxy

7. ERROR: binutils-2.34-r0 do_compile: oe_runmake failed  
      bitbake -c cleanall binutils
      bitbake -c listtasks st-image-weston  

8. ip addr show  
   ip addr add xx.xx  dev eth0
   ip link set eth0 up
   ip route show  
   ip route add 192.168.2.0/16 via 192.168.1.1 dev eth0
   gateway: ip route add default via 192.168.1.1

9. nslookup github.com  
   nslookup github.global.ssl.fastly.net
   /etc/hosts

10. bash dot command: . filename.sh ,run at current shell.  
    ./filename.sh run at subshell, export in file has no effect in current shell




      





## initial 

1. user:szm password:123
2. export http_proxy=http://192.168.1.132:800
3. export https_proxy=http://192.168.1.132:800
4. alias sudo='sudo http_proxy=$http_proxy'

## Directoy 

1.   STM32/Starter-Package  
           Developer-Package   
           Distribution-Package

2.   cd Distribution-Package  
     repo init  
     repo sync

3.   

## modify 

1. devtool modify virtual/kernel create workspace directory

2.   devtool search u-boot*

3.   devtool modify u-boot-stm32mp  

4.   devtool build u-boot-stm32mp

5.   bitbake u-boot-stm32mp -c deploy

6.   devtool modify m4projects-stm32mp1 sources/m4projects-stm32mp1

## dpkg

1. dpkg -l
2. dpkg -i *.deb
3. dpkg -r package  //remove
4. dpkg -L package //list file
5. dpkg -S file   //a file belong package



