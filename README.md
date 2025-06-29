# First GB Assembly Game 🎮

Este é um protótipo de jogo para o Game Boy clássico, escrito em Assembly (RGBDS). Um projeto inicial para aprender sobre desenvolvimento para o hardware original.

## ⚙️ Tecnologias & Ferramentas

- **Linguagem**: Assembly (GBZ80), usando RGBDS  
- **Build scripts**: Makefile / Batch para Windows  
- **Emulador recomendado**: [BGB](https://bgb.bircd.org) (ou outro compatível)

## 🚀 Como compilar e rodar

1. **Instale o RGBDS** no seu sistema:
   ```bash
   # Exemplo para sistemas Debian/Ubuntu
   sudo apt install rgbds

2. Clone este repositorios:
    ```bash
    git clone https://github.com/luizprog/first-gb-assembly-game.git
    cd first-gb-assembly-game

3. Compile e link utilizando o Makefile (ou execute o script corresodente):
    ```bash
    make

4. Isso gerará um arquivo .gb (ROM Game Boy), que pode ser executado no BGB:
    ```bash
    bgb build/first.gb


