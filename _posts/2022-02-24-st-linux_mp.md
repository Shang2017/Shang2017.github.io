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