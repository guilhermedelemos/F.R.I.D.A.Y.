#!/bin/sh

exibir_avisos_inicializacao() {
    echo "ATENCAO, ESTE SCRIPT E COMPATIVEL APENAS COM DISTRIBUICAO UBUNTU BIONIC."
    echo "TESTADO E ATUALIZADO EM 13/05/2018."
    echo "USE POR SUA CONTA E RISCO."
}

instalar() {
    exibir_avisos_inicializacao
    atualizar_so
    instalar_especificos
    instalar_essenciais
    instalar_java
    instalar_postgresql
    instalar_sqlite3
    instalar_php
    instalar_virtualbox
    exibir_avisos_encerramento
}

# Atualiza o Sistema Operacional para a versão mais recente possível.
atualizar_so() {
    apt-get update
    apt-get upgrade
    apt-get dist-upgrade
}

instalar_especificos() {
    # PLACA DE VIDEO NVIDIA GEFORCE GT740M
    #https://tecadmin.net/install-latest-nvidia-drivers-ubuntu/
    add-apt-repository ppa:graphics-drivers/ppa
    apt-get update
    apt-get install nvidia-390
    #reboot
    #lsmod | grep nvidia
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
    apt-get install -y unrar
    # CD/DVD Burner
    apt-get install -y brasero
    # Audacity (edição de som)
    add-apt-repository ppa:ubuntuhandbook1/audacity
    apt-get update
    apt-get install -y audacity
    # 
    # ATOM.io
    cd /tmp
    wget https://github.com/atom/atom/releases/download/v1.26.1/atom-amd64.deb
    apt install atom-amd64.deb
    rm atom-amd64.deb
    # NETBEANS
    wget http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh
    chmod +x netbeans-8.2-linux.sh
    bash netbeans-8.2-linux.sh
    # JETBRAINS
    apt-get install -y fuse
    modprobe fuse
    groupadd fuse
    user="$(whoami)"
    usermod -a -G fuse $user
    wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.8.3678.tar.gz
    tar -xvf jetbrains-toolbox-1.8.3678.tar.gz
    cd jetbrains-toolbox-1.8.3678
    ./jetbrains-toolbox
}

instalar_java() {
    # JAVA 9
    # MAIS INFORMAÇÕES EM: http://www.webupd8.org/2015/02/install-oracle-java-9-in-ubuntu-linux.html
    #add-apt-repository ppa:webupd8team/java
    #apt-get update
    #apt-get install -y oracle-java9-installer

    # JAVA 10
    # MAIS INFORMAÇÔES EM: https://www.linuxuprising.com/2018/04/install-oracle-java-10-in-ubuntu-or.html
    add-apt-repository ppa:linuxuprising/java
    apt-get update
    apt-get install -y oracle-java10-installer
}

instalar_postgresql() {
    # REPOSITÓRIO OFICIAL DO POSTGRESQL
    # MAIS INFORMAÇÕES EM: https://www.postgresql.org/download/linux/debian/
    echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update

    # NA ORDEM: Servidor, modulos adicionais, bibliotecas e binarios cliente, desenvolvimento frontend, desenvolvimento backend, ferramenta administrativa
    apt-get install -y postgresql-10 postgresql-contrib-10 postgresql-client-10 libpq-dev postgresql-server-dev-10

    # ALTERACAO DA SENHA PADRAO
    su postgres
    psql -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';"
    exit

    # Ferramentas de apoio
    apt-get install -y pgadmin4
}

instalar_sqlite3() {
    apt-get install -y sqlite3
}

instalar_php() {
    # instala apache2 e php5
    apt-get install -y apache2 php7.2 libapache2-mod-php7.2
    # instala extenção SQLite para php5
    apt-get install -y php7.2-sqlite3
    # instala extenção PostgreSQL para php5
    apt-get install -y php7.2-pgsql
    # instala extenção GD (biblioteca gráfica) para php5
    apt-get install -y php7.2-gd
    # instala extenção CURL
    apt-get install -y php7.2-curl
    # instala extenção IMAP
    apt-get install -y libc-client-dev php7.2-imap
    phpenmod imap
    # instala extenção INTL (internationalization)
    apt-get install -y php7.2-intl
    # extenção SOAP, JSON e XML
    apt-get install -y php7.2-xml php7.2-soap php7.2-json php7.2-xmlrpc
    # extenção zip
    apt-get install -y php7.2-zip
    # extenção mbstring
    apt-get install -y php7.2-mbstring
    # extenção mcrypt
    apt-get install -y php7.2-mcrypt
    # extenção apcu para cache
    apt-get install -y php7.2-apcu
    # extenção MySQL/MariaDB
    apt-get install -y php7.2-mysql
}

instalar_virtualbox() {
    echo "deb http://download.virtualbox.org/virtualbox/debian bionic contrib" | tee /etc/apt/sources.list.d/virtualbox.list
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

instalar_latex() {
    apt-get install -y texlive texlive-lang-portuguese texlive-lang-english texlive-fonts-recommended texlive-extra-utils texlive-generic-extra texlive-plain-extra texlive-publishers texlive-latex-recommended texlive-science texlive-bibtex-extra texlive-font-utils texlive-fonts-extra texlive-fonts-extra-links texlive-fonts-recommended texlive-latex-extra texlive-pictures
    #EDITORES
    apt-get install -y texmaker
    #apt-get install -y texstudio
}

instalar_ruby() {
    sudo apt-get install -y curl gnupg libmagickcore-dev libmagickwand-dev
    sudo apt-get install -y ruby ruby-dev rubygems libruby ruby-full
    sudo apt-get install -y nodejs
    sudo gem install rails
    sudo gem install jekyll
    sudo gem install bundler
}

# :^)
instalar_shhhhh() {
    sudo apt-get install -y libmupen64plus-dev libmupen64plus2 libretro-mupen64plus mupen64plus-audio-all mupen64plus-audio-sdl mupen64plus-data mupen64plus-input-all mupen64plus-input-sdl mupen64plus-qt mupen64plus-rsp-all mupen64plus-rsp-hle mupen64plus-rsp-z64 mupen64plus-ui-console mupen64plus-video-all mupen64plus-video-arachnoid mupen64plus-video-glide64 mupen64plus-video-glide64mk2 mupen64plus-video-rice mupen64plus-video-z64

}

exibir_avisos_encerramento() {
    echo "1. Configure o UserDir Apache, referencias:"
    echo "http://www.techytalk.info/enable-userdir-apache-module-ubuntu-debian-based-linux-distributions/"
    echo "http://ubuntuserverguide.com/2012/10/how-to-enable-and-configure-apache2-userdir-module-in-ubuntu-server-12-04.html"
    echo "2. Crie uma chave SSH"
    echo "ssh-keygen -t rsa -b 4096 -C \"your_email@example.com\""
    echo "3. Complementares"
    echo "3.1. JetBrains"
    echo "3.2. NetBeans"
}

# INICIAR PROCESSO DE INSTALAÇÃO
instalar
