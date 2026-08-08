# pokemon-game

Plataforma completa pra jogar Pokémon TCG: o campo de um jogador em placas
encaixáveis, com as zonas em relevo, mais os contêineres que viram deckbox e
porta-dados e um case que guarda tudo e vira bandeja de rolar dados.

## Medidas

| | |
|---|---|
| Campo montado | 590 x 214 mm, 7mm de espessura |
| Playmat de torneio, pra comparar | 610 x 356 mm (24"x14") — 42% mais área |
| Carta com sleeve (medida com régua) | 68 x 93 mm |
| Deck de 60 com sleeve | 93 x 68 x 45 mm |
| Cavidade de carta | 70 x 95 mm, 1mm de profundidade |
| Ímãs | 52 discos de 4x2mm (40 nas placas, 12 no case) |
| Case fechado | 159.2 x 124.6 x 120.4 mm (interior 154.4 x 111 x 114) |
| Cestinha do deck / cesta do descarte | 72.4 x 97.4 x 50 / x 30 mm |

## As zonas

Jogador na borda de baixo, oponente em cima:

- **Banco** — 5 cavidades na fileira da frente do jogador
- **Ativo** — cavidade centralizada acima do banco
- **Prêmios** — 6 em cascata (2 colunas x 3), à esquerda. A regra exige que
  fiquem do lado oposto ao deck/descarte
- **Deck** — rebaixo de 5mm no canto superior direito, recebe a cestinha
- **Descarte** — rebaixo igual logo abaixo, recebe a cesta de descarte
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
- **Case** — as 8 placas ficam **em pé, lado a lado como livros numa
  estante**: você puxa cada uma pela borda de cima por duas janelas no
  rebordo. Ao lado delas, os contêineres viajam **deitados**, de boca virada
  pras placas, que assim os tampam. Vazio, o interior (154.4 x 111 x 114) é a
  bandeja de rolar dado, com fundo em colmeia que amortece o quique.
- **Tampa** — fecha por **12 ímãs 4x2mm** (6 pares) alojados num **flange
  externo** que contorna as duas paredes compridas. O flange existe porque a
  parede de 2.4mm não comporta um furo de 4mm — e ele fica por fora
  justamente pra deixar o interior um prisma limpo, senão as placas em pé
  (152mm) não passariam. Monte os 6 ímãs do case com o mesmo polo pra cima e
  os 6 da tampa com o oposto.

**Onde vão os dados:** num bolso de 72.4 x 21 x 97.4 atrás da cesta de
descarte — ela é mais rasa que a cestinha do deck, e a diferença vira
compartimento. Deitada, a cesta não segura dado (os escalopes viram furos
laterais), então o bolso é fechado pelo chão sólido dela, pela parede de trás
do case e pela lateral da cestinha.

## Montagem

As placas **se plugam por ímã**: encoste uma na outra e elas puxam sozinhas.
São 2 ímãs por costura, nas paredes laterais, 10 costuras — 40 ímãs no total.

**Polaridade (importante):** em toda placa, os ímãs das faces **direita e de
cima** entram com o mesmo polo pra fora — digamos, norte. Os das faces
**esquerda e de baixo**, com o polo oposto. Assim a direita de qualquer placa
sempre atrai a esquerda da vizinha, em qualquer par do grid. Se você inverter
um, aquela costura vai repelir em vez de atrair.

Os furos são **hexagonais de ponta pra cima**: furo redondo numa parede
vertical imprimiria com o teto em balanço, e o hexágono fecha em bico. O ímã
entra press-fit; se ficar frouxo, um pingo de cola resolve.

## Por que 7mm

É o mínimo pra caber um ímã 4x2 deitado na parede lateral: 4,15mm de furo
mais 1,2mm de material de cada lado dá 6,55mm. A placa não é maciça — tem uma
pele de 2,4mm em cima (onde as cavidades são escavadas) e um **miolo de
colmeia aberto por baixo**. A colmeia imprime a partir da mesa e a pele fecha
por cima em ponte curta, então não precisa de suporte e a estrutura fica à
vista quando você vira a placa.

## Ver tudo de uma vez

`pokemon-game-overview.3mf` (na raiz do projeto, fora de `3mf/` porque **não
é um job de impressão**) traz as **12 peças como objetos separados**, numa
grade em que cada célula é uma cama da A1 mini. Abre num arquivo só e você vê
o conjunto inteiro; no Bambu Studio, "Organizar tudo" distribui pelas plates
sozinho. Pra imprimir de verdade, prefira os arquivos de `3mf/`, que já saem
na orientação certa e com as peças agrupadas como devem ser impressas.

Pra regerar depois de mudar alguma peça:

```
python3 ../../.claude/skills/overview/overview.py pokemon-game-overview.3mf \
  stl/pokemon-game-t1r1.stl stl/pokemon-game-t2r1.stl stl/pokemon-game-t3r1.stl \
  stl/pokemon-game-t4r1.stl stl/pokemon-game-t1r2.stl stl/pokemon-game-t2r2.stl \
  stl/pokemon-game-t3r2.stl stl/pokemon-game-t4r2.stl \
  stl/pokemon-game-deck-basket.stl stl/pokemon-game-discard-tray.stl \
  stl/pokemon-game-case.stl stl/pokemon-game-lid.stl
```

## Impressão

Cada placa é um job (não cabem duas na cama da A1 mini). Tudo em `3mf/`,
pronto pra abrir no Bambu Studio. Nenhuma peça precisa de suporte.

| Job | Peça | Footprint |
|---|---|---|
| `pokemon-game-t1r1.3mf` | prêmios (baixo) | 146.0 x 107.0 x 7.0 |
| `pokemon-game-t2r1.3mf` | banco 1-2 | 146.0 x 107.0 x 7.0 |
| `pokemon-game-t3r1.3mf` | banco 3-4 | 146.0 x 107.0 x 7.0 |
| `pokemon-game-t4r1.3mf` | banco 5 + rebaixo do descarte | 152.0 x 107.0 x 7.0 |
| `pokemon-game-t1r2.3mf` | prêmios (cima) | 146.0 x 107.0 x 7.0 |
| `pokemon-game-t2r2.3mf` | lost zone | 146.0 x 107.0 x 7.0 |
| `pokemon-game-t3r2.3mf` | ativo + estádio | 146.0 x 107.0 x 7.0 |
| `pokemon-game-t4r2.3mf` | rebaixo do deck | 152.0 x 107.0 x 7.0 |
| `pokemon-game-containers.3mf` | cestinha + cesta, lado a lado | 150.8 x 97.4 x 50.0 |
| `pokemon-game-case.3mf` | case, boca pra cima | 159.2 x 124.6 x 116.4 |
| `pokemon-game-lid.3mf` | tampa, de cabeça pra baixo | 159.2 x 124.6 x 9.0 |

São 11 jobs no total — o case sozinho passa de 11h. Duas observações que
valem a pena:

- **Suporte DESLIGADO em tudo.** Nenhuma peça precisa: a colmeia das placas
  imprime a partir da mesa, e os furos de ímã são hexagonais justamente pra
  fechar em bico.
- **As placas imprimem com a face de jogo pra CIMA**, colmeia aberta na mesa.
  Os 3MF já saem assim.
- **A tampa imprime de cabeça pra baixo** (cara de cima na cama). Com a saia
  pra baixo o painel inteiro ficaria no ar. O 3MF já sai na posição certa.
