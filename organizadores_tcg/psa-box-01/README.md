# psa-box-01

Caixa **grande** para slabs nuas (cartas graduadas, lacradas no acrílico), em
**duas filas de 19 vagas = 38 slabs**. Base alta + tampa telescópica, no
mesmo espírito do modelo de terceiro que a originou. Serve para slabs
**GRADD, GBA, PSA e CAPY** — sem bumper, sem capa, sem case extra.

**Caixa fechada, barreira de luz.** Carta graduada desbota com UV, então nada
que dá pro lado de fora é passante: a colmeia da identidade do repo é gravada
em **baixo relevo** na face externa e a parede continua inteira atrás. De fora
o desenho é o mesmo de uma caixa vazada; de dentro não entra luz.

Versão de **uma fila só, de 20 slabs**: [`../psa-box-fit/`](../psa-box-fit/)
(include deste `.scad`).

## Medidas da slab

**Paquímetro do usuário (4 medições, 2026-10-13): 80.3 × 135.3 × 6.2mm.**
As quatro marcas que ele tem variam só na espessura (~0.1mm), então a caixa é
dimensionada pela mais grossa: `slab_t = 6.3`. Daí sai todo o resto:

| | Medida | Folga | Resultado |
|---|---|---|---|
| espessura | 6.3 | **0.4/lado** | vaga de **7.1**, passo **8.6** |
| largura | 80.3 | **0.5/lado** | canaleta de **81.3** |
| altura | 135.3 | — | 30mm pra fora da base, 3.0mm até o teto da tampa |

> Histórico: até 2026-10 a slab era estimada por engenharia reversa de malhas
> de terceiros (83.6 × 139 × 7.1). Todas as fontes superestimavam; a medida
> real é menor nos três eixos.

**Por que 0.4/lado na vaga, e não 0.3:** a slab desce 80mm entre nervuras de
1.5mm em pé. O pé de elefante estreita justo o fundo, onde ela precisa
assentar, e nervura fina e alta tende a sair gorda ou inclinada. A diferença
custa 0.2mm de passo (1.9mm em 19 vagas). Mesmo com 0.4/lado a vaga é justa:
a slab inclina no máximo ~1.3mm no topo.

## Antes de imprimir: rode o gabarito

A base é o print grande (~486g). O gabarito é um pedaço dela: uma fila,
3 vagas, com a canaleta, a vaga e o pente reais.

```
3mf/psa-box-01-test.3mf   88.1 × 31.1 × 45.0mm   ~51g
```

Imprima, pegue uma slab de cada marca e confira: ela tem que **descer até o
chão sozinha, sem forçar**, e não dançar mais que um chacoalho de folga. Se
não entrar, suba `slot_gap_w` (largura) ou `slot_gap_t` (espessura) no
`.scad`, re-exporte e repita. O mesmo gabarito vale pro `psa-box-fit`.

## Peças e jobs

| Nome | No código | Job | Footprint (bbox.py) | Material |
|---|---|---|---|---|
| **gabarito** | `part="test"` | `3mf/psa-box-01-test.3mf` | 88.1 × 31.1 × 45.0mm | 40.9cm³ (~51g) |
| **base** | `part="base"` / `part="plate"` | `3mf/psa-box-01-base.3mf` | 189.4 × 168.7 × 107.7mm | 392.0cm³ (~486g) |
| **tampa** | `part="lid"` | `3mf/psa-box-01-lid.3mf` | 189.4 × 168.7 × 55.4mm | 139.0cm³ (~172g) |

Conjunto fechado: **189.4 × 168.7 × 143.1mm**. Caixa completa (base + tampa):
**~531cm³ / ~658g de PLA** (volume do sólido; o fatiador alivia um
pouco o chão e o teto, e o tempo de impressão sai dele).

## Como se manuseia

1. As slabs entram **em pé, de cima**, uma por vaga.
2. Elas sobram **30mm pra fora da boca da base**. É essa parte exposta que a
   mão pega.
3. Pra tirar uma, **pinça a slab pelas duas bordas X** (as estreitas, de
   6.3mm) e puxa reto pra cima:
   - o **polegar** na borda de fora, nos 30mm acima da parede externa;
   - o **indicador** na borda de dentro, descendo no **vão de dedo** entre as
     duas filas.
4. A vaga é justa, então a slab fica em pé e não inclina (no máximo ~1.3mm
   no topo). Entre duas vizinhas sobram só 2.3mm, e por isso o acesso é
   sempre pela **borda**, nunca pela face. A ponta do dedo (~16mm) é mais
   larga que a borda de 6.3mm e encosta também nas bordas das duas vizinhas.
   Pinçe firme na do meio e puxe reto.
5. A tampa desce por cima, guiada pelas **entradas arredondadas** (r1.0), e
   encaixa num rebaixo de 20mm no topo da base até apoiar no ombro. O encaixe
   é justo (0.1/lado) e segura a tampa sem trava. Fechada, a lateral fica
   **lisa e contínua**. Pra abrir, puxa a tampa **reto, pelos dois lados opostos ao mesmo tempo** (puxada por uma borda só ela inclina e calça, efeito gaveta); o
   relevo da colmeia nas laterais da tampa ajuda a pegada.

### Vão de dedo entre as filas

| | Medida |
|---|---|
| vão entre as canaletas (`row_gap`) | **20mm** |
| entre as bordas de dentro das slabs | **21mm** (cabe um indicador) |
| paredes internas (`mid_wall`) | 2 × 2.0mm, até z=84.4 (2mm acima do topo das nervuras) |
| poço entre elas | 16mm, com o chão maciço da caixa |
| borda de **dentro** livre pro dedo | **53.3mm** de cima da slab: 30 fora da base + 23.3 dentro |
| borda de **fora** livre pro polegar | **30mm**, acima da parede externa |

As paredes do meio só sobem até 2mm acima das nervuras, o suficiente pra
segurar as nervuras de dentro em toda a altura. Acima delas, o vão fica
aberto de uma fila à outra, então o dedo desce ~23mm abaixo da boca da base
e pega a borda de dentro bem mais embaixo que o polegar pega a de fora. O vão
fica entre as paredes de ponta e embaixo da tampa: não abre pro lado de fora.

## Design

- **Duas filas separadas por um vão de dedo** de 20mm, cada uma com 19 vagas
  de 7.1mm num passo de 8.6mm (interior de 161.9mm em Y). Até 2026-10-13 as
  filas eram separadas por um espinho de 2mm. Entre as slabs sobravam 3mm, não
  entrava dedo, e nenhuma das 38 slabs dava pra pinçar pelos dois lados.
- **Pente de nervuras nas pontas da canaleta**, não divisórias inteiras (é o
  truque do original): cada divisória são 2 nervuras de 9mm de avanço, uma em
  cada ponta, seguindo as bordas da slab. As de dentro saem das paredes
  internas do vão. O miolo da canaleta fica vazio.
- **Topo da nervura em telhado** (afina de 1.5 pra 0.8mm nos últimos 4mm):
  funil de entrada pra slab, imprime sem ponte, e 0.8 são duas linhas de bico
  0.4.
- **Encaixe da tampa, folga 0.1/lado, igual ao `psa-box-02`.** A parede tem
  **3.4mm** = ressalto da base **1.8** + folga **0.1** + saia da tampa **1.5**,
  com 20mm de altura. As duas entradas são **raio r1.0**: na quina externa do
  topo do ressalto e na quina interna da boca da saia. Isso dá **2.1mm/lado de
  entrada**, e as duas imprimem sem suporte. O topo do ressalto fica com
  **0.8mm planos** depois do raio. A saia fica 0.6mm acima do topo do
  ressalto, então quem apoia é a boca no ombro. As duas peças têm o **mesmo
  footprint** e o conjunto fica liso por fora.

  > **A folga de 0.1/lado contraria a regra 6 do CLAUDE.md de propósito.**
  > No `psa-box-02` (mesmo tipo de encaixe: tampa telescópica de parede fina
  > sobre um gargalo), a 0.5/lado foi impressa e testada na mão em
  > 2026-10-13 e ficou **solta**. A original da DAMA_Lab, com 0.1/lado e
  > entrada em raio r1.0, estava muito boa. O usuário decidiu usar o mesmo
  > encaixe aqui. Não "corrigir" de volta.
- **Colmeia hexagonal em BAIXO RELEVO** (hexágonos de ponta pra cima), nunca
  passante:
  - paredes de ponta (±Y) da base: hexágonos de 10mm, relevo de 0.9 numa
    parede de 3.4, o que deixa **2.5mm** atrás;
  - paredes laterais (±X) da base: **fendas hexagonais alongadas** entre as
    nervuras (hexágono redondo não cabe entre duas nervuras), também 0.9 de
    relevo, **2.5mm** atrás. A primeira e a última vaga de cada fila ficam sem
    fenda, porque gravação colada no canto vira lasca;
  - tampa: hexágonos de 9mm nas 4 paredes **e no teto**, relevo de 0.6, o que
    deixa **1.8mm** atrás (parede 2.4, teto 2.4);
  - **as paredes internas do vão continuam com fendas PASSANTES** (z 12–74,
    10mm abaixo do topo delas): dão pro poço do meio, que é interno.
- **Chão da base MACIÇO (2.4mm)**, inclusive embaixo do poço: carrega ~1.2kg
  de slabs e é a barreira de luz por baixo.
- **Teto da tampa 2.4mm, e o relevo dele começa na cama.** Ou seja, **só a
  teia entre hexágonos e a borda lisa encostam na cama**; cada célula fecha
  com uma ponte curta de 9mm a 0.6mm de altura. Área de contato medida na
  malha: **16.652mm², ~52% do footprint**, o que é aderência de sobra
  em PEI. Ficou assim de propósito: o teto é a cara da caixa fechada, e mover
  a colmeia pra dentro tiraria o desenho de fora. O preço é que o fundo de
  cada célula sai com acabamento de ponte, não de chapa.
- **Cantos verticais arredondados** (r=3): melhor na mão e menos empeno numa
  peça grande e alta.

## Cama da AD5X

| Peça | Medido (bbox.py) | Veredito |
|---|---|---|
| base | 189.4 × 168.7 × 107.7 | ok |
| tampa | 189.4 × 168.7 × 55.4 | ok |
| gabarito | 88.1 × 31.1 × 45.0 | ok |

Todas dentro do alvo de 210, com espaço pra brim. Base e tampa são um job
cada (duas peças de 189mm não cabem lado a lado).

**Capacidade máxima em ≤210:** com o mesmo passo, cabem **até 23 vagas por
fila** (46 slabs, Y = 203.1). 24 vagas dariam 211.7 (justo, 210–220). Pra
mudar, `slots_override` por include ou `-D slots_per_row=N` por CLI. O X
(189.4) não muda com o número de vagas.

## Barreira de luz: o que foi conferido

Checagem refeita em 2026-10-13 nas malhas exportadas desta versão (com o vão
de dedo e o encaixe de 0.1/lado), com a tampa posicionada no encaixe. Para
cada uma das 6 faces externas, a faixa de 5mm da parede (base + saia +
ressalto) foi projetada no eixo normal e subtraída da silhueta da caixa.
**Resultado: nenhuma área descoberta nas 6 faces**, ou seja, nenhum raio reto
atravessa uma parede. Controle positivo: um furo de 3mm em cada face e uma
fresta de 0.3mm na junta, plantados de propósito, foram detectados.

Menor espessura de parede que um raio horizontal atravessa: **1.5mm**, numa
faixa de 0.6mm de altura logo acima do topo do ressalto, onde só a saia cobre.
No raio do ressalto é 1.5 + parte do ressalto; na junta, 1.5 + 1.8 = 3.3;
atrás de qualquer relevo, ≥1.8.

A junta base/tampa não é fresta: é um labirinto de 20mm de comprimento por
0.1 de abertura. O vão de dedo e o poço ficam entre as paredes de ponta,
fechados por baixo pelo chão maciço e por cima pela tampa. Não há furo de
dedo nem rasgo em nenhuma das duas peças; o único vazado são as fendas das
paredes internas, que dão pro poço.

## Impressão

- **Dois jobs grandes**, um por peça, e o gabarito antes.
- Todas **sem suporte**, na orientação exportada:
  - base e gabarito: chão na cama, boca pra cima. As paredes internas do vão
    são lâminas de 2mm × 82mm presas nas pontas, no chão e nas nervuras;
  - tampa: **teto na cama**, boca pra cima (a saia fina e o raio da boca
    ficam no topo do print).
- Pra barreira de luz valer, imprimir em **filamento opaco** (preto ou cor
  escura). PLA claro e translúcido passa luz mesmo com 2mm; vale subir as
  paredes/topo sólidos no fatiador pra não deixar infill ralo no teto.
- Encaixe de 0.1/lado: se a tampa sair dura demais com o pé de elefante,
  lixe de leve a base do ressalto ou ative a compensação de pé de elefante no
  fatiador, em vez de abrir a folga no `.scad`.

## Variantes

Por include, no padrão do repo (é o que o `psa-box-fit` faz):

```openscad
rows_override  = 1;   // uma fila só
slots_override = 20;  // vagas por fila
include <../psa-box-01/psa-box-01.scad>
```

Com uma fila, `part="plate"` põe a tampa do lado da base (`plate_both`) e o
`row_gap` não entra. Por CLI o `-D slots_override=...` **não pega** (OpenSCAD
2021.01); use `-D slots_per_row=N` / `-D rows=N` / `-D row_gap=N`.

## Como gerar

```sh
D=organizadores_tcg/psa-box-01
openscad -o $D/stl/psa-box-01-base.stl -D 'part="base"'  $D/psa-box-01.scad
openscad -o $D/stl/psa-box-01-lid.stl  -D 'part="lid"'   $D/psa-box-01.scad
openscad -o $D/stl/psa-box-01-test.stl -D 'part="test"'  $D/psa-box-01.scad
openscad -o $D/3mf/psa-box-01-test.3mf -D 'part="test"'  $D/psa-box-01.scad
openscad -o $D/3mf/psa-box-01-base.3mf -D 'part="plate"' $D/psa-box-01.scad
openscad -o $D/3mf/psa-box-01-lid.3mf  -D 'part="lid"'   $D/psa-box-01.scad
```

(`openscad` = `flatpak run org.openscad.OpenSCAD` no Linux, ou
`"C:\Program Files\OpenSCAD\openscad.com"` no Windows; caminhos absolutos.)
`part="demo"` (base + slabs de mentira, uma sendo puxada, + tampa levantada)
e `part="cut"` (corte no meio do conjunto fechado, pra conferir o encaixe e o
vão de dedo) são só pra preview, nunca exportar.
