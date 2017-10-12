# Instalação e configuração de um servidor de DESENVOLVIMENTO Debian

Este servidor é instalado em um netbook Acer Aspire One 722, CPU AMD Dual-Core C-50 1.0 GHz, 4 GB DDR3, HDD 500 GB.

ATENÇÃO: use por sua conta e risco.

## 1- Preparativos
- [ ] Baixar [Debian 9 Stretch][DEBIAN] ou mais atual.
- [ ] Montar em um flash drive para instalação.
    - [ ] Se estiver no Windows, use o [Rufus][RUFUS] para criar o drive inicializável.
- [ ] Baixar firmware [Broadcom][BROADCOM] para rede sem fio e colocar na raiz de um flash drive.
- [ ] Se for uma instalação nova, faça backup.
- [ ] Se for uma reinstalação, formate as partições e mantenha a /home.

[BROADCOM]: https://packages.debian.org/jessie/firmware-brcm80211
[DEBIAN]: https://www.debian.org/releases/stable/
[RUFUS]: https://rufus.akeo.ie/

## 2- Instalação do SO
- [ ] Instalar [Debian 9/AMD64][DEBIAN9].
- [ ] Particionar HD:
    - [ ] 60 GB para a raiz ( / ).
    - [ ] 4 GB para swap.
    - [ ] 436 GB para /home.
- [ ] Não instalar interface gráfica. :exclamation:
- [ ] Instalar GRUB.

[DEBIAN9]: https://www.debian.org/distrib/

## 3- Script de instalação
- [ ] Copie o script [instalar.debian.server.sh][SCRIPT] para o diretório do usuário.
- [ ] Altere a permissão do script (chmod +x ).
- [ ] Execute o script (# /bin/bash instalar.debian.server.sh)

[SCRIPT]: https://github.com/guilhermedelemos/de-novo-nao/blob/master/Server-Debian/instalar.debian.server.sh

### 3.1- PostgreSQL
- [ ] Alterar senha do super-usuário.
- [ ] Alterações no postgresql.conf
    - [ ] listen_address = '*'
- [ ] Alterações no pg_hba.conf
    - [ ] host all all w.x.y.z/16/24/32 md5

### 3.2- FTP
- [ ] Habilitar escrita em /etc/vsftpd.conf

### 3.3- Apache2 + PHP7
- [ ] Habilitar mod UserDir.

### 3.4- Chave SSH
- [ ] Crie uma [chave SSH][SSHKEY].

[SSHKEY]: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

## 4- Conclusão
- [ ] Restaurar backup (se necessário).
- [ ] Configurar chave SSH
