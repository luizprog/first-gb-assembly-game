SECTION "Header", ROM0[$0100]
    jp Start                ; Pula para o início do programa em "Start"

SECTION "Main", ROM0

Start:
    ; Desativa a tela antes de mexer na VRAM (para evitar glitches)
    ld a, $00
    ldh [rLCDC], a         ; Escreve 0 em LCDC para desligar tela

    ; Carrega os dados do tile do jogador para a VRAM (endereço $8000)
    ld hl, BlockTileData   ; HL aponta para início dos dados do tile
    ld de, $8000           ; DE aponta para o endereço VRAM onde será carregado
    ld bc, BlockTileDataEnd - BlockTileData  ; BC = tamanho dos dados em bytes

LoadTiles:
    ld a, [hl]             ; Lê um byte dos dados do tile
    ld [de], a             ; Escreve o byte na VRAM
    inc hl                 ; Avança para o próximo byte dos dados
    inc de                 ; Avança para o próximo endereço da VRAM
    dec bc                 ; Decrementa o contador de bytes restantes
    ld a, b
    or c                   ; Testa se BC é zero (se terminou de copiar)
    jr nz, LoadTiles       ; Se não terminou, continua copiando

    ; Configura o sprite 0 com tile 0 e posição inicial (X=80, Y=72)
    ld a, 72
    ld [$FE00], a          ; Y do sprite 0 (posição vertical)
    ld a, 80
    ld [$FE01], a          ; X do sprite 0 (posição horizontal)
    ld a, 0
    ld [$FE02], a          ; Tile ID usado pelo sprite 0 (tile 0)
    ld a, 0
    ld [$FE03], a          ; Atributos do sprite 0 (sem atributos especiais)   

    ; Ativa a tela e habilita sprites 8x8 (bits 7, 1 e 0 setados)
    ld a, %10000011        ; Binário: 10000011
    ldh [rLCDC], a         ; Liga o LCDC com as configurações acima

MainLoop:
    call ReadInput         ; Lê o estado atual dos botões
    call UpdatePlayer      ; Atualiza posição do jogador baseado nos botões
    jr MainLoop            ; Loop infinito do jogo

;-----------------------------
; Leitura dos botões
;-----------------------------
ReadInput:
    ld a, $20              ; Seleciona o grupo dos botões direcionais (bit 5)
    ldh [rP1], a           ; Escreve no registrador P1 para seleção
    ldh a, [rP1]           ; Lê estado dos botões direcionais
    cpl                    ; Inverte bits (0 = pressionado vira 1)
    and $0F                ; Mantém só os 4 bits inferiores (botões)
    ld b, a                ; Armazena resultado em B temporariamente

    ld a, $10              ; Seleciona o grupo dos botões de ação (bit 4)
    ldh [rP1], a           ; Seleciona grupo de botões de ação
    ldh a, [rP1]           ; Lê estado dos botões de ação
    cpl                    ; Inverte bits para facilitar uso
    and $0F                ; Mantém só os 4 bits inferiores
    swap a                 ; Troca os 4 bits altos com os 4 baixos
    or b                   ; Combina com os bits do grupo direcional
    ld [InputState], a     ; Salva o estado combinado na variável
    ret                    ; Retorna

;-----------------------------
; Atualizar posição do jogador
;-----------------------------
UpdatePlayer:
    ld a, [PlayerY]        ; Carrega posição Y atual
    ld b, a                ; Salva em B para manipulação
    ld a, [PlayerX]        ; Carrega posição X atual
    ld c, a                ; Salva em C para manipulação

    ld a, [InputState]     ; Carrega o estado dos botões

    bit 2, a               ; Testa bit 2 (CIMA)
    jr z, .skipUp          ; Se bit 2 = 0, pula decremento
    dec b                  ; Se bit 2 = 1, move para cima (Y--)
.skipUp:
    bit 3, a               ; Testa bit 3 (BAIXO)
    jr z, .skipDown
    inc b                  ; Move para baixo (Y++)
.skipDown:
    bit 1, a               ; Testa bit 1 (ESQUERDA)
    jr z, .skipLeft
    dec c                  ; Move para esquerda (X--)
.skipLeft:
    bit 0, a               ; Testa bit 0 (DIREITA)
    jr z, .skipRight
    inc c                  ; Move para direita (X++)
.skipRight:

    ; ---------- Limite Vertical (Y) ---------- 
    ld a, b 
    cp 16 ; Limite superior (mínimo visível)
    jr nc, .checkYMax ; Se Y >= 16, continua
    ld a, 16
    ld b, a
.checkYMax:
    ld a, b 
    cp 144 ; Limite inferior (maximo visivel)
    jr c, .checkXMin ; Se Y < 144, beleza
    ld a, 144 ; Se passou do fundo, trava em 144
    ld b, a

    ; ---------- Limite Vertical (X) ---------- 
.checkXMin:
    ld a, c 
    cp 8 ; Limite esquerdo
    jr nc, .checkXMax
    ld a, 8
    ld c, a
.checkXMax:
    ld a, c
    cp 160 ; Limite direito    
    jr c, .savePosition
    ld a, 160
    ld c, a

.savePosition:
    ld a, b
    ld [PlayerY], a
    ld a, c
    ld [PlayerX], a

    ; Atualiza posição no OAM
    ld a, b
    ld [$FE00], a
    ld a, c
    ld [$FE01], a

    ret                    ; Retorna para o loop principal

;-----------------------------
; Dados e Variáveis
;-----------------------------

SECTION "Vars", WRAM0
PlayerX: ds 1              ; Variável para posição X do jogador
PlayerY: ds 1              ; Variável para posição Y do jogador
InputState: ds 1           ; Variável para armazenar estado dos botões

SECTION "Tiles", ROM0
BlockTileData:
INCBIN "block_tile.bin"    ; Dados binários do tile do jogador
BlockTileDataEnd:

;-----------------------------
; Constantes de I/O
;-----------------------------
DEF rLCDC = $FF40           ; Endereço do registrador LCD Control
DEF rP1   = $FF00           ; Endereço do registrador para leitura dos botões
