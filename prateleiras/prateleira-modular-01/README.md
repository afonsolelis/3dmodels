# prateleira-modular-01

Prateleira de parede **modular "infinita"**: uma peça só, repetida. Dois
módulos fazem 400mm de prateleira, três fazem 600, e assim por diante — não
existe peça de canto, de ponta nem de emenda. Cada módulo tem **mão francesa
integrada**, então é uma prateleira de verdade, não uma chapa em balanço.

| | |
|---|---|
| Arquivo para imprimir (comece por ele) | [`3mf/prateleira-modular-01-x1.3mf`](./3mf/prateleira-modular-01-x1.3mf) |
| Chapa cheia | [`3mf/prateleira-modular-01-x2.3mf`](./3mf/prateleira-modular-01-x2.3mf) — 2 módulos, 207 × 206mm |
| Envelope de 1 módulo (impressão) | **207 × 100 × 100 mm** |
| Prateleira entregue por módulo | **200 × 100 mm** (passo de 200mm de parede) |
| Prato | 6mm de espessura, colmeia hexagonal passante |
| Aba de parede | 100mm de altura × 3mm (68 abaixo do prato, 26 acima) |
| Mão francesa | 2 × 5mm, a 45°, alcance de 68mm (68% da profundidade) |
| Suportes | **nenhum** |
| Hardware | 2 parafusos de haste **Ø4** por módulo (+1 opcional embaixo) |
| Volume sólido | 182,7 cm³ por módulo |

## Como monta na parede

1. Parafusa o **módulo A**: dois parafusos Ø4 nos furos de cima (x = 50 e 150,
   a 88mm da base da aba, logo acima do prato) e, se quiser o serviço bem
   feito, o terceiro embaixo (x = 100, a 12mm da base).
2. Pega o **módulo B**, apresenta ele **à frente** do A com o rasgo em T da
   esquerda alinhado ao trilho em T da direita do A, e **empurra pra trás**
   até a aba do B encostar na parede. O trilho corre os 100mm inteiros.
3. Parafusa o B. Repete pra sempre.

Pra tirar um módulo **do meio** da fileira: solta os parafusos e **puxa pra
frente** — ele sai dos dois vizinhos ao mesmo tempo, porque os dois encaixes
são do mesmo eixo.

A ponta direita da fileira fica com o trilho de 7mm exposto e a esquerda com o
rasgo aberto. É o preço de ter uma peça só — que era o pedido. Quem quiser
ponta limpa imprime um módulo com `with_rail=false`; é opção de parâmetro, não
peça nova (o 3MF do repo é sempre o módulo universal).

## O encaixe (trilho em T)

Seção constante correndo os 100mm de profundidade: pescoço de 3 × 2mm e cabeça
de 4 × 5mm, 7mm de saliência total, dentro de uma **banda reforçada** de 14mm
de largura por 10mm de espessura na borda do prato (ela engrossa pra baixo, o
topo fica plano) — a banda é também uma viga longitudinal embaixo de cada
emenda.

- **Trava em X com batente de 90°**: a cabeça de 5mm não passa pela boca de
  2,7mm. São 1,15mm de mordida por lado, sem amplificação de folga (é o
  problema do rabo de andorinha curto: a folga de flanco vira folga de
  arranque dividida pelo seno do ângulo).
- **Alinha a emenda inteira**: o degrau máximo possível entre dois pratos
  vizinhos é 0,7mm (2 × a folga), ao longo de todos os 100mm.
- **Folga 0,35/lado** em todo o contorno, aplicada como offset uniforme, mais
  chanfro de entrada nos últimos 5mm do trilho. É encaixe longo, mas na
  direção em que a peça **não** empena: na impressão cada camada do perfil é
  cópia da anterior. Se um exemplar sair apertado, subir `joint_clear` pra
  0,45 e reimprimir só ele.

### Prova de encaixe (medida, não deduzida)

`part="fit"` faz a **interseção** de dois módulos vizinhos; o volume sai do
[`stlinfo.py`](../../.claude/skills/bed-check/stlinfo.py):

| caso | interferência |
|---|---|
| montado (fim do curso) | **0,000 mm³** |
| meio do curso (recuo de 25, 50 e 99mm) | **0,000 mm³** |
| degrau de 0,3mm em Z (dentro da folga) | **0,000 mm³** |
| afastar 0,3mm em X (dentro da folga) | **vazio** (o OpenSCAD nem escreve arquivo) |
| degrau de 0,4mm em Z | 28,3 mm³ |
| degrau de 0,5mm em Z | 89,6 mm³ |
| **puxar 1mm pra fora em X** | **139,2 mm³** ← é o T travando |
| empurrar 1mm pra dentro | 1280,6 mm³ (as faces se comendo) |

Os quatro primeiros provam que monta e que o curso inteiro é livre; os quatro
últimos provam que o teste tem dente.

## Por que mão francesa (as contas)

Chapa em balanço presa só pela aba põe todo o momento na junção prato/aba e
todo o arranque no parafuso. Com a perna de 100mm e o parafuso a 88mm da base:

- **Arranque no parafuso**: com carga `P` na borda da frente, a tração no par
  de cima é `P × 100/88 = 1,14 P`. Sem mão francesa (aba de 30mm, parafuso a
  21mm) seria `4,76 P` — a mão francesa **alivia o arranque em 4,2×**. Para
  10 kg na borda da frente dá ~111 N no par, ~56 N por parafuso.
- **Pé das nervuras** (a interface de camada, que é o ponto fraco da
  orientação): as duas bases somam W ≈ 7700 mm³ contra um momento de ~65 P;
  para 10 kg dá ~0,8 MPa contra ~25 MPa de resistência entre camadas do PLA.
- **Prato entre as nervuras**: vão de 100mm, ~2 MPa para 10 kg distribuídos.

Ou seja: **as contas dão folga grande para 10 kg distribuídos por módulo**, e
o elo fraco passa a ser a bucha da parede, não o plástico. Ressalva honesta:
isso é cálculo, não ensaio — a peça **ainda não foi impressa nem testada**.

## Impressão

Sai **de costas**: a face da aba que encosta na parede vai na cama, o prato
sobe em pé e a profundidade vira os 100mm de altura. Nessa orientação **não
existe uma única superfície voltada pra baixo**:

- a diagonal da mão francesa aponta pra **cima**;
- os furos de parafuso e os cones de 90° ficam **verticais** — furo redondo
  perfeito, sem barriga de ponte;
- o perfil do encaixe é extrusão vertical (é por isso que um rebaixo de 90°
  como o T é de graça aqui e seria impensável com a peça deitada);
- os hexágonos da colmeia são furos **horizontais de ponta pra cima** em
  parede vertical — a identidade do repo aqui não é enfeite, é o que faz o
  furo imprimir limpo;
- a primeira camada é a aba inteira, 200 × 100mm de área colada.

O ponto fraco da orientação é a interface de camada na base do prato e das
nervuras — é exatamente o que a mão francesa alivia.

## Colmeia

35 hexágonos de 11mm entre-faces com teia de 4mm e canto arredondado de 1,2mm,
vazando 18,3% da área do prato. Faixa maciça de 16mm nas laterais (protege a
emenda), 14mm junto à parede, 10mm na frente e uma **faixa maciça sobre cada
mão francesa** — por isso o padrão tem duas listras cheias, alinhadas com as
nervuras e com os parafusos. `hex_plate=false` deixa o prato maciço.

Os furos são passantes de propósito: dá pra passar abraçadeira e pendurar
coisa por baixo. Em compensação, **coisa miúda cai** — se for guardar
parafuso solto, use um potinho ou desligue a colmeia.

## Parâmetros

Tudo no topo do [`prateleira-modular-01.scad`](./prateleira-modular-01.scad).
Os que mais importam: `depth` (profundidade), `deck_t`, `aba_down`/`aba_up`,
`rib_reach`, `joint_clear`, `hex_plate`, `with_rail`.

```
flatpak run org.openscad.OpenSCAD -o stl/prateleira-modular-01.stl    -D 'part="modulo"'  prateleira-modular-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/prateleira-modular-01-x1.3mf -D 'part="plate-1"' prateleira-modular-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/prateleira-modular-01-x2.3mf -D 'part="plate"'   prateleira-modular-01.scad
```

## Pendências

- **Profundidade de 100mm é assunção**, não foi medida com régua. Mudar
  `depth` recentraliza tudo sozinho — mas muda a altura de impressão.
- **Cabeça do parafuso não informada**: o rebaixo é um cone de 90° com boca
  Ø9 e 2,2mm de fundo, generoso de propósito pra aceitar chata/escareada
  (afunda rente) e panela (encosta na boca do cone).
- **Bucha/âncora de parede não definida.** Numa prateleira de parede o elo
  fraco quase sempre é ela.
- **Não impressa, não testada na mão.** O teste físico é: imprimir 1 módulo,
  parafusar, carregar; depois imprimir o segundo e conferir se o trilho em T
  entra empurrando com a mão e se a emenda fica sem degrau.
