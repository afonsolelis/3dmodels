# pokemon-game

Plataforma completa pra jogar Pokémon TCG: o campo de um jogador em placas
encaixáveis, com as zonas em relevo, mais os contêineres que viram deckbox e
porta-dados e um case que guarda tudo e vira bandeja de rolar dados.

## Medidas

| | |
|---|---|
| Campo montado | 589.2 x 206 mm (4mm de espessura; 10 nas molduras) |
| Playmat de torneio, pra comparar | 610 x 356 mm (24"x14") — 45% mais área |
| Carta com sleeve (medida com régua) | 68 x 93 mm |
| Deck de 60 com sleeve | 93 x 68 x 45 mm |
| Cavidade de carta | 70 x 95 mm, 1mm de profundidade |
| Case fechado | 162.8 x 117.8 x 118.4 mm (interior 158 x 113 x 106) |
| Cestinha do deck / cesta do descarte | 72.4 x 97.4 x 50 / x 30 mm |

## As zonas

Jogador na borda de baixo, oponente em cima:

- **Banco** — 5 cavidades na fileira da frente do jogador
- **Ativo** — cavidade centralizada acima do banco
- **Prêmios** — 6 em cascata (2 colunas x 3), à esquerda. A regra exige que
  fiquem do lado oposto ao deck/descarte
- **Deck** — moldura de 6mm no canto superior direito, recebe a cestinha
- **Descarte** — moldura igual logo abaixo, recebe a cesta de descarte
- **Lost Zone** — cavidade na área alta à esquerda
- **Estádio** — cavidade encostada na borda que dá pro oponente

**Prêmios em cascata**: as cartas encavalam feito telha, que é o que deixa os
6 prêmios caberem em 206mm de profundidade em vez de 285. Coloque-os **de
cima pra baixo** (a mais distante primeiro): cada carta cai no seu bolso e
cobre a de trás. Pra tirar, comece pela mais perto de você.

## Contêineres e case

- **Cestinha do deck** — cai na moldura do canto superior direito e segura o
  deck em pé. Vazada em colmeia, com recorte em U dos dois lados descendo até
  o chão, pra pinçar até a última carta. Fora do jogo, é o deckbox.
- **Cesta do descarte** — mesmo footprint, mais baixa, com escalopes fundos
  nos quatro lados: dá pra enfiar o dedo e pegar a pilha inteira. Fora do
  jogo, é a caixa de dados e contadores.
- **Case** — guarda as 8 placas empilhadas e, em cima delas, os dois
  contêineres lado a lado. Vazio, o interior (158 x 113 x 106) é a bandeja de
  rolar dado, com fundo em colmeia que amortece o quique.
- **Tampa** — fecha por **12 ímãs 4x2mm** (6 pares). Como a parede tem 2.4mm
  e não comporta um furo de 4mm, cada posição tem um ressalto interno que
  engrossa a parede pra 7mm, entrando por rampa de 45° pra não precisar de
  suporte. Monte os 6 ímãs do case com o mesmo polo pra cima e os 6 da tampa
  com o oposto.

## Montagem

As placas descem no lugar — nada de deslizar. Ordem: **esquerda → direita,
baixo → cima** (t1r1, t2r1, t3r1, t4r1, depois t1r2 … t4r2). Cada costura
tem 3 linguetas de 20mm que entram em bolsos na placa vizinha; elas seguram
o alinhamento e travam o deslize. Pra desmontar, levante na ordem inversa.

As placas se apoiam na mesa pelo próprio corpo, não pelas linguetas — a
lingueta tem 1.2mm e o bolso 1.8mm de propósito, pra folga sobrar mesmo
depois da barriga da ponte e da pata de elefante da primeira camada.

## Impressão

Cada placa é um job (não cabem duas na cama da A1 mini). Tudo em `3mf/`,
pronto pra abrir no Bambu Studio. Nenhuma peça precisa de suporte.

| Job | Peça | Footprint |
|---|---|---|
| `pokemon-game-t1r1.3mf` | prêmios (baixo) | 151.0 x 108.0 x 4.0 |
| `pokemon-game-t2r1.3mf` | banco 1-2 | 151.0 x 108.0 x 4.0 |
| `pokemon-game-t3r1.3mf` | banco 3-4 | 151.0 x 108.0 x 4.0 |
| `pokemon-game-t4r1.3mf` | banco 5 + moldura do descarte | 151.2 x 108.0 x 10.0 |
| `pokemon-game-t1r2.3mf` | prêmios (cima) | 151.0 x 103.0 x 4.0 |
| `pokemon-game-t2r2.3mf` | lost zone | 151.0 x 103.0 x 4.0 |
| `pokemon-game-t3r2.3mf` | ativo + estádio | 151.0 x 103.0 x 4.0 |
| `pokemon-game-t4r2.3mf` | moldura do deck | 151.2 x 103.0 x 10.0 |
| `pokemon-game-containers.3mf` | cestinha + cesta, lado a lado | 150.8 x 97.4 x 50.0 |
| `pokemon-game-case.3mf` | case, boca pra cima | 162.8 x 117.8 x 108.4 |
| `pokemon-game-lid.3mf` | tampa, de cabeça pra baixo | 162.8 x 117.8 x 10.0 |

São 11 jobs no total — o case sozinho passa de 11h. Duas observações que
valem a pena:

- **Suporte DESLIGADO em tudo.** Nenhuma peça precisa, e nas placas o suporte
  automático entope os bolsos das linguetas (1.8mm de altura, impossível de
  limpar) e mata a junta.
- **As placas são finas e largas**: capriche na aderência da primeira camada
  (cama limpa, brim se a sua costuma soltar canto).
- **A tampa imprime de cabeça pra baixo** (cara de cima na cama). Com a saia
  pra baixo o painel inteiro ficaria no ar. O 3MF já sai na posição certa.
