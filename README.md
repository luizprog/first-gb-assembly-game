# First GB Assembly Game 🎮

Um pequeno jogo desenvolvido em Assembly para o Game Boy, com o objetivo de explorar o funcionamento do hardware clássico da Nintendo e aprender sobre desenvolvimento de baixo nível.

## 📦 Sobre o Projeto

Este projeto é um protótipo educativo e experimental, construído usando o conjunto de ferramentas RGBDS. O código fonte está estruturado para compilar uma ROM `.gb` funcional que pode ser testada em emuladores ou hardware real.

---

## 🛠️ Requisitos

- [RGBDS](https://github.com/gbdev/rgbds) – Montador/linkador para Game Boy
- Emulador recomendado: [BGB](https://bgb.bircd.org) (Windows) ou [SameBoy](https://github.com/LIJI32/SameBoy) (cross-platform)
- Git (para clonar o projeto)
- Opcional: Make (Linux/macOS) ou um terminal bash (Windows com Git Bash ou WSL)

---

## 💻 Como compilar

### 🔹 Linux

```bash
# Instale o RGBDS (via apt se disponível)
sudo apt update
sudo apt install rgbds

# Clone o repositório
git clone https://github.com/luizprog/first-gb-assembly-game.git
cd first-gb-assembly-game

# Compile usando o Makefile
make

O arquivo final será gerado em build/first.gb.

🔹 macOS
# Instale o Homebrew (caso ainda não tenha)
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instale o RGBDS
brew install rgbds

# Clone o repositório
git clone https://github.com/luizprog/first-gb-assembly-game.git
cd first-gb-assembly-game

# Compile com o Makefile
make

🔹 Windows
Opção 1: Usando Git Bash + RGBDS (recomendado)

Instale o Git Bash

Instale o RGBDS para Windows

Adicione o diretório dos executáveis ao PATH

Abra o Git Bash e execute:

git clone https://github.com/luizprog/first-gb-assembly-game.git
cd first-gb-assembly-game
make

Opção 2: Usando arquivo .bat incluso (Windows)

Dê um duplo clique no arquivo build.bat na raiz do projeto

A ROM será gerada na pasta build/ como first.gb

🎮 Como jogar
Execute o arquivo first.gb em um emulador Game Boy como:

BGB (Windows)

SameBoy (cross-platform)

Controles básicos:

Setas: movimentação

Start: iniciar jogo

A e B: ações contextuais (ex: pular, atacar)

Como o projeto está em estágio inicial, os controles e gameplay podem ser limitados.


🧠 Aprendizado & Referências
RGBDS Docs

GB Assembly Tutorial

Awesome Game Boy Development

Exemplos de jogos em Assembly:

https://github.com/tbsp/simple-gb-asm-examples

