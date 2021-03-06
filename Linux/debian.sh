#!/bin/bash

criar_diretorios() {
    echo "======================================"
    echo "| CRIAÇÃO DA ESTRUTURA DE DIRETÓRIOS |"
    echo "======================================"
    cd ~/
    pwd
    mkdir Projects
    mkdir public_html
    mkdir Tools
}

upgrade_so() {
    echo "=============================="
    echo "| UPGRADE DOS PACOTES/SO     |"
    echo "=============================="
    sudo apt update
    sudo apt upgrade
    sudo apt dist-upgrade
}

instalar_essenciais() {
    echo "=============================="
    echo "| ESSENCIAIS                 |"
    echo "=============================="
    # Editor de texto de linha de comando
    sudo apt install -y vim
    # Transferência de dados usando URLs
    sudo apt install -y curl
    # Gerenciadorer de código-fonte
    sudo apt install -y git
    # Ferramentas de compilação
    sudo apt install -y build-essential
    # Ferramenta de descompressão
    sudo apt install -y zip unzip unrar
    # Cliente de Torrent
    sudo apt install -y transmission
    # CD/DVD Burner
    sudo apt install -y brasero
    # Diff
    sudo apt install -y kdiff3
    # Ajustes no GNOME
    #sudo apt install -y gnome-tweaks
    # Particionamento de disco
    sudo apt install -y gparted
    # htop
    sudo apt install -y htop
}

instalar_sdkman() {
    echo "=============================="
    echo "| SDKMAN                     |"
    echo "=============================="
    curl -s "https://get.sdkman.io" | bash
    source "/home/guilherme/.sdkman/bin/sdkman-init.sh"
    sdk version
}

instalar_linguagens() {
    echo "======================================"
    echo "| LINGUAGENS DE PROGRAMAÇÃO (SDKMAN) |"
    echo "======================================"
    sdk install java 8.0.212-librca
    #sdk install java 11.0.3-librca
    #sdk install java 12.0.1-librca
    sdk install groovy
    sdk install grails
    sdk install gradle
    sdk install maven
    echo "php ruby python :'("
}

instalar_nodejs() {
    echo "======================================"
    echo "| NODE JS                            |"
    echo "======================================"
    echo https://github.com/nvm-sh/nvm#installation-and-update
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    command -v nvm
    nvm install node
    # nvm use node
    # Parcel provides a fast way to create React applications
    #sudo npm i -g parcel-bundler
}

instalar_r() {
    echo "=============================="
    echo "| INSTALAÇÃO R               |"
    echo "=============================="
    sudo apt install -y r-base r-base-dev
}

instalar_latex() {
    echo "=============================="
    echo "| INSTALAÇÃO LATEX            |"
    echo "=============================="
    sudo apt install -y texlive texlive-lang-portuguese texlive-lang-english texlive-fonts-recommended texlive-extra-utils texlive-generic-extra texlive-plain-extra texlive-publishers texlive-latex-recommended texlive-science texlive-bibtex-extra texlive-font-utils texlive-fonts-extra texlive-fonts-extra-links texlive-fonts-recommended texlive-latex-extra texlive-pictures
    #EDITORES
    sudo apt install -y texmaker
    #apt install -y texstudio
}

instalar_php() {
    # TODO update php
    echo "=============================="
    echo "| INSTALAÇÃO Apache+PHP      |"
    echo "=============================="
    # instala apache2 e php7
    sudo apt-get install -y apache2 php libapache2-mod-php
    # instala extenção SQLite para php7
    sudo apt-get install -y php-sqlite3
    # instala extenção PostgreSQL para php7
    sudo apt-get install -y php-pgsql
    # instala extenção GD (biblioteca gráfica) para php7
    sudo apt-get install -y php-gd
    # instala extenção CURL
    sudo apt-get install -y php-curl
    # instala extenção IMAP
    sudo apt-get install -y libc-client-dev php-imap
    sudo phpenmod imap
    # instala extenção INTL (internationalization)
    sudo apt-get install -y php-intl
    # extenção SOAP, JSON e XML
    sudo apt-get install -y php-xml php-soap php-json php-xmlrpc
    # extenção zip
    sudo apt-get install -y php-zip
    # extenção mbstring
    sudo apt-get install -y php-mbstring
    # extenção apcu para cache
    sudo apt-get install -y php-apcu
    # extenção MySQL/MariaDB
    sudo apt-get install -y php-mysql
    # BZip2
    sudo apt-get install -y php-bz2
}

instalar_ruby() {
    # TODO update Ruby
    echo "=============================="
    echo "| INSTALAÇÃO RUBY            |"
    echo "=============================="
    gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    \curl -sSL https://get.rvm.io | bash -s stable

    source /home/guilherme/.rvm/scripts/rvm
    rvm install ruby
    gem install rails
    #rvm gemset create rails522
    #rvm 2.6.1@rails522
    #gem install rails -v 5.2.2
    gem install bundler jekyll
}

instalar_python() {
    # TODO Python
    echo "=============================="
    echo "| INSTALAÇÃO PYTHON          |"
    echo "=============================="
    echo "TODO :/"
}

instalar_audacity() {
    echo "====================================="
    echo "| INSTALAR AUDACITY (editor de som) |"
    echo "====================================="
    sudo apt install -y audacity
}

instalar_mongodb() {
    echo "=============================="
    echo "| INSTALAÇÃO MONGO DB        |"
    echo "=============================="
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    sudo apt update
    sudo apt install -y mongodb-org
}

instalar_intellij() {
    echo "=============================="
    echo "| INSTALAÇÃO INTELLIJ        |"
    echo "=============================="
    cd /tmp
    sudo apt install -y fuse
    sudo modprobe fuse
    sudo groupadd fuse
    user="$(whoami)"
    sudo usermod -a -G fuse $user
    wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.12.4481.tar.gz
    tar -xvf jetbrains-toolbox-1.12.4481.tar.gz
    cd jetbrains-toolbox-1.12.4481
    ./jetbrains-toolbox
}

instalar_obsstudio() {
    echo "=============================="
    echo "| INSTALAÇÃO OBS STUDIO      |"
    echo "=============================="
    echo ""
    sudo apt install -y ffmpeg
    sudo add-apt-repository ppa:obsproject/obs-studio && sudo apt update
    sudo apt install -y obs-studio
}

instalar_youtubedl() {
  echo "=============================="
  echo "| INSTALAÇÃO YOUTUBE DL      |"
  echo "=============================="
  echo http://www.webupd8.org/2017/08/youtube-dl-gui-04-ships-with-new-user.html
  echo https://github.com/MrS0m30n3/youtube-dl-gui
  sudo add-apt-repository ppa:nilarimogard/webupd8
  sudo apt install -y youtube-dlg
}

instalar_anoise() {
    echo "=============================="
    echo "| INSTALAÇÃO ANOISE          |"
    echo "=============================="
    echo https://anoise.tuxfamily.org
    sudo add-apt-repository ppa:costales/anoise
    sudo apt install -y anoise gir1.2-webkit-3.0
    sudo apt install -y anoise-community-extension1 anoise-community-extension2 anoise-community-extension3 anoise-community-extension4
}

instalar_gnucash() {
    echo "=============================="
    echo "| INSTALAÇÃO GNUCASH         |"
    echo "=============================="
    sudo apt install -y gnupg2 dirmngr
    sudo apt install -y gnucash
}

instalar_virtualbox() {
    echo "=============================="
    echo "| INSTALAÇÃO VIRTUAL BOX     |"
    echo "=============================="
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

instalar_android() {
    # TODO Android/Emuladores
    echo "=============================="
    echo "| INSTALAÇÃO ANDROID         |"
    echo "=============================="
    echo "TODO :/"
}

instalar_sqlite() {
    echo "=============================="
    echo "| INSTALAÇÃO SQLITE3         |"
    echo "=============================="
    sudo apt install -y sqlite3
}

instalar_postgresql() {
    echo "=============================="
    echo "| INSTALAÇÃO POSTGRESQL      |"
    echo "=============================="
    # REPOSITÓRIO OFICIAL DO POSTGRESQL
    # MAIS INFORMAÇÕES EM: https://www.postgresql.org/download/linux/debian/
    sudo apt install -y libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev
    sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt update

    # NA ORDEM: Servidor, modulos adicionais, bibliotecas e binarios cliente, desenvolvimento frontend, desenvolvimento backend, ferramenta administrativa
    sudo apt install -y postgresql-10 postgresql-contrib-10 postgresql-client-10 libpq-dev postgresql-server-dev-10

    # TODO Alterar senha padrão do POSTGRESQL
    # ALTERACAO DA SENHA PADRAO
    sudo su postgres
    psql -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';"
    exit

    # Ferramentas de apoio
    sudo apt install -y pgadmin4
}

instalar_vscode() {
    echo "=============================="
    echo "| INSTALAÇÃO VS Code         |"
    echo "=============================="
    echo "Pendente"
    echo "Extenções"
    code --install-extension davidanson.vscode-markdownlint
    code --install-extension yzhang.markdown-all-in-one
}

instalar_netbeans() {
    echo "=============================="
    echo "| INSTALAÇÃO NETBEANS        |"
    echo "=============================="
    cd ~/Tools
    wget http://ftp.unicamp.br/pub/apache/incubator/netbeans/incubating-netbeans-java/incubating-9.0/incubating-netbeans-java-9.0-bin.zip
    unzip incubating-netbeans-java-9.0-bin.zip
    rm incubating-netbeans-java-9.0-bin.zip
}

instalar_intellij() {
    echo "=============================="
    echo "| INSTALAÇÃO INTELLIJ        |"
    echo "=============================="
    cd /tmp
    sudo apt install -y fuse
    sudo modprobe fuse
    sudo groupadd fuse
    user="$(whoami)"
    sudo usermod -a -G fuse $user
    wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.12.4481.tar.gz
    tar -xvf jetbrains-toolbox-1.12.4481.tar.gz
    cd jetbrains-toolbox-1.12.4481
    ./jetbrains-toolbox
}

instalar_nvidia() {
    # TODO Placa de Vídeo
    echo "=============================="
    echo "| INSTALAÇÃO NVIDIA          |"
    echo "=============================="
    echo "TODO :/"
    # PLACA DE VIDEO NVIDIA GEFORCE GT740M
    echo https://tecadmin.net/install-latest-nvidia-drivers-ubuntu/
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt-get update
    sudo apt-get install -y nvidia-390
    lsmod | grep nvidia
    #reboot
}

instalar_heroku() {
    echo "=============================="
    echo "| INSTALAÇÃO HEROKU          |"
    echo "=============================="
    sudo snap install heroku --classic
    heroku login
}

instalar_munin() {
    echo "=============================="
    echo "| INSTALAÇÃO MUNIN           |"
    echo "=============================="
    sudo apt install -y apache2 libcgi-fast-perl libapache2-mod-fcgid
    sudo a2enmod fcgid
    sudo apt install -y munin munin-node munin-plugins-extra
    echo "REALIZE A CONFIGURAÇÃO MANUAL EM /etc/munin/munin.conf"
}

instalar_onedrive() {
    echo "=============================="
    echo "| INSTALAÇÃO ONEDRIVE        |"
    echo "=============================="
    cd ~/Tools
    git clone https://github.com/skilion/onedrive.git
    cd onedrive
    make
    sudo make install
    onedrive
    systemctl --user enable onedrive
    systemctl --user start onedrive
    echo "Instalação do OneDrive concluída"
    echo "Para mais informações de configuração, acesse:"
    echo "https://github.com/skilion/onedrive"
}

instalar_ferramentas_postgresql() {
    echo "====================================="
    echo "| INSTALAÇÃO Ferramentas PostgreSQL |"
    echo "====================================="
    echo "Pré-Requisito do PgModeler: QT"
    echo "https://wiki.qt.io/Install_Qt_5_on_Ubuntu"
    sudo apt install -y libfontconfig1 mesa-common-dev libglu1-mesa-dev
    cd /tmp
    wget http://download.qt.io/official_releases/qt/5.9/5.9.0/qt-opensource-linux-x64-5.9.0.run
    chmod +x qt-opensource-linux-x64-5.9.0.run
    ./qt-opensource-linux-x64-5.9.0.run

    echo "PgModeler"
    echo "https://pgmodeler.io/support/installation"
    cd ~/Tools
    git clone git@github.com:pgmodeler/pgmodeler.git
    cd pgmodeler
    ~/.Qt5.9.0/5.9/gcc_64/bin/qmake -r PREFIX=~/Tools/pgmodeler BINDIR=~/Tools/pgmodeler PRIVATEBINDIR=~/Tools/pgmodeler PRIVATELIBDIR=~/Tools/pgmodeler/lib pgmodeler.pro
    make
    make install
}

gerar_SSHKey() {
    echo "=============================="
    echo "| GERAÇÃO DA CHAVE SSH       |"
    echo "=============================="
    read -p "E-mail :" emailSSH
    ssh-keygen -t rsa -b 4096 -C $emailSSH
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
}

gerar_GPGKey() {
    echo "=============================="
    echo "| GERAÇÃO DA CHAVE GPG       |"
    echo "=============================="
    gpg --full-generate-key
    gpg --list-secret-keys --keyid-format LONG
    read -p "Qual o ID da chave GPG? " GPG_ID
    GPG_KEY=`gpg --armor --export $GPG_ID`
}

configurar_git() {
    echo "=============================="
    echo "| CONFIGURAÇÃO DO GIT        |"
    echo "=============================="
    read -p "GIT user.name: " GIT_NAME
    read -p "GIT user.email: " GIT_EMAIL
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_NAME"
    git config --global diff.tool kdiff3
    git config --global merge.tool kdiff3
}

configurar_github() {
    echo "=============================="
    echo "| CONFIGURAÇÃO DO GITHUB     |"
    echo "=============================="
    echo "# Autenticação"
    read -p "Usuário: " GITHUB_USER
    read -sp "Personal Access Token: " GITHUB_PAT
    echo

    GITHUB_HEADER_AUTH="Authorization: token $GITHUB_PAT"
    GITHUB_HEADER_CONTENT="Content-Type: application/json"
    GITHUB_URL_USER="https://api.github.com/users/$GITHUB_USER"
    GITHUB_URL_SSH_KEYS="https://api.github.com/user/keys"
    GITHUB_URL_GPG_KEYS="https://api.github.com/user/gpg_keys"

    echo "# Dados do usuário"
    curl -H "$GITHUB_HEADER_AUTH" $GITHUB_URL_USER
    echo "# SSH Keys"
    #curl -H "$GITHUB_HEADER_AUTH" $GITHUB_URL_SSH_KEYS
    echo "# GPG Keys"
    #curl -H "$GITHUB_HEADER_AUTH" $GITHUB_URL_GPG_KEYS

    read -p "Cadastrar chave SSH/GPG? (s/n)" GITHUB_CAD
    if [ $GITHUB_CAD == "s" ]
    then
        echo "# Cadastrar SSH Key"
        SSH_PUBLIC_KEY=`cat ~/.ssh/id_rsa.pub`
        GITHUB_SSH_PAYLOAD='{"title": "'$GITHUB_USER'@ubuntu", "key": "'$SSH_PUBLIC_KEY'"}'
        curl -d "$GITHUB_SSH_PAYLOAD" -H "$GITHUB_HEADER_AUTH" -H "$GITHUB_HEADER_CONTENT" -X POST $GITHUB_URL_SSH_KEYS

        echo "# Cadastrar GPG Key"
        gpg --armor --export $GPG_ID > /tmp/FRIDAY_GPG
        GPG_KEY=`sed '{:q;N;s/\n/\\\n/g;t q}' /tmp/FRIDAY_GPG`
        rm /tmp/FRIDAY_GPG
        GITHUB_GPG_PAYLOAD='{"armored_public_key": "'$GPG_KEY'"}'
        curl -d "$GITHUB_GPG_PAYLOAD" -H "$GITHUB_HEADER_AUTH" -H "$GITHUB_HEADER_CONTENT" -X POST $GITHUB_URL_GPG_KEYS

        git config --global user.signingkey $GPG_ID
        test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
        echo 'export GPG_TTY=$(tty)' >> ~/.profile
        git config --global commit.gpgsign true
    fi
}

instalar() {
    echo "=============================="
    echo "| INÍCIO DA INSTALAÇÃO       |"
    echo "=============================="
    criar_diretorios
    upgrade_so
    instalar_essenciais
    instalar_sdkman
    instalar_linguagens
    instalar_nodejs
    instalar_r
    instalar_latex
    instalar_php
    instalar_sqlite
    gerar_SSHKey
    gerar_GPGKey
    configurar_git
    echo "=============================="
    echo "| FIM DA INSTALAÇÃO          |"
    echo "=============================="
}

instalar
