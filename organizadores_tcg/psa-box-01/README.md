# psa-box-01

Caixa **grande** para slabs PSA (cartas graduadas, lacradas no acrílico da
PSA), em **duas filas de 19 vagas = 38 slabs**. Base alta + tampa
telescópica, no mesmo espírito do modelo de terceiro que a originou.

> **Nota de migração (AD5X).** Este modelo foi dimensionado para a cama
> antiga de 180x180 e por isso encosta nos 176mm — na AD5X (220x220) ele
> agora sobra folga em todos os lados. A geometria segue válida e imprime
> igual; o que mudou é que **deixou de ser um print apertado**. Há espaço
> para uma revisão futura (mais vagas por fila, ou brim liberado).

É pra guardar a **slab PSA NUA** — sem bumper, sem capa, sem case extra.

**Caixa fechada, barreira de luz.** Carta graduada desbota com UV, então nada
que dá pro lado de fora é passante: a colmeia da identidade do repo é gravada
em **baixo relevo** na face externa e a parede continua inteira atrás. De fora
o desenho é o mesmo de uma caixa vazada; de dentro não entra luz.

## ⚠️ Antes de imprimir: rode o gabarito

As medidas da slab **não foram tiradas com régua** (ver a seção abaixo), e a
base é um print de ~427g e ~25–35h. Existe um terceiro job só pra isso:

```
3mf/psa-box-01-test.3mf   90.0 × 31.1 × 45.0mm   ~45g, ~1h
```

É um pedaço da base — uma fila, 3 vagas — com a canaleta, a vaga e o pente
reais. Imprima, pegue uma slab e confira: ela tem que **descer até o chão
sozinha, sem forçar**, e não dançar mais que um chacoalho de folga. Se não
entrar, ajuste `slot_gap_w` (largura) ou `slot_gap_t` (espessura) no `.scad`,
re-exporte e repita o gabarito.

## Peças e jobs

| Nome | No código | Job | Footprint (medido no STL) | Material |
|---|---|---|---|---|
| **gabarito** | `part="test"` | `3mf/psa-box-01-test.3mf` | 90.0 × 31.1 × 45.0mm | 36cm³ (~45g) |
| **base** | `part="base"` / `part="plate"` | `3mf/psa-box-01-base.3mf` | 176.4 × 175.1 × 111.4mm | 344cm³ (~427g) |
| **tampa** | `part="lid"` | `3mf/psa-box-01-lid.3mf` | 176.4 × 175.1 × 55.4mm | 133cm³ (~165g) |

Conjunto fechado: **176.4 × 175.1 × 146.8mm**. Caixa completa (base + tampa):
**~477cm³ / ~592g de PLA**, algo como 25–35h + 10–14h de impressão.

> O peso é o preço de fechar contra luz: a versão vazada dava ~478g. Fechar
> devolveu **+114g** (base +59, tampa +56). O volume acima é o do sólido — o
> fatiador ainda alivia um pouco o chão e o teto, que são chapas grossas.

## De onde vieram as medidas — as fontes DIVERGEM

Nenhuma das três medidas da slab veio da régua do usuário. Só a **espessura
(7.1)** é consenso — a vaga de 7.5 do original fecha com ela. Largura e
altura são as incógnitas:

| Fonte | O que diz |
|---|---|
| `Porta_carte_PSA_x10.3mf` (origem do projeto) | canaleta de **85.0** de largura; vaga 7.5, divisória 1.5, passo 9.0; base 95 × 98.5 × 105.5 com 102 de fundo |
| `my_psa_slab.3mf` | silhueta de **85.00 × 138.52** |
| `Slab_Protectors.3mf` | peças de **85.40 × 140.00** e **86.20 × 140.70** |
| nominal PSA documentado | 3.29" × 5.29" = **83.6 × 134.4** |

**Adotado: 83.6 × 139 × 7.1.** A largura é o nominal documentado; a altura é
o **teto** das fontes, porque altura sobrando é barata (só encompre a base
6mm) e altura faltando **trava a tampa**.

### Envelope que esta caixa aceita

| | Máximo | Se passar disso |
|---|---|---|
| largura | **84.4mm** | subir `slot_gap_w` custa **0.4mm de cama por 0.1mm de folga** — acima de ~84.4 a canaleta modelada não aceita mais a slab; na cama de 220 da AD5X ainda há folga de sobra para subir esse teto, basta re-exportar |
| altura | **142mm** | subir `slab_h`; a tampa acompanha sozinha (é derivada) |
| espessura | **7.5mm** | subir `slot_gap_t`; muda o passo e o comprimento da caixa |

Se a slab real medir 85mm de largura, **duas filas são geometricamente
impossíveis** na A1 mini antiga: 2 × 85 já eram 170 dos 180, e ainda faltavam paredes e
espinho.

## Como se manuseia

1. As slabs entram **em pé, de cima**, uma por vaga.
2. Elas sobram **30mm pra fora da boca da base** — é essa parte exposta que a
   mão pega.
3. As nervuras do pente só sobem **80mm dos 139** da slab. Os ~59mm de cima
   (29 dentro da caixa + 30 fora) ficam soltos: dá pra **abrir as slabs em
   leque com o dedo**, como pasta suspensa, inclinar a que você quer e
   pinçar. Sem essa folga não sairia nenhuma slab do meio da fila — entre
   duas vizinhas sobram só 1.9mm, não entra dedo. (É exatamente assim que o
   original funciona nas fotos do autor, dentro do próprio `.3mf`.)
4. A tampa desce por cima e encaixa num rebaixo de 20mm no topo da base.
   Fechada, a lateral fica **lisa e contínua** — a tampa não sobressai. Pra
   abrir, segura a caixa e puxa a tampa; o relevo da colmeia dá pegada.

## Design

- **Duas filas separadas por um espinho** de 2mm, cada uma com 19 vagas de
  7.5mm num passo de 9.0mm (interior de 169.5mm em Y).
- **Pente de nervuras nas pontas da canaleta**, não divisórias inteiras (é o
  truque do original): cada divisória são 2 nervuras de 9mm de avanço, uma em
  cada ponta, seguindo as bordas da slab. O miolo da canaleta fica vazio —
  são 72 nervuras em vez de 36 aletas de 84mm.
- **Topo da nervura em telhado** (afina de 1.5 pra 0.6mm nos últimos 4mm):
  funil de entrada pra slab e imprime sem ponte.
- **Colmeia hexagonal em BAIXO RELEVO** (identidade do repo, hexágonos de
  ponta pra cima), gravada na face externa — nunca passante:
  - paredes de ponta (±Y) da base: hexágonos de 10mm, relevo de 0.9mm numa
    parede de 2.8 → sobram **1.9mm** de material atrás;
  - paredes laterais (±X) da base: **fendas hexagonais alongadas** entre as
    nervuras — hexágono redondo não cabe nos 7.5mm entre duas nervuras, o
    esticado cabe e mantém as pontas em bico. Também 0.9 de relevo → 1.9mm
    atrás. A primeira e a última vaga de cada fila ficam sem fenda: gravação
    colada no canto vira lasca;
  - tampa: hexágonos de 9mm nas 4 paredes **e no teto**, relevo de 0.6mm →
    sobram **1.8mm** (parede 2.4, teto 2.4);
  - **os espinhos continuam PASSANTES**: são internos, separam uma fila da
    outra e não enxergam o lado de fora com a casca fechada — ali o vazado só
    economiza material.
- **Chão da base MACIÇO (2.4mm)**: carrega os ~1.2kg de 38 slabs quando a
  caixa é levantada, é a aderência de primeira camada de uma peça de 176mm que
  **não tem espaço pra brim**, e é a barreira de luz por baixo.
- **Teto da tampa 2.4mm** (era 2.0 quando vazado): engrossou pra sobrar 1.8
  atrás do relevo. O relevo raso vira um bridge curtinho por célula na
  primeira camada — trivial pro fatiador — e a aderência passa a ser a chapa
  inteira, não só a teia.
- **Encaixe da tampa**: ressalto de 1.3mm × 20mm de altura na base; saia de
  1.3mm na tampa, que engrossa pra 2.4mm acima do encaixe (transição em
  chanfro de 45°, imprime sem suporte). Folga de 0.2mm por lado, conferida na
  malha exportada. A boca da tampa apoia num ombro de 1.5mm — por isso as
  duas peças têm o **mesmo footprint** e o conjunto fica liso por fora.
- **Parede de 2.8mm** não é capricho nem sobra: é o mínimo que hospeda
  ressalto (1.3) + saia (1.3) + folga (0.2), e cada 1mm dela custa 2mm de
  cama.
- **Cantos verticais arredondados** (r=3): melhor na mão e menos empeno numa
  peça grande e alta.

## Cama da AD5X — ATENÇÃO

| Peça | Medido (bbox.py) | Veredito |
|---|---|---|
| base | 176.4 × 175.1 × 111.4 | ok |
| tampa | 176.4 × 175.1 × 55.4 | ok |
| gabarito | 90.0 × 31.1 × 45.0 | ok |

Na cama de 220x220 da AD5X as três peças passam **folgadas** — sobram ~21mm
por lado em X e ~22mm em Y, espaço de sobra pra brim e skirt. (Na A1 mini
antiga isto era um print apertado, com brim e skirt desligados na mão; não é
mais o caso.) Ainda assim, confira no slicer se a peça não conflita com a
linha de purga / área de limpeza. Se conflitar, dá pra ganhar footprint:
  - **X**: cada 0.1mm a menos de `slot_gap_w` tira 0.4mm do X;
  - **Y**: `slots_override = 18` tira 9.0mm do Y (e 2 slabs de capacidade).
- a aderência vem do chão maciço da base e do teto maciço da tampa (as duas
  peças apoiam uma chapa cheia na cama), não de brim.

## Barreira de luz — o que foi conferido

A caixa fechada foi varrida por ~104 mil raios nos três eixos (script de
ray-casting sobre as malhas exportadas, com a tampa posicionada no encaixe):

| Varredura | Raios | Vazamentos |
|---|---|---|
| vertical (Z), planta inteira | 27.888 | **0** |
| horizontal (Y), paredes de ponta | 23.184 | **0** |
| horizontal (X), laterais | 22.908 | **0** |
| junta base/tampa, passo de 0.25mm | 30.498 | **0** |

A menor espessura de material que um raio atravessa no conjunto é **2.60mm**,
numa faixa de 0.6mm de altura logo acima do topo do ressalto, onde só a saia
da tampa cobre (1.3mm de cada lado). Fora dessa faixa é sempre ≥ 3.6mm.

A junta base/tampa não é fresta: a saia desce 20mm por cima do ressalto com
0.2mm de folga — um labirinto de 20mm de comprimento por 0.2 de abertura.
Não há furo de dedo, furo de empurrar nem rasgo em lugar nenhum das duas
peças; o único vazado do projeto são as fendas dos espinhos, que são internas.

## Impressão

- **Dois jobs grandes**, um por peça — nada mais cabe junto na cama. Mais o
  gabarito, que é rápido e vem primeiro.
- Todas **sem suporte**, na orientação exportada:
  - base e gabarito: chão na cama, boca pra cima;
  - tampa: **teto na cama**, boca pra cima (é a face grande que segura a
    peça; a saia fina fica no topo do print).
- Pra barreira de luz valer, imprimir em **filamento opaco** (preto ou cor
  escura). PLA claro e translúcido passa luz mesmo com 1.9mm; e vale subir
  as paredes/topo sólidos no fatiador pra não deixar infill ralo no teto.

## Variantes

Por include, no padrão do repo:

```openscad
slots_override = 18;  // 18 vagas por fila (36 slabs), tira 9mm do Y
rows_override  = 1;   // uma fila só (19 slabs) — a saída se a slab for larga demais
include <../psa-box-01/psa-box-01.scad>
```

## Como gerar

```sh
D=organizadores_tcg/psa-box-01
flatpak run org.openscad.OpenSCAD -o $D/stl/psa-box-01-base.stl -D 'part="base"'  $D/psa-box-01.scad
flatpak run org.openscad.OpenSCAD -o $D/stl/psa-box-01-lid.stl  -D 'part="lid"'   $D/psa-box-01.scad
flatpak run org.openscad.OpenSCAD -o $D/stl/psa-box-01-test.stl -D 'part="test"'  $D/psa-box-01.scad
flatpak run org.openscad.OpenSCAD -o $D/3mf/psa-box-01-test.3mf -D 'part="test"'  $D/psa-box-01.scad
flatpak run org.openscad.OpenSCAD -o $D/3mf/psa-box-01-base.3mf -D 'part="plate"' $D/psa-box-01.scad
flatpak run org.openscad.OpenSCAD -o $D/3mf/psa-box-01-lid.3mf  -D 'part="lid"'   $D/psa-box-01.scad
```

`part="demo"` (base + slabs de mentira + tampa levantada) e `part="cut"`
(corte no meio do conjunto fechado, pra conferir o encaixe) são só pra
preview — nunca exportar.
