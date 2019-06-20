#!/bin/sh

# SCRIPT DE INSTALAÇÃO DO MEU AMBIENTE DE TRABALHO.
# ELE É FORNECIDO COMO ESTÁ. USE POR SUA CONTA E RISCO.
# ATUALIZADO EM 29/12/2017

# Atualiza o Sistema Operacional para a versão mais recente possível.
atualizar_so() { 
    apt-get update
    apt-get upgrade
    apt-get dist-upgrade
}

instalar_essenciais() {
    apt-get install -y build-essential
    # Editor de texto de linha de comando
    apt-get install -y vim
    # Ferramenta de descompressão
    apt-get install -y unzip
    # Gerenciador de código-fonte
    apt-get install -y git git-core
    # Dependências do GnuCash
    apt-get install -y gnupg2 dirmngr
    # Cliente de Torrent
    apt-get install -y transmission
    # Unrar
    echo "deb http://ftp.de.debian.org/debian jessie main non-free" >> /etc/apt/sources.list
    apt-get update
    apt-get install -y rar
    # CD/DVD Burner
    apt-get install -y brasero
}

instalar_java() {
    # MAIS INFORMAÇÕES EM: http://www.webupd8.org/2015/02/install-oracle-java-9-in-ubuntu-linux.html
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
    apt-get update
    apt-get install -y oracle-java9-installer
}

instalar_postgresql() {
    # REPOSITÓRIO OFICIAL DO POSTGRESQL
    # MAIS INFORMAÇÕES EM: https://www.postgresql.org/download/linux/debian/
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update

    # NA ORDEM: Servidor, modulos adicionais, bibliotecas e binarios cliente, desenvolvimento frontend, desenvolvimento backend, ferramenta administrativa
    apt-get install -y postgresql-10 postgresql-contrib-10 postgresql-client-10 libpq-dev postgresql-server-dev-10

    # ALTERACAO DA SENHA PADRAO
    su postgres
    psql -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';"
    exit

    # Ferramentas de apoio
    apt-get install -y pgadmin3
}

instalar_sqlite3() {
    apt-get install -y sqlite3
}

instalar_mariadb() {
    apt-get install software-properties-common dirmngr
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
    add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.ufscar.br/mariadb/repo/10.2/debian stretch main'
    apt-get update
    apt-get install -y mariadb-server
    # Ferramenta para modelagem e gerenciamento
    apt-get install -y mysql-workbench
}

instalar_php() {
    # instala apache2 e php5
    apt-get install -y apache2 php7.0 libapache2-mod-php7.0
    # instala extenção SQLite para php5
    apt-get install -y php7.0-sqlite3
    # instala extenção PostgreSQL para php5
    apt-get install -y php7.0-pgsql
    # instala extenção GD (biblioteca gráfica) para php5
    apt-get install -y php7.0-gd
    # instala extenção CURL
    apt-get install -y php7.0-curl
    # instala extenção IMAP
    apt-get install -y libc-client-dev php7.0-imap
    phpenmod imap
    # instala extenção INTL (internationalization)
    apt-get install -y php7.0-intl
    # extenção SOAP, JSON e XML
    apt-get install -y php7.0-xml php7.0-soap php7.0-json php7.0-xmlrpc
    # extenção zip
    apt-get install -y php7.0-zip
    # extenção mbstring
    apt-get install -y php7.0-mbstring
    # extenção mcrypt
    apt-get install -y php7.0-mcrypt
    # extenção apcu para cache
    apt-get install -y php7.0-apcu
    # extenção MySQL/MariaDB
    apt-get install -y php7.0-mysql
}

instalar_ruby() {
    apt-get install -y curl gnupg libmagickcore-dev libmagickwand-dev
    apt-get install -y ruby ruby-dev rubygems libruby ruby-full libapache2-mod-passenger
    # Dependencia do Jekyll
    curl -sL https://deb.nodesource.com/setup_9.x | bash -
    apt-get install -y nodejs
    gem install rails
    gem install jekyll
    # Depencencias do Redmine
    gem install bundler
    # Phusionpassenger
    apt-get install -y dirmngr gnupg
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    apt-get install -y apt-transport-https ca-certificates
    sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger stretch main > /etc/apt/sources.list.d/passenger.list'
    apt-get update
    apt-get install -y libapache2-mod-passenger
    a2enmod passenger
    systemctl reload apache2
    passenger-config validate-install
    passenger-memory-stats
}

instalar_ftp() {
    apt-get install -y vsftpd
}

instalar_munin() {
    apt-get install -y libcgi-fast-perl libapache2-mod-fcgid
    a2enmod fcgid
    apt-get install -y munin munin-node munin-plugins-extra
    # Se usar PostgreSQL
    apt-get install -y libdbd-pg-perl
}

instalar_virtualbox() {
    echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" | tee /etc/apt/sources.list.d/virtualbox.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
    apt-get update
    # Note: Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade
    apt-get install -y virtualbox-5.2 dkms

    # VirtualBox Extension Pack
    version=$(vboxmanage -v)
    #echo $version
    var1=$(echo $version | cut -d 'r' -f 1)
    #echo $var1
    var2=$(echo $version | cut -d 'r' -f 2)
    #echo $file
    #echo $var2
    file="Oracle_VM_VirtualBox_Extension_Pack-$var1-$var2.vbox-extpack"
    wget http://download.virtualbox.org/virtualbox/$var1/$file -O /tmp/$file
    VBoxManage extpack install /tmp/$file --replace
}

instalar_snort() {
    apt-get install -y snort snort-common snort-common-libraries snort-rules-default
}

exibir_avisos_inicializacao() {
    echo "ATENCAO, ESTE SCRIPT E COMPATIVEL APENAS COM DISTRIBUICOES DEBIAN E DERIVADOS."
    echo "TESTADO COM DEBIAN 9.0 DE 29/12/2017."
    echo "USE POR SUA CONTA E RISCO."
}

exibir_avisos_encerramento() {
    echo "1. Configure o UserDir Apache, referencias:"
    echo "http://www.techytalk.info/enable-userdir-apache-module-ubuntu-debian-based-linux-distributions/"
    echo "http://ubuntuserverguide.com/2012/10/how-to-enable-and-configure-apache2-userdir-module-in-ubuntu-server-12-04.html"
    echo "2. Crie uma chave SSH"
    echo "ssh-keygen -t rsa -b 4096 -C \"your_email@example.com\""
    echo "3. Configure o munin em /etc/munin/munin.conf"
    echo "Exemplo: https://www.howtoforge.com/tutorial/server-monitoring-with-munin-and-monit-on-debian/"
    echo "4. Ruby+Phusionpassenger+Apache2"
    echo "https://www.phusionpassenger.com/library/install/apache/install/oss/stretch/#step-3:-check-installation"
    echo "https://www.phusionpassenger.com/library/deploy/apache/deploy/ruby/"
    echo "https://www.phusionpassenger.com/library/install/apache/install/oss/trusty/"
}

instalar() {
    exibir_avisos_inicializacao
    atualizar_so
    instalar_essenciais
    instalar_java
    instalar_postgresql
    instalar_sqlite3
    instalar_mariadb
    instalar_php
    instalar_ruby
    instalar_ftp
    instalar_munin
    instalar_virtualbox
    exibir_avisos_encerramento
}

# INICIAR PROCESSO DE INSTALAÇÃO
instalar