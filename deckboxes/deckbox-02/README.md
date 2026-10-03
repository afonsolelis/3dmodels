# deckbox-02

Variante de **um deck só** da [`deckbox-01`](../deckbox-01/) (deck real com
sleeve de **93 × 68 × 45 mm**, medido com régua), com compartimento de
dados/moedas de **64 mm** (~244 cm³) e **sem ímãs**. Bandeja deslizante numa
capa fechada numa ponta, com cestinha de colmeia empurrada por baixo pelo furo
do chão. A fonte é um wrapper: define parâmetros, faz `include` do
`deckbox-01.scad` e sobrescreve os módulos da capa e da cestinha.

## O que reimprimir

**Só a cestinha v2:** [`3mf/deckbox-02-basket.3mf`](./3mf/deckbox-02-basket.3mf).
Sai com o chão na mesa e a boca pra cima, sem suporte, e ocupa
97,0 × 72,0 × 49,6 mm.

A **capa v2 e a bandeja que você já imprimiu continuam valendo** (capa e trava
aprovadas no teste físico). As duas são idênticas, conferidas por nº de
triângulos, bbox e hash dos vértices ordenados, tanto no STL quanto dentro da
chapa.

O [`3mf/deckbox-02-plate.3mf`](./3mf/deckbox-02-plate.3mf) é o conjunto
completo numa chapa (bandeja + cestinha v2 + capa em pé), pra quem imprimir do
zero. Ele **abre no Flash Studio como um objeto único**: use "dividir em
objetos" antes de fatiar, pra poder pôr brim só na capa e mexer em cada peça.
A capa sozinha ([`3mf/deckbox-02-sleeve.3mf`](./3mf/deckbox-02-sleeve.3mf)) e
o cupom do clique ([`3mf/deckbox-02-coupon.3mf`](./3mf/deckbox-02-coupon.3mf))
continuam disponíveis.

| | |
|---|---|
| Reimpressão agora | `3mf/deckbox-02-basket.3mf`: **97,0 × 72,0 × 49,6 mm** |
| Variante pilares | `3mf/deckbox-02-basket-pillars.3mf`: **97,0 × 72,0 × 49,6 mm** |
| Capa sozinha | `3mf/deckbox-02-sleeve.3mf`: **58,0 × 81,6 × 173,6 mm** (brim 3–5 mm) |
| Cupom de teste | `3mf/deckbox-02-coupon.3mf`: **58,0 × 81,6 × 45,0 mm** |
| Conjunto completo | `3mf/deckbox-02-plate.3mf`: **169,6 × 165,8 × 173,6 mm**, job único |
| Conjunto fechado | **173,6 × 81,6 × 58,0 mm** (80,4 fora da faixa reforçada) |
| Peças | bandeja 1, capa 1, cestinha 1 (v2 ou pilares) |
| Hardware | nenhum |
| Suportes | nenhum (brim de 3–5 mm na capa) |

## Cestinha v2: entra e sai fácil, e mais firme

No teste físico a cestinha v1 era ruim de entrar e sair do compartimento e
ficava molenga. O compartimento da bandeja (98 × 73 mm) **não mudou**: só a
cestinha encolheu por fora.

| | v1 | **v2** |
|---|---|---|
| Externo | 97,4 × 72,4 × 49,6 | **97,0 × 72,0 × 49,6** |
| Folga no compartimento | 0,3 mm/lado | **0,5 mm/lado** (deslize vertical de ~50 mm) |
| Borda de baixo | viva | **chanfro 1 mm a 45°** (anula o pé de elefante e guia a entrada) |
| Parede | 1,2 mm | **1,6 mm** (4 voltas de bico), engrossada pra dentro |
| Cantos verticais | vivos | **r = 2 por fora, filete r = 1 por dentro** (1,85 mm na diagonal) |
| Furos das paredes | hex 8 mm, web 2 (~60% de furo) | **hex 6 mm, web 3**, faixa sólida de ~5 mm em cima e embaixo |
| Recorte em U | 40 mm | **32 mm**, cantos r = 6, desce até o chão |
| Chão | colmeia 8 mm | colmeia 8 mm |

- **Deck dentro, JUSTO:** cavidade de 93,8 × 68,8 mm, então o deck de 93 × 68
  fica com só **0,4 mm/lado** (escolha do usuário, pela parede de 1,6 mm). O
  filete interno r = 1 passa a 0,15 mm de um canto vivo de 93 × 68 (carta com
  canto redondo tem mais folga). Se o deck não entrar, o ajuste é
  `basket_wall_v2` (o externo fica fixo).
- **Paredes:** 5 fileiras de hexágonos de ponta pra cima, faixas reais de
  4,95 mm. Faixas sólidas de 4,5 mm junto de cada canto e de 3 mm junto do U.
- **No compartimento:** a borda de cima fica 2,6 mm abaixo da borda da
  bandeja; o uso é o mesmo (empurrar o chão pelo furo de 16 mm, pegar pela
  borda e tirar com o deck).

## Variante: cestinha de pilares

[`3mf/deckbox-02-basket-pillars.3mf`](./3mf/deckbox-02-basket-pillars.3mf),
com 97,0 × 72,0 × 49,6 mm, chão na mesa e sem suporte. Tem o mesmo externo, a
mesma folga de 0,5 mm/lado e o mesmo chão de colmeia, chanfro e cantos da v2,
mas **sem paredes**: só 4 pilares nos cantos, da altura toda. Os lados ficam
abertos do chão ao topo, pra pinçar até a última carta.

- **Pilares em L:** a perna tem 1,6 mm e não dá pra engrossar (o externo é
  limitado pela bandeja e o interno pelo deck). A rigidez vem da forma:
  - **pernas afuniladas de 20 mm no chão a 10 mm no topo.** O ponto fraco de
    uma L aberta é a torção quando o dedo empurra a ponta de uma perna; a
    perna mais curta em cima corta isso a um terço;
  - **miolo do canto preenchido** por dentro (filete r = 2,5; canto de
    2,47 mm na diagonal). Ele exige sleeve com canto r ≥ 1,13 mm (carta e
    sleeve têm ~3). Com uma sleeve de r = 2, que é conservador, sobram
    0,36 mm até o canto da carta;
  - **pé com concordância r = 4** por fora, sem canto vivo, e **chanfro de
    entrada** de 0,8 × 2,5 mm na ponta, por dentro, pra guiar o deck. Por
    dentro do chão não há nada que levante a borda da carta.
- **Chão:** quadro perimetral sólido de 6 mm (sem hexágono), que segura os
  pilares entre si; colmeia de 8 mm no miolo.
- **Vãos abertos** (base → topo): **57 → 77 mm** no lado comprido e
  **32 → 52 mm** no curto.

Deflexão estimada com 5 N na ponta de um pilar (PLA E = 3 GPa, G = 1,1 GPa,
engaste no chão):

| | deflexão |
|---|---|
| flexão, carga em X ou Y | **~0,08 mm** |
| flexão, eixo fraco (diagonal) | ~0,11 mm |
| uma perna isolada de 1,6 mm, mesma carga | ~10,4 mm |
| torção, dedo empurrando a borda da perna (pior altura) | **~0,55 mm** (perna reta de 20 mm: ~1,5) |

A conta não inclui a flexibilidade do chão de 1,6 mm na raiz, então a
deflexão real é um pouco maior. Com o deck dentro, a perna empurrada pra dentro
encosta no deck depois de 0,4 mm.

**Qual usar:**

| | v2 (colmeia) | pilares |
|---|---|---|
| Ver e pegar o deck | U de 32 mm só nas compridas | os 4 lados abertos do chão ao topo |
| Rigidez | parede inteira com furos de 6 mm | concentrada nos 4 pilares e no chão |
| Visual | colmeia (identidade do repo) | só pilares, colmeia no chão |

As duas encaixam igual no mesmo compartimento e têm o deck justo, a
0,4 mm/lado. A v2 continua sendo a padrão e a que vai na chapa completa.

## Trava v2: parede contínua, aba de clique e canal de alívio

Dois ressaltos rampados, um de cada lado da bandeja (1,0 mm de saliência),
assentam em dois **pockets cegos** de 0,8 mm na face interna da capa. Com
folga de 0,5 mm/lado, a parede da capa precisa ceder **0,5 mm** pro ressalto
passar.

- **v1 (reprovada no teste físico: abria sozinha).** Cada parede tinha dois
  rasgos de 1,2 × 32 mm que soltavam uma lingueta de 16 mm. A lingueta era
  mole demais: uns ~4 N abriam a caixa.
- **v2 (esta).**
  - **Sem rasgos:** quem flexiona é a parede inteira. Ela tem reforço
    **externo** de **0,6 mm/lado** nos 36 mm junto da boca, então vai de 1,6
    para **2,2 mm** e deixa 1,4 mm de pele atrás do pocket.
  - **Aba e canal:** logo depois do pocket, do lado da boca, fica uma **aba
    cheia de 1,8 mm**, que dá o clique com a flexão total de 0,5 mm. Depois
    dela vem uma rampa de 1,6 mm e um **canal raso de 0,4 mm** na faixa Z do
    ressalto (6,6 mm), até a boca. No canal sobram só **0,1 mm** de
    interferência por lado.
  - **Na impressão em pé:** o canal fica vertical, sem balanço, e na boca ele
    some dentro do chanfro de entrada.
  - **Cavidade intacta:** o reforço é todo externo, e a rampa dele (4 mm) fica
    18,6 mm antes do pocket.

Flexão exigida da parede (mm/lado) × quanto a bandeja está pra fora. É o perfil
exato do ressalto contra a parede, conferido por interseção CGAL em cada
posição:

| bandeja pra fora (mm) | 0–1 | 1,5 | 2,3–5 | 5,5 | 6 | 6,5 | 7–9,5 | 10 | ≥10,5 |
|---|---|---|---|---|---|---|---|---|---|
| sem canal (antes) | 0 | 0,18 | 0,50 | 0,50 | 0,50 | 0,50 | 0,50→0,21 | 0,05 | 0 |
| **com canal (atual)** | 0 | 0,18 | **0,50** | 0,40 | 0,27 | 0,15 | **0,10** | 0,05 | 0 |

Estimativa de força, com a parede como placa (Ritz) e conferida pela viga
apoiada do print-review (vão 54,8, largura efetiva ~38 mm). PLA E = 3 GPa,
rigidez ~26–30 N/mm por lado:

| | atrito 0,3 | atrito 0,5 (ressalto raspa as camadas) |
|---|---|---|
| **abrir (pico do clique, bandeja a ~2 mm)** | **14–23 N** | 20–33 N |
| aba (bandeja de 2,3 a 5 mm pra fora) | ~8–9 N | ~13–15 N |
| canal até a boca | ~1,5 N | ~2,5–3 N |
| fechar (pico na rampa da aba) | ~16 N | ~23–25 N |

A faixa é honesta, não promessa:

- Se a capa empenar pra dentro (barriga do tubo em pé), a interferência cresce
  e a força sobe, até ~40 N no pior caso.
- Se empenar pra fora, cai, e pode chegar perto de ~10 N.

Com reforço de 0,8 mm a conta dava até 37–43 N com atrito alto, duro demais
pra um dedo. Por isso ficou em 0,6 mm, entre a v1 (abria sozinha) e "dura
demais". A tensão estimada é de 18 MPa ou menos (PLA ~50 MPa), com a peça
parada sem carga: fechada, o ressalto fica solto no pocket, com 1,05 mm de jogo.

## Como usar

- **Fechar:** empurrar a traseira da bandeja com a palma. Nos últimos ~5 mm
  ela sobe a rampa da aba e dá o clique.
- **Abrir:** segurar a capa e empurrar a bandeja pelo **furo de 22 mm** do
  fundo por uns 5 mm (o dedo entra ~10 mm no furo). Isso vence o clique e a
  aba; depois a própria parede empurra a bandeja pela rampa. Dali até a boca
  sobra um **arrasto leve** (~1,5–3 N) com a traseira da bandeja ~5 mm pra
  fora, que dá pra pegar com os dedos e puxar.

Se abrir sozinha de novo, ou ficar dura demais, o ajuste é só na capa:

- `sleeve_reinforce`: a força cresce com o cubo da espessura da parede
- `snap_channel_depth`: o arrasto depois do clique
- `snap_tab`: o comprimento do clique

## Como gerar

Use caminhos absolutos: o flatpak não enxerga `/tmp`, e com caminho relativo
o erro não contém "error". Os comandos canônicos estão no cabeçalho do
[`deckbox-02.scad`](./deckbox-02.scad):

```sh
# cestinha v2 (o que reimprimir agora)
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-basket.3mf -D 'part="basket"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# cestinha de pilares (variante)
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-basket-pillars.3mf -D 'part="basket"' -D 'basket_style="pillars"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# cupom de teste do clique (45mm da boca, de boca pra cima)
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-coupon.3mf -D 'part="sleeve"' -D 'sleeve_coupon=true' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# capa em pé
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-sleeve.3mf -D 'part="sleeve"' -D 'sleeve_print=true' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# conjunto completo
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-plate.3mf -D 'part="plate"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# STLs de referência (posição de uso): <part> = tray | sleeve | basket
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/stl/deckbox-02-<part>.stl -D 'part="<part>"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
```

## Histórico

- **2026-08-10:** impressa com folga de 0,25 mm/lado, a bandeja travou no meio
  do curso por empeno da capa em pé e pé de elefante. A folga subiu para
  0,5 mm/lado e a boca ganhou chanfro de entrada. Veio daí a regra 6 do
  [`CLAUDE.md`](../../CLAUDE.md).
- **2026-09-28:** os ímãs saíram e entraram os ressaltos com linguetas (v1),
  que abriam sozinhas. O ferrolho transversal proposto foi recusado. Na v2
  saíram os rasgos e a parede foi reforçada (0,6 mm/lado). Depois do
  print-review entraram a aba de clique com canal de alívio e o furo de
  22 mm.
- **2026-09-30:** no teste físico a capa v2 ficou perfeita e a trava encaixa
  bem, mas a cestinha era ruim de entrar/sair e molenga. Veio a cestinha v2
  (0,5 mm/lado, parede 1,6, chanfro, cantos arredondados, hex 6 mm com
  faixas sólidas, U de 32 mm; deck justo, 0,4 mm/lado). Bandeja e capa não mudaram. **Teste físico da cestinha v2
  pendente.**
