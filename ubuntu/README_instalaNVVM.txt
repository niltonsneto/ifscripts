### Instruções para uso:
1. **Salve o script**: Salve o código em um arquivo, por exemplo, `install_nvm.sh`.
Para salvar o script de instalação do NVM, uma boa prática é criar uma pasta específica dentro de `/usr/local/bin`, que é um diretório padrão para scripts e executáveis que são acessíveis a todos os usuários. Você pode nomear a pasta como `nvm-install`.

### Sugestão de Pasta:

sudo mkdir /usr/local/bin/nvm-install


### Salvar o Script:
Depois de criar a pasta, salve o script com um nome apropriado, como `install_nvm.sh`:
**Dê permissão de execução**: Execute:

   chmod +x install_nvm.sh
sudo nano /usr/local/bin/nvm-install/install_nvm.sh

Cole o conteúdo do script e salve.

### Definir Permissões:
Para que todos os usuários possam executar o script, defina as permissões adequadas:

sudo chmod 755 /usr/local/bin/nvm-install/install_nvm.sh

2. Adicione a Execução do Script no .bashrc ou .profile
Agora, você pode criar um link simbólico no arquivo .bashrc ou .profile que será executado quando o usuário fizer login.

Para isso, você pode adicionar a seguinte linha no arquivo .bashrc ou .profile:
echo "/usr/local/bin/nvm-install/install_nvm.sh" >> /etc/skel/.bashrc

### Executar o Script na mão se for o caso:
Após definir as permissões, você pode executar o script como superusuário:

sudo /usr/local/bin/nvm-install/install_nvm.sh


Esse script agora busca automaticamente a versão mais atual do NVM, garantindo que a instalação esteja sempre atualizada.
