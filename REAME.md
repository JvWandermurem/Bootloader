# Projeto: Mini Shell Interativo em Assembly (Bootloader)

<iframe width="560" height="415" src="https://www.youtube.com/embed/POJQmOEe638?si=9FGbpr8BdB5mTuYR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Descrição

Este é um projeto que consiste em um bootloader simples, de 512 bytes, escrito com base no código do professor em Assembly para a arquitetura x86 em Modo Real 16-bit. 

O programa é carregado pela BIOS e executa um pequeno "shell" interativo que permite ao usuário escolher entre diferentes ações, manipulando diretamente o hardware através de interrupções da BIOS.

O objetivo principal do projeto foi aprofundar os conhecimentos em programação de baixo nível, gerenciamento de memória, fluxo de controle em Assembly e o processo de inicialização de um computador.

## Funcionalidades

O bootloader apresenta um menu com as seguintes opções:
* **1. Mostrar mensagem :** Exibe uma string de texto na tela.
* **2. Mudar fundo para (Azul):** Altera o atributo de cor de fundo de toda a tela.
* **3. Reiniciar o shell:** Executa um reinício do sistema via software.
* Gerencia entradas inválidas, solicitando uma nova opção ao usuário.


### Ambiente e Ferramentas

* **Editor de Código:** Visual Studio Code com a extensão "x86 and x86_64 Assembly" para syntax highlighting.

* **Montador (Assembler):** NASM (Netwide Assembler), por sua sintaxe clara e popularidade.


* **Emulador:** QEMU (qemu-system-x86_64), para criar uma máquina virtual e testar o bootloader de forma segura e rápida.

### Estrutura do Código

O código fonte (`bootloader.s`) foi organizado em seções lógicas para facilitar a leitura e manutenção:

1.  **Bloco de Início (`start`):** Responsável pela configuração inicial que roda apenas uma vez (segmentos, pilha e limpeza da tela).

2.  **Funções Reutilizáveis:** Pequenos blocos de código para tarefas repetitivas, como `print_string`, `clear_screen` e `wait_for_key`.

3.  **Seção de Dados:** Onde todas as strings e mensagens são declaradas.

4.  **Lógica Principal (`main` e `main_loop`):** Onde o menu é desenhado e o programa espera pela interação do usuário.

5.  **Manipuladores de Ações (`handle_opX`):** Rotinas específicas para cada opção do menu.

6.  **Assinatura do Bootloader:** O preenchimento final e a "palavra mágica" `0xAA55` para que a BIOS reconheça o setor como bootável.


## Como Rodar o Projeto

Para compilar e executar este bootloader, você precisará ter o NASM e o QEMU instalados e acessíveis no seu terminal.

### Pré-requisitos
* [NASM (The Netwide Assembler)](https://www.nasm.us/)
* [QEMU](https://www.qemu.org/)

### Passos

1.  Clone ou faça o download deste projeto e navegue até a pasta no seu terminal.


2.  **Compile o código Assembly** para gerar o arquivo binário do bootloader. Execute o seguinte comando:
    ```bash
    nasm -f bin bootloader.s -o boot.bin
    ```
3.  **Execute o bootloader** em uma máquina virtual com o QEMU:
    ```bash
    qemu-system-x86_64 -drive format=raw,file=boot.bin
    ```
4.  Uma janela do QEMU deverá aparecer, iniciando diretamente no menu do "Mini Shell". Interaja com o programa usando as teclas 1, 2 e 3.
