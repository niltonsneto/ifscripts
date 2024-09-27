### Instruções para uso:
1. **Salve o script**: Salve o código em um arquivo, por exemplo, `install_nvm.sh`.
2. **Dê permissão de execução**: Execute:
   ```bash
   chmod +x install_nvm.sh
   ```
3. **Adicione ao `/etc/profile`**: Para executar automaticamente ao criar novos usuários:
   ```bash
   echo "/path/to/install_nvm.sh" >> /etc/profile
   ```
   Substitua `/path/to/install_nvm.sh` pelo caminho real.

Esse script agora busca automaticamente a versão mais atual do NVM, garantindo que a instalação esteja sempre atualizada.
