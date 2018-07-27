#!/bin/sh

exibir_avisos_inicializacao() {
    echo "ATENCAO, ESTE SCRIPT E COMPATIVEL APENAS COM DISTRIBUICAO UBUNTU BIONIC."
    echo "TESTADO E ATUALIZADO EM 26/06/2018."
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
    instalar_latex
    instalar_ruby
    instalar_shhhhh
    instalar_R
    instalar_asp_dot_net_c_sharp
    exibir_avisos_encerramento
}

# Atualiza o Sistema Operacional para a versão mais recente possível.
atualizar_so() {
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade
}

instalar_especificos() {
    # PLACA DE VIDEO NVIDIA GEFORCE GT740M
    #https://tecadmin.net/install-latest-nvidia-drivers-ubuntu/
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt-get update
    sudo apt-get install -y nvidia-390
    #reboot
    #lsmod | grep nvidia
}

instalar_essenciais() {
    # Ferramentas de compilação
    sudo apt-get install -y build-essential
    # Editor de texto de linha de comando
    sudo apt-get install -y vim
    # Ferramenta de descompressão
    sudo apt-get install -y unzip
    # Gerenciador de código-fonte
    sudo apt-get install -y git git-core
    # Dependências do GnuCash
    sudo apt-get install -y gnupg2 dirmngr
    # Cliente de Torrent
    sudo apt-get install -y transmission
    # rar
    sudo apt-get install -y unrar
    # CD/DVD Burner
    sudo apt-get install -y brasero
    # Audacity (edição de som)
    sudo add-apt-repository ppa:ubuntuhandbook1/audacity
    sudo apt-get update
    sudo apt-get install -y audacity
    # ATOM.io
    cd /tmp
    wget https://github.com/atom/atom/releases/download/v1.26.1/atom-amd64.deb
    sudo apt install atom-amd64.deb
    rm atom-amd64.deb
    # NETBEANS
    cd /tmp
    wget http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh
    sudo chmod +x netbeans-8.2-linux.sh
    sudo bash netbeans-8.2-linux.sh
    # JETBRAINS
    cd /tmp
    sudo apt-get install -y fuse
    sudo modprobe fuse
    sudo groupadd fuse
    user="$(whoami)"
    sudo usermod -a -G fuse $user
    wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.8.3678.tar.gz
    tar -xvf jetbrains-toolbox-1.8.3678.tar.gz
    cd jetbrains-toolbox-1.8.3678
    ./jetbrains-toolbox
    # Screen Recorder
    sudo apt-get install -y kazam
    # OBS Project
    sudo apt-get install -y ffmpeg
    sudo add-apt-repository ppa:obsproject/obs-studio && sudo apt-get update
    sudo apt-get install -y obs-studio
    # YouTube
    # http://www.webupd8.org/2017/08/youtube-dl-gui-04-ships-with-new-user.html
    sudo add-apt-repository ppa:nilarimogard/webupd8
    sudo apt install youtube-dlg
    # Ambient Noise
    sudo add-apt-repository ppa:costales/anoise
    sudo apt-get install anoise gir1.2-webkit-3.0
    sudo apt install anoise-community-extension1 anoise-community-extension2 anoise-community-extension3 anoise-community-extension4
    # 
}

instalar_java() {
    # JAVA 8 (pendente)

    # JAVA 9
    # MAIS INFORMAÇÕES EM: http://www.webupd8.org/2015/02/install-oracle-java-9-in-ubuntu-linux.html
    #add-apt-repository ppa:webupd8team/java
    #apt-get update
    #apt-get install -y oracle-java9-installer

    # JAVA 10
    # MAIS INFORMAÇÔES EM: https://www.linuxuprising.com/2018/04/install-oracle-java-10-in-ubuntu-or.html
    sudo add-apt-repository ppa:linuxuprising/java
    sudo apt-get update
    sudo apt-get install -y oracle-java10-installer

    # Ferramentas
    sudo apt-get install -y ant maven
}

instalar_postgresql() {
    # REPOSITÓRIO OFICIAL DO POSTGRESQL
    # MAIS INFORMAÇÕES EM: https://www.postgresql.org/download/linux/debian/
    sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update

    # NA ORDEM: Servidor, modulos adicionais, bibliotecas e binarios cliente, desenvolvimento frontend, desenvolvimento backend, ferramenta administrativa
    sudo apt-get install -y postgresql-10 postgresql-contrib-10 postgresql-client-10 libpq-dev postgresql-server-dev-10

    # ALTERACAO DA SENHA PADRAO
    su postgres
    psql -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';"
    exit

    # Ferramentas de apoio
    sudo apt-get install -y pgadmin4
}

instalar_sqlite3() {
    sudo apt-get install -y sqlite3
}

instalar_php() {
    # instala apache2 e php5
    sudo apt-get install -y apache2 php7.2 libapache2-mod-php7.2
    # instala extenção SQLite para php5
    sudo apt-get install -y php7.2-sqlite3
    # instala extenção PostgreSQL para php5
    sudo apt-get install -y php7.2-pgsql
    # instala extenção GD (biblioteca gráfica) para php5
    sudo apt-get install -y php7.2-gd
    # instala extenção CURL
    sudo apt-get install -y php7.2-curl
    # instala extenção IMAP
    sudo apt-get install -y libc-client-dev php7.2-imap
    sudo phpenmod imap
    # instala extenção INTL (internationalization)
    sudo apt-get install -y php7.2-intl
    # extenção SOAP, JSON e XML
    sudo apt-get install -y php7.2-xml php7.2-soap php7.2-json php7.2-xmlrpc
    # extenção zip
    sudo apt-get install -y php7.2-zip
    # extenção mbstring
    sudo apt-get install -y php7.2-mbstring
    # extenção mcrypt
    sudo apt-get install -y php7.2-mcrypt
    # extenção apcu para cache
    sudo apt-get install -y php7.2-apcu
    # extenção MySQL/MariaDB
    sudo apt-get install -y php7.2-mysql
    # BZip2
    sudo apt-get install -y php7.2-bz2
}

instalar_virtualbox() {
    sudo echo "deb http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo apt-get update
    # Note: Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade
    sudo apt-get install -y virtualbox-5.2 dkms

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
    sudo apt-get install -y texlive texlive-lang-portuguese texlive-lang-english texlive-fonts-recommended texlive-extra-utils texlive-generic-extra texlive-plain-extra texlive-publishers texlive-latex-recommended texlive-science texlive-bibtex-extra texlive-font-utils texlive-fonts-extra texlive-fonts-extra-links texlive-fonts-recommended texlive-latex-extra texlive-pictures
    #EDITORES
    sudo apt-get install -y texmaker
    #apt-get install -y texstudio
}

instalar_ruby() {
    sudo apt-get install -y curl gnupg libmagickcore-dev libmagickwand-dev
    sudo apt-get install -y ruby ruby-dev rubygems libruby ruby-full
    sudo apt-get install -y nodejs
    sudo gem install rails
    sudo gem install bundler
    sudo gem install jekyll
}

# :^)
instalar_shhhhh() {
    #n64
    sudo apt-get install -y libmupen64plus-dev libmupen64plus2 libretro-mupen64plus mupen64plus-audio-all mupen64plus-audio-sdl mupen64plus-data mupen64plus-input-all mupen64plus-input-sdl mupen64plus-qt mupen64plus-rsp-all mupen64plus-rsp-hle mupen64plus-rsp-z64 mupen64plus-ui-console mupen64plus-video-all mupen64plus-video-arachnoid mupen64plus-video-glide64 mupen64plus-video-glide64mk2 mupen64plus-video-rice mupen64plus-video-z64
}

instalar_R() {
    sudo apt-get install -y r-base r-base-dev
}

# :/
instalar_asp_dot_net_c_sharp() {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
    sudo apt-get update
    # Mono Complete
    sudo apt-get install -y mono-complete
    # Debug Symbols
    sudo apt-get install -y mono-dbg
    # PCL Compilation support
    sudo apt-get install -y referenceassemblies-pcl
    # SSL certificates for HTTPS
    sudo apt-get install -y ca-certificates-mono
    # Running .Net Applications
    sudo apt-get install -y mono-xsp4
    # Visual Studio Code
    # https://code.visualstudio.com/
}

exibir_avisos_encerramento() {
    echo "1. Configure o UserDir Apache, referencias:"
    echo "http://www.techytalk.info/enable-userdir-apache-module-ubuntu-debian-based-linux-distributions/"
    echo "http://ubuntuserverguide.com/2012/10/how-to-enable-and-configure-apache2-userdir-module-in-ubuntu-server-12-04.html"
    echo "2. Crie uma chave SSH"
    echo "ssh-keygen -t rsa -b 4096 -C \"your_email@example.com\""
}

# INICIAR PROCESSO DE INSTALAÇÃO
instalar
