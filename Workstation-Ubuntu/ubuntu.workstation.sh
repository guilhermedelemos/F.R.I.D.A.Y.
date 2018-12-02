#!/bin/bash

criar_diretorios() {
    echo "======================================"
    echo "| CRIAÇÃO DA ESTRUTURA DE DIRETÓRIOS |"
    echo "======================================"
    cd ~/
    pwd
    mkdir Projetos
    mkdir public_html
}

instalar_essenciais() {
    echo "=============================="
    echo "| ESSENCIAIS                 |"
    echo "=============================="

    sudo apt update
    sudo apt install -y vim curl

    sudo apt install -y git
    configurar_git
}

instalar_sdkman() {
    echo "=============================="
    echo "| SDKMAN                     |"
    echo "=============================="
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk version
}

instalar_linguagens() {
    echo "======================================"
    echo "| LINGUAGENS DE PROGRAMAÇÃO (SDKMAN) |"
    echo "======================================"
    sdk install java 8.0.192-zulu
    sdk install java 10.0.2-zulu
    sdk default java 8.0.192-zulu
    sdk install groovy
    sdk install gradle
    sdk install grails
    sdk install maven
    # php ruby python :'(
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
    read -p "GIT user.name: " GIT_NAME
    read -p "GIT user.email: " GIT_EMAIL
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_NAME"
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
    fi
}

instalar() {
    echo "=============================="
    echo "| INÍCIO DA INSTALAÇÃO       |"
    echo "=============================="
    #instalar_essenciais
    #instalar_sdkman
    #instalar_linguagens
    #gerar_SSHKey
    #gerar_GPGKey
    #configurar_github
    #criar_diretorios
}

instalar
