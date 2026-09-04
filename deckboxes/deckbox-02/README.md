# deckbox-02

Variante de **um deck só** da [`deckbox-01`](../deckbox-01/), com o
compartimento de dados/moedas **muito mais fundo**: 64mm em vez de 30, ou
**~244 cm³** contra ~114. Caixa estreita e comprida; o conjunto inteiro sai
numa chapa única.

Mesma mecânica da deckbox-01 — bandeja deslizante dentro de uma capa fechada
numa ponta, travada por 4 ímãs, com a cestinha de colmeia empurrada por baixo
pelo furo no chão. **Toda a geometria vem do `deckbox-01.scad`**: este `.scad`
só define quatro parâmetros e faz `include`.

| | |
|---|---|
| Arquivo para imprimir | [`3mf/deckbox-02-plate.3mf`](./3mf/deckbox-02-plate.3mf) |
| Conteúdo | bandeja + cestinha + capa em pé (**job único**) |
| Envelope da chapa | **169,6 × 162,6 × 173,6 mm** |
| Conjunto fechado | **173,6 × 80,4 × 58,0 mm** |
| Peças | bandeja 1, capa 1, cestinha 1 |
| Hardware | 8 ímãs disco 4×2mm (4 + 4), press-fit 0,15 |
| Suportes | nenhum |

## O que muda em relação à deckbox-01

```scad
deck_lanes = 1;              // um compartimento de deck em vez de dois
dice_depth = 64;             // dados/moedas: 64mm de profundidade (era 30)
sleeve_tray_reveal = 0;      // traseira da bandeja alinhada com a boca da capa
sleeve_finger_hole_d = 18;   // furo de dedo maior no fundo da capa
include <../deckbox-01/deckbox-01.scad>
```

- `sleeve_tray_reveal = 0` faz a capa cobrir **tudo** quando fechada: antes
  sobravam 2mm (`back_wall`) de bandeja pra fora. A capa cresceu 2mm no
  comprimento (capa em pé de 171,6 → 173,6mm) e o conjunto fechado continua
  em 173,6mm — o que mudou foi quem ocupa esse comprimento.
- `sleeve_finger_hole_d = 18` abre mais o furo do fundo da capa, pra empurrar
  a bandeja de volta com o dedo sem enfiar a unha.

## No limite da cama

64mm de profundidade de dados **é o máximo prático**, e o teto não é a capa e
sim a bandeja:

- bandeja (imprime **deitada**): 169,6 × 76,2 × 53,8mm — os 169,6 quase
  encostam no limite de conforto de 210mm com a chapa montada
- capa (imprime **em pé**): 173,6mm de altura, contra 220 disponíveis
- cestinha: 97,4 × 72,4 × 49,6mm

Aumentar `dice_depth` acima de 64 estoura a chapa antes de estourar a altura.

## Teste físico e a lição de folga

**Impresso em 2026-08-10: acabamento excelente, mas a bandeja TRAVOU NO MEIO
DO CURSO e não saiu mais.** Era a folga de 0,25mm/lado da época, com um
encaixe de ~167mm de comprimento: o empeno da capa impressa em pé (barriga pra
dentro) mais o pé de elefante da bandeja comem a folga nominal inteira.

Corrigido no `deckbox-01.scad` (vale pras duas caixas):

- folga de deslizamento **0,5mm por lado** (era 0,25)
- **chanfro de entrada** na boca da capa: rampa de 2,5mm abrindo 0,8mm/lado

É de onde saiu a regra 6 do [`CLAUDE.md`](../../CLAUDE.md): *quanto mais longo
o encaixe, mais folga — e sempre com chanfro de entrada na boca.*

## Como gerar

```sh
flatpak run org.openscad.OpenSCAD -D 'part="plate"'  -o 3mf/deckbox-02-plate.3mf   deckbox-02.scad
flatpak run org.openscad.OpenSCAD -D 'part="tray"'   -o stl/deckbox-02-tray.stl    deckbox-02.scad
flatpak run org.openscad.OpenSCAD -D 'part="sleeve"' -o stl/deckbox-02-sleeve.stl  deckbox-02.scad
flatpak run org.openscad.OpenSCAD -D 'part="basket"' -o stl/deckbox-02-basket.stl  deckbox-02.scad
```

Use caminhos absolutos nesta máquina. A cestinha é a **mesma peça** da
deckbox-01.

## Pendência

Re-exportado depois da correção de folga, mas **ainda não reimpresso**. O
próximo teste físico é o que vale: a bandeja tem que entrar e sair no curso
inteiro, com a capa já montada.
