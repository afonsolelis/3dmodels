# psa-stand-01

Suporte de mesa pra **uma slab graduada PSA**, inclinada 12° pra trás.
**Uma peça só, aberta em cima**, imprime sem suporte. Mesmo desenho do
[`ars-stand-01`](../ars-stand-01/README.md) e do
[`bgs-stand-01`](../bgs-stand-01/README.md), aprovados no print-review, ainda sem teste físico, só com a
medida da PSA.

## Como funciona

A slab **desce por cima**, entre os dois trilhos, e escorrega até o fundo do
canal. Pra tirar: pinça os **14,5 mm de slab que ficam acima dos trilhos** e
puxa pra cima.

O que segura a slab:

- **atrás — o painel.** A inclinação de 12° joga o peso da slab contra ele. Com
  a slab assentada, o centro de massa dela fica **17,0 mm atrás** da aresta de
  baixo/frente (o ponto em que ela giraria pra tombar pra frente), então ela
  não tomba nem sem aba;
- **na frente — a aba dos trilhos**, que cobre de 1,0 a 2,0 mm de cada borda
  lateral (1,5 com a slab centrada; varia com a folga de 0,5/lado) da face ao
  longo de 120,6 mm de trilho (seguro extra contra esbarrão);
- **dos lados — as paredes dos trilhos**;
- **embaixo — o piso do canal e o lábio da base.**

Pra cima só a gravidade segura — de propósito, é por onde ela sai.

### Etiqueta da PSA

A etiqueta fica no **topo** da slab. Os 14,5 mm de cima saem inteiros acima
dos trilhos e do painel. Abaixo disso, até o lábio da base, a única coisa na
frente da slab é a aba, que toca no máximo **2,0 mm de cada borda lateral**: é a
moldura de plástico da slab, fora da etiqueta. Ela fica livre desde que esteja a
mais de 2 mm das laterais da slab. Na PSA ela fica bem para dentro da moldura,
mas **isso não foi medido com régua**.

> **Conferir na slab real:** o lábio da base cobre **~7,9 mm da parte de baixo
> da face** da slab (medido ao longo da slab, com ela assentada contra o painel).
> Na PSA essa faixa é a moldura de baixo. Se ela esconder a borda da carta, o
> ajuste é `lip_h` (hoje 9).

## Medidas

| | valor |
|---|---|
| **Slab PSA (medida real do usuário, remedida em 2026-10-13)** | **80,1 × 135,1 × 6,1 mm** |
| Vão do canal | 81,1 × 135,6 × 7,1 mm |
| Folga | 0,5/lado na largura e na espessura, 0,5 no comprimento; chanfro de entrada de 1 mm na boca |
| Trilhos e painel | sobem 120,6 mm ao longo da slab; com a slab assentada no piso, 14,5 mm dela ficam livres em cima |
| Suporte | 37,4 × 85,1 × 123,0 mm |
| Montado (com slab assentada) | 37,4 × 85,1 × 136,4 mm |
| Base que apoia na mesa | 29,8 mm de profundidade × 85,1 |
| Inclinação | 12° da vertical |
| Face da slab à vista | 77,1 dos 80,1 mm de largura |
| Lábio da base sobre a face | ~7,9 mm da parte de baixo |
| Painel / parede do trilho / aba | 3 / 2 / 2,5 mm |

A largura de 80,1 é **menor** que as estimativas antigas de slab PSA do repo
(83,6–85,4, tiradas de catálogo e malha de terceiro). Aqui vale a medida do
usuário, que ele confirmou e mediu de novo. Toda a peça é derivada de
`slab_w`/`slab_h`/`slab_t`.

## Verificação feita (2026-10-13)

- **Interferência.** Slab × suporte, interseção calculada no OpenSCAD:
  - **Slab centrada no vão** (0,5 mm de folga em cada face, 0,25 no
    comprimento): interseção **vazia**. A partir do centro, 0,3 mm pra baixo,
    0,6 mm pra frente, 0,6 mm pra trás ou 0,6 mm pra qualquer lado já colide.
    Ou seja, piso, aba, painel e paredes estão onde devem.
  - **Slab assentada** (no piso e encostada no painel, como a gravidade deixa e
    como mostra o `part="check"`): interseção **vazia**. No teste a slab ficou
    afastada **0,001 mm** do piso, do painel e da parede lateral. Encostada
    exatamente, a face dela fica coplanar com a do painel e o CGAL gera um sólido
    degenerado de volume zero, que não diz nada sobre colisão. A folga até a aba é
    **1,0 mm**: 0,95 pra frente passa, 1,05 colide.
  - Puxada 100 mm pra cima: vazia. O canal é prismático e aberto em cima,
    então a slab passa livre no curso inteiro de 120,6 mm de inserção.
- **Balanço real: 0 mm².** Fora os 2538 mm² de apoio na cama, nenhuma face
  virada pra baixo passa de 45°. As faces inclinadas ficam a 12° da vertical. O
  único resíduo é uma lasca numérica de 8·10⁻⁵ mm² no pé do trilho, que não tem
  efeito na impressão.
- **Estabilidade.** A slab é fina (6,1 mm), por isso conferi o seguinte:
  - **CG atrás do pivô:** com a slab assentada, o CG dela fica 17,0 mm atrás da
    aresta de baixo/frente, então ela não tomba pra frente.
  - **Tombamento do conjunto:** o CG do suporte fica em x = 10,9 e o da slab
    em x = 11,1, com a base apoiando de x = −9,4 a +28,0. Isso dá
    **~17 mm de margem pra trás e ~20 pra frente**. É melhor que o ars-stand-01
    (~11 pra trás), porque a slab fina fica mais perto do painel.
  - **Rigidez dos trilhos:** a seção em U (painel + 2 trilhos) tem
    I ≈ 2600 mm⁴ na flexão frente/trás, ~48% do ars-stand-01, porque o trilho é
    mais raso (9,6 mm contra 13,3). Com 2 N no topo, a flecha estimada é de
    ~0,1 mm, irrelevante. Na direção que importa pra segurar a slab (a parede do
    trilho abrindo pro lado), o trilho mais curto é **~2,7× mais rígido** que o
    do ars-stand-01, porque a rigidez escala com 1/L³.
- `Volumes: 2` (sólido único). Bed-check AD5X: 37,4 × 85,1 × 123,0 → **ok**.
  O 3MF tem 1 objeto com o mesmo bbox.

## Arquivos

- `psa-stand-01.scad`: fonte paramétrico
- `stl/psa-stand-01-stand.stl`
- `3mf/psa-stand-01.3mf`: job único, com a peça já em pé na orientação de impressão

## Como gerar

```sh
openscad -o <abs>/stl/psa-stand-01-stand.stl -D 'part="stand"' <abs>/psa-stand-01.scad
openscad -o <abs>/3mf/psa-stand-01.3mf       -D 'part="stand"' <abs>/psa-stand-01.scad
```

Use caminhos absolutos. Nesta máquina Windows o binário é
`C:/Program Files/OpenSCAD/openscad.com`; no Linux, `flatpak run org.openscad.OpenSCAD`.
`part="check"` mostra o suporte com a slab fantasma assentada, pra conferir o encaixe.

## Impressão

- **Sem suporte; brim opcional recomendado.** São 123 mm de altura numa base de
  29,8 mm de profundidade. Base na mesa e painel pra cima, como o 3MF já sai.
  ~74 g a 100%, menos com infill.
- Se a slab ficar dura ou frouxa no canal, o ajuste é `fit_w`/`fit_t`
  (0,5 por lado hoje).
