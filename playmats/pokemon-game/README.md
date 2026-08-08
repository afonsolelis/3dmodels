# pokemon-game

Plataforma completa pra jogar Pokémon TCG: o campo de um jogador em 12 placas
que se plugam por ímã, com as zonas em relevo, mais os contêineres que viram
deckbox e porta-dados e um case que guarda tudo e vira bandeja de rolar dados.

## Medidas

| | |
|---|---|
| Campo montado | 590 x 321 mm, 7mm de espessura |
| Placas | 146 x 107 x 7 (nove) e 152 x 107 x 7 (três) |
| Carta com sleeve (medida com régua) | 68 x 93 mm |
| Deck de 60 com sleeve | 93 x 68 x 45 mm |
| Cavidade de carta | 70 x 95 mm, 1mm de profundidade |
| Case fechado | 159.2 x 152.6 x 120.4 mm (interior 154.4 x 139 x 114) |
| Cestinha do deck / cesta do descarte | 72.4 x 97.4 x 50 / x 30 mm |
| Ímãs | 80 discos de 4x2mm (68 nas placas, 12 no case) |

Pra comparar: playmat de torneio tem 610 x 356mm, e dois tabuleiros impressos
que serviram de referência têm 570 x 250 e ~490 x 220 por jogador. O nosso
fica no meio — e é o único que cabe placa por placa numa A1 mini.

## O campo

Jogador na borda de baixo, oponente em cima. Grid de 4 colunas x 3 fileiras;
cada fileira tem 107mm, que é o que comporta uma carta inteira (95) com 6mm
de parede de cada lado da costura.

```
        col 1 (146)     col 2 (146)     col 3 (146)    col 4 (152)
      +-------------+---------------+---------------+---------------+
 r3   | PRÊMIO PRÊMIO| CONTADORES   |   ESTÁDIO     |  DISH DA      |  oponente
      |   5     6    | (bandeja)    |               |   MOEDA       |
      +-------------+---------------+---------------+---------------+
 r2   | PRÊMIO PRÊMIO| LOST ZONE    |   ATIVO       |     DECK      |
      |   3     4    |              |               |  (rebaixo)    |
      +-------------+---------------+---------------+---------------+
 r1   | PRÊMIO PRÊMIO| BANCO  BANCO | BANCO  BANCO  | BANCO DESCARTE|  jogador
      |   1     2    |   1      2   |   3      4    |   5 (rebaixo) |
      +-------------+---------------+---------------+---------------+
```

- **Banco** — 5 cavidades na fileira da frente
- **Ativo** — centralizado sobre o banco
- **Prêmios** — **grade 2x3**, cada carta no seu bolso inteiro. A regra exige
  que fiquem do lado oposto ao deck/descarte, por isso à esquerda
- **Deck e Descarte** — rebaixos de 5mm que recebem a cestinha e a cesta
- **Lost Zone** — fileira do meio (a regra manda ficar fora do mat, mas deck
  moderno usa direto)
- **Estádio** — fileira de cima, alinhado com o ativo: é a que encosta no
  campo do oponente, que é onde a regra manda o estádio ficar
- **Contadores e moeda** — os dois cantos da fileira de cima que sobrariam
  vazios viraram a bandeja onde se despeja o dano e o dish onde a moeda é
  jogada sem sair rolando pela mesa

Cada zona tem o **nome gravado em baixo relevo no piso**, em português:
PRÊMIO, BANCO, ATIVO, ZONA PERDIDA, ESTÁDIO, DECK, DESCARTE, CONTADORES e
MOEDA. A gravação tem 0,6mm e fica no fundo da cavidade, não na superfície:
some debaixo da carta durante o jogo e reaparece quando o espaço esvazia,
que é exatamente quando você precisa dela. Pra trocar o texto (ou voltar
"ZONA PERDIDA" pra "LOST ZONE"), é uma linha no `.scad`.

DECK e DESCARTE são a exceção: o contêiner tampa o rebaixo inteiro, então
o nome no piso só aparece com a cestinha fora. Por isso esses dois **também
vão gravados na parede curta externa do próprio contêiner** (nas duas, pra
ler certo em qualquer orientação), a 2mm acima da superfície do campo — ali
o nome fica à vista o jogo inteiro. A faixa de colmeia que a letra ocupa é
reservada, então nenhuma letra cai em cima de furo.

Com três fileiras, cada carta de prêmio cabe inteira numa placa e a **grade
2x3 fecha**. Com duas fileiras isso não era possível: uma carta de 93mm não
cabia por fileira e os prêmios precisavam se encavalar feito telha, o que
obrigava a colocá-los de cima pra baixo e a mexer nos vizinhos pra pegar um.

## Montagem

As placas **se plugam por ímã**: encoste uma na outra e elas puxam sozinhas.
São 2 ímãs por costura, 17 costuras, 68 ímãs.

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

## Contêineres e case

- **Cestinha do deck** — cai no rebaixo da fileira do meio e segura o deck em
  pé. Vazada em colmeia, com recorte em U dos dois lados descendo até o chão,
  pra pinçar até a última carta. Fora do jogo, é o deckbox.
- **Cesta do descarte** — mesmo footprint, mais baixa, com escalopes fundos
  nos quatro lados: dá pra enfiar o dedo e pegar a pilha inteira. Fora do
  jogo, é a caixa de dados e contadores.
- **Case** — as placas ficam **em pé, lado a lado como livros numa estante**:
  você puxa cada uma pela borda de cima por duas janelas no rebordo. Ao lado
  delas, os contêineres viajam **deitados**, de boca virada pras placas, que
  assim os tampam. Vazio, o interior é a bandeja de rolar dado, com fundo em
  colmeia que amortece o quique.
- **Tampa** — fecha por **12 ímãs 4x2mm** (6 pares) alojados num **flange
  externo** que contorna as duas paredes compridas. O flange existe porque a
  parede de 2.4mm não comporta um furo de 4mm — e ele fica por fora
  justamente pra deixar o interior um prisma limpo, senão as placas em pé
  (152mm) não passariam.

**Onde vão os dados:** num bolso atrás da cesta de descarte — ela é mais rasa
que a cestinha do deck, e a diferença vira compartimento. Deitada, a cesta não
segura dado (os escalopes viram furos laterais), então o bolso é fechado pelo
chão sólido dela, pela parede de trás do case e pela lateral da cestinha.

## Ver tudo de uma vez

`pokemon-game-overview.3mf` (na raiz do projeto, fora de `3mf/` porque **não
é um job de impressão**) traz as **16 peças como objetos separados**, numa
grade em que cada célula é uma cama da A1 mini. Abre num arquivo só e você vê
o conjunto inteiro; no Bambu Studio, "Organizar tudo" distribui pelas plates
sozinho. Pra imprimir de verdade, prefira os arquivos de `3mf/`, que já saem
na orientação certa e com as peças agrupadas como devem ser impressas.

Pra regerar depois de mudar alguma peça, veja `.claude/skills/overview/`.

## Impressão

Cada placa é um job (não cabem duas na cama da A1 mini). São **15 jobs** no
total: 12 placas, os contêineres juntos, o case e a tampa. Tudo em `3mf/`.

| Job | Peça | Footprint |
|---|---|---|
| `pokemon-game-t1r1.3mf` | prêmios 1 e 2 | 146 x 107 x 7 |
| `pokemon-game-t2r1.3mf` | banco 1 e 2 | 146 x 107 x 7 |
| `pokemon-game-t3r1.3mf` | banco 3 e 4 | 146 x 107 x 7 |
| `pokemon-game-t4r1.3mf` | banco 5 + descarte | 152 x 107 x 7 |
| `pokemon-game-t1r2.3mf` | prêmios 3 e 4 | 146 x 107 x 7 |
| `pokemon-game-t2r2.3mf` | lost zone | 146 x 107 x 7 |
| `pokemon-game-t3r2.3mf` | ativo | 146 x 107 x 7 |
| `pokemon-game-t4r2.3mf` | deck | 152 x 107 x 7 |
| `pokemon-game-t1r3.3mf` | prêmios 5 e 6 | 146 x 107 x 7 |
| `pokemon-game-t2r3.3mf` | bandeja de contadores | 146 x 107 x 7 |
| `pokemon-game-t3r3.3mf` | estádio | 146 x 107 x 7 |
| `pokemon-game-t4r3.3mf` | dish da moeda | 152 x 107 x 7 |
| `pokemon-game-containers.3mf` | cestinha + cesta | 150.8 x 97.4 x 50 |
| `pokemon-game-case.3mf` | case, boca pra cima | 159.2 x 152.6 x 116.4 |
| `pokemon-game-lid.3mf` | tampa, de cabeça pra baixo | 159.2 x 152.6 x 9.0 |

Duas observações que valem a pena:

- **Suporte DESLIGADO em tudo.** Nenhuma peça precisa: a colmeia das placas
  imprime a partir da mesa, e os furos de ímã são hexagonais justamente pra
  fechar em bico.
- **As placas imprimem com a face de jogo pra CIMA**, colmeia aberta na mesa.
  Os 3MF já saem assim. A tampa é a única peça que imprime de cabeça pra
  baixo — com a saia pra baixo o painel inteiro ficaria no ar.
