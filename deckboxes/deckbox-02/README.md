# deckbox-02

Variante de **um deck só** da [`deckbox-01`](../deckbox-01/) (deck real com
sleeve de **93 × 68 × 45 mm**, medido com régua), com compartimento de
dados/moedas de **64 mm** (~244 cm³) e **sem ímãs**. Bandeja deslizante numa
capa fechada numa ponta, presa por dois ressaltos que clicam em pockets da
capa, com cestinha de pilares empurrada por baixo pelo furo do chão. A fonte
é um wrapper: define parâmetros, faz `include` do `deckbox-01.scad` (que não
muda) e sobrescreve a capa, a cestinha e os parâmetros da trava.

## O que imprimir agora (2026-10-11: trava v3 + seta)

**Bandeja e capa mudaram juntas.** A trava v3 tem o ressalto maior (saliência
1,5 mm) e o pocket mais fundo (1,2 mm): a bandeja v3 **não entra** no pocket
da capa v2 já impressa (1,0 > 0,8) e a bandeja v2 na capa v3 pega só 0,5 mm e
fica bamba no pocket. Imprimir o **par novo**:

- Tudo de uma vez: [`3mf/deckbox-02-plate.3mf`](./3mf/deckbox-02-plate.3mf)
  (bandeja + cestinha de pilares + capa em pé, 169,6 × 166,8 × 173,6 mm). Ele
  **abre no Flash Studio como um objeto único**: use "dividir em objetos"
  antes de fatiar, pra pôr brim só na capa.
- Ou, pra sentir o clique antes de gastar a capa inteira: o cupom
  [`3mf/deckbox-02-coupon.3mf`](./3mf/deckbox-02-coupon.3mf) (os 45 mm da
  boca) com a bandeja v3.

A cestinha de pilares que você já imprimiu **continua valendo** (geometria
idêntica: 2412 triângulos, mesmo bbox e hash de vértices do antigo
`-pillars`).

| | |
|---|---|
| Conjunto completo | `3mf/deckbox-02-plate.3mf`: **169,6 × 166,8 × 173,6 mm**, job único |
| Capa sozinha | `3mf/deckbox-02-sleeve.3mf`: **58,0 × 81,6 × 173,6 mm** (brim 3–5 mm) |
| Cestinha | `3mf/deckbox-02-basket.3mf`: **97,0 × 72,0 × 49,6 mm** |
| Cupom de teste | `3mf/deckbox-02-coupon.3mf`: **58,0 × 81,6 × 45,0 mm** |
| Conjunto fechado | **173,6 × 81,6 × 58,0 mm** (80,4 fora da faixa reforçada) |
| Bandeja com ressaltos | 169,6 × 79,2 × 53,8 mm |
| Peças | bandeja 1, capa 1, cestinha 1 |
| Hardware | nenhum |
| Suportes | nenhum (brim de 3–5 mm na capa) |

## Seta de orientação na capa

A capa era simétrica em cima e embaixo, e dava pra abrir com o deck virado
pra baixo sem perceber (empurra pelo furo do fundo sem olhar) — as cartas
caíam. Agora a **face de cima** da capa (a que cobre o topo aberto da
bandeja na posição de uso) tem uma **seta rebaixada** de 0,6 mm, 36 mm de
comprimento e 18 mm de largura na cabeça (haste de 8), no meio do
comprimento, apontando pra **boca**.

- **Uso:** seta pra cima, dedo no furo do fundo, empurra: a bandeja sai com as
  cartas pra cima.
- **Impressão:** no job da capa (em pé) essa face é parede vertical e a seta
  aponta pra cima. As únicas bordas do rebaixo que ficam "penduradas" são as
  duas da cabeça (34° da vertical) e a ponta, com 0,6 mm de balanço:
  desprezível. Sobra 1,0 mm de parede sob a seta.
- **Cor:** o rebaixo dá pra pintar em outra cor no Flash Studio (IFS).
- Sem a palavra "CIMA": `text()` não renderiza no OpenSCAD 2021.01 do flatpak
  (sem fontes, sai objeto vazio).
- O cupom (45 mm da boca) não inclui a seta.

## Cestinha de pilares

[`3mf/deckbox-02-basket.3mf`](./3mf/deckbox-02-basket.3mf), 97,0 × 72,0 ×
49,6 mm, chão na mesa, sem suporte. Entra no compartimento de 98 × 73 mm da
bandeja com **0,5 mm/lado** (deslize vertical de ~50 mm), chanfro de 1 mm a
45° na borda de baixo (anula o pé de elefante e guia a entrada) e cantos
r = 2 por fora. **Sem paredes**: só 4 pilares nos cantos, da altura toda, com
os lados abertos do chão ao topo pra pinçar até a última carta.

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
    entrada** de 0,8 × 2,5 mm na ponta, por dentro, pra guiar o deck.
- **Chão:** quadro perimetral sólido de 6 mm (sem hexágono), que segura os
  pilares entre si; colmeia de 8 mm no miolo.
- **Vãos abertos** (base → topo): **57 → 77 mm** no lado comprido e
  **32 → 52 mm** no curto.
- **Deck dentro, JUSTO:** cavidade de 93,8 × 68,8 mm, o deck de 93 × 68 fica
  com **0,4 mm/lado** (escolha do usuário). Se não entrar, o ajuste é
  `basket_wall_v2` (o externo fica fixo).
- **No compartimento:** a borda de cima fica 2,6 mm abaixo da borda da
  bandeja; empurrar o chão pelo furo de 16 mm, pegar pela borda e tirar com o
  deck.

Deflexão estimada com 5 N na ponta de um pilar (PLA E = 3 GPa, G = 1,1 GPa,
engaste no chão):

| | deflexão |
|---|---|
| flexão, carga em X ou Y | **~0,08 mm** |
| flexão, eixo fraco (diagonal) | ~0,11 mm |
| uma perna isolada de 1,6 mm, mesma carga | ~10,4 mm |
| torção, dedo empurrando a borda da perna (pior altura) | **~0,55 mm** (perna reta de 20 mm: ~1,5) |

A conta não inclui a flexibilidade do chão de 1,6 mm na raiz. Com o deck
dentro, a perna empurrada pra dentro encosta no deck depois de 0,4 mm.

Histórico curto: a v1 (= deckbox-01, 0,3 mm/lado, cantos vivos, hex 8 mm com
~60% de furo, U de 40 mm) era ruim de entrar/sair e molenga. Em 2026-09-30
vieram duas cestinhas com o mesmo externo e folga: a v2 de paredes (colmeia
6 mm com faixas sólidas, U de 32 mm) e a de pilares. Em 2026-10-11 o usuário
ficou com a de pilares e a v2 foi apagada da fonte.

## Trava v3: ressalto maior, parede contínua, aba de clique e canal de alívio

Dois ressaltos rampados, um de cada lado da bandeja, assentam em dois
**pockets cegos** na face interna da capa. A parede da capa é contínua (sem
rasgos) e flexiona inteira pro ressalto passar.

| | v2 (aprovada 2026-09-30) | **v3** |
|---|---|---|
| Saliência do ressalto | 1,0 mm | **1,5 mm** |
| Pega no pocket (saliência − folga de 0,5) | 0,5 mm | **1,0 mm** |
| Base do ressalto (X × Z) | 5 × 6 | **7 × 7** (patamar 1 × 4 igual) |
| Rampa em X / chanfro em Z | 26,6° / 45° | 26,6° / 45° (mantidos) |
| Fundo do pocket | 0,8 mm | **1,2 mm** (0,2 de folga no fundo) |
| Pele atrás do pocket | 1,4 mm | **1,0 mm** (parede vertical em pé, 2 perímetros) |
| Canal de alívio | 0,4 mm | **0,9 mm** (residual 0,1 igual; pele 1,3) |
| Faixa Z do canal | 6,6 | 7,6 (segue a base do ressalto + folga) |
| Flexão da parede no clique | 0,5 mm | **1,0 mm** |

O usuário pediu "uns 2 mm" de pega. Saliência 2,0 exigiria 1,5 mm de flexão da
parede contínua: ~3× a força (abrir 40–70 N, inviável pelo furo) e tensão de
~54 MPa, acima do PLA. Ficou 1,5: o dobro da pega da v2 com o dobro da força.
A base 2 mm mais comprida é o "2 mm" do pedido e mantém a rampa de fechar;
a base 1 mm mais alta mantém o chanfro em Z a 45° (com 6 mm ficava 34°,
balanço na bandeja deitada).

- **Reforço externo** de **0,6 mm/lado** nos 36 mm junto da boca (parede 1,6
  → 2,2 mm). 0,8 engrossa e multiplica a força; ficou em 0,6.
- **Aba e canal:** logo depois do pocket, do lado da boca, uma **aba cheia de
  1,8 mm** dá o clique com a flexão total de 1,0 mm. Depois dela, rampa de
  1,6 mm e **canal de 0,9 mm** na faixa Z do ressalto (7,6 mm) até a boca,
  onde sobram só **0,1 mm** de interferência por lado; na boca o ressalto
  entra com 0,1 mm (canal 0,9 vs chanfro de 0,8).
- **Fechada:** o ressalto fica solto no pocket, com 0,8 mm de jogo em X por
  lado e 0,2 até o fundo. Interseção CGAL bandeja × capa na posição fechada:
  vazia.
- **Na impressão em pé:** pocket, canal e rampas ficam verticais ou fecham a
  22° da vertical; sem balanço. A pele de 1,0 mm atrás do pocket é parede
  vertical com 2 perímetros.
- **Cavidade intacta:** o reforço é todo externo, e a rampa dele (4 mm) fica
  17,6 mm antes do pocket.

Flexão exigida da parede (mm/lado) × quanto a bandeja está pra fora,
calculada pelo perfil exato e conferida por interseção CGAL com a parede
deslocada `d` pra fora em cada posição:

| bandeja pra fora (mm) | 0–0,5 | 1 | 1,5 | 2 | 2,5 | 3 | 3,5–6 | 6,5 | 7 | 8–11 | ≥11,5 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| v2 | 0 | 0 | 0,18 | 0,50 | 0,50 | 0,50 | 0,50→0,27 | 0,15 | 0,10 | 0,10→0 | 0 |
| **v3** | 0 | 0,08 | 0,28 | 0,48 | 0,68 | 0,88 | **1,00** | 0,80 | 0,55 | **0,10** | 0 |

Estimativa de força (parede como viga/placa, rigidez k = 26–30 N/mm por
lado, PLA E = 3 GPa; conta direta F = 2·k·1,0·(tan α + μ)/(1 − μ·tan α),
conferida pelo print-review):

| | atrito 0,3 | atrito 0,5 (ressalto raspa as camadas) |
|---|---|---|
| **abrir (pico, bandeja a ~3,5 mm, rampa do pocket 21,8°)** | **41–48 N** | 58–67 N |
| aba (bandeja de 3,5 a 6 mm pra fora) | ~16–18 N | ~26–30 N |
| canal até a boca | ~1,6–1,8 N | ~2,6–3 N |
| fechar (pico na rampa do ressalto, 26,6°, com a palma) | ~49–56 N | ~69–80 N |

A faixa é honesta, não promessa: se a capa empenar pra dentro 0,3 mm/lado
a força de abrir vai a ~58 N (até ~80 N no pior caso); pra fora, cai
(~20 N). Referência: o indicador empurra ~30–45 N com conforto, o polegar
~60–90 N — a v3 é **firme**, não leve. Tensão de pico 13–26 MPa (viga
apoiada/engastada) a ~36 MPa (placa Ritz), abaixo dos ~50 MPa do PLA mas
perto do limite de fadiga (20–25 MPa), só durante o clique. **Aguardando
teste físico da v3** — o cupom é o jeito barato de sentir o clique. Se
ficar duro (ou trincar no pocket com o uso), o fallback é
`snap_projection = 1.3`, `snap_pocket_depth = 1.0`, `snap_channel_depth = 0.7`
(flexão 0,8, abrir ~33–38 N, pele do pocket volta a 1,2).

A seta diz qual lado é o de cima, mas **não impede** fechar a bandeja de
cabeça pra baixo: o ressalto fica no meio da altura, então a bandeja entra
na capa dos dois jeitos. Fechar sempre com as cartas viradas pra seta.

## Como usar

- **Fechar:** empurrar a traseira da bandeja com a palma. Nos últimos ~7 mm
  ela sobe a rampa da aba e dá o clique.
- **Abrir:** **seta pra cima**, segurar a capa e empurrar a bandeja pelo
  **furo de 22 mm** do fundo por uns 6 mm (o dedo entra ~10 mm no furo). Isso
  vence o clique e a aba; depois a própria parede empurra a bandeja pela
  rampa. Dali até a boca sobra um **arrasto leve** (~2–3 N) com a traseira da
  bandeja ~5 mm pra fora, que dá pra pegar com os dedos e puxar.

Se ficar dura demais, o ajuste é só no wrapper (e vale pra bandeja e capa):

- `snap_projection`: a pega (1,5; a v2 era 1,0) — a força é proporcional a
  `snap_projection − 0,5`
- `sleeve_reinforce`: a força cresce com o cubo da espessura da parede
- `snap_channel_depth`: o arrasto depois do clique
- `snap_tab`: o comprimento do clique

## Como gerar

Use caminhos absolutos: o flatpak não enxerga `/tmp`, e com caminho relativo
o erro não contém "error". Os comandos canônicos estão no cabeçalho do
[`deckbox-02.scad`](./deckbox-02.scad):

```sh
# conjunto completo (bandeja + cestinha + capa em pé)
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-plate.3mf -D 'part="plate"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# capa em pé
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-sleeve.3mf -D 'part="sleeve"' -D 'sleeve_print=true' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# cestinha de pilares
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-basket.3mf -D 'part="basket"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# cupom de teste do clique (45mm da boca, de boca pra cima)
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-coupon.3mf -D 'part="sleeve"' -D 'sleeve_coupon=true' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
# STLs de referência (posição de uso): <part> = tray | sleeve | basket
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/stl/deckbox-02-<part>.stl -D 'part="<part>"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
```

Os parâmetros da trava (`snap_projection`, `snap_length`, `snap_height`,
`snap_pocket_depth`) são reatribuídos no wrapper **depois** do `include`: no
OpenSCAD a última atribuição vale pro arquivo inteiro e os derivados do
deckbox-01 pegam o valor novo (conferido no `ECHO`:
`required_deflection_mm = 1`).

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
  bem, mas a cestinha era ruim de entrar/sair e molenga. Vieram a cestinha v2
  de paredes e a variante de pilares (0,5 mm/lado, chanfro, cantos
  arredondados; deck justo, 0,4 mm/lado).
- **2026-10-11:** a cestinha v2 de paredes foi apagada; ficou só a de
  pilares. Trava v3 a pedido do usuário ("pinguelo maior pra travar melhor"):
  saliência 1,5, base 7 × 7, pocket 1,2, canal 0,9. Seta de orientação
  rebaixada na face de cima da capa. **Bandeja e capa mudam juntas; teste
  físico da trava v3 e da cestinha pendentes.**
