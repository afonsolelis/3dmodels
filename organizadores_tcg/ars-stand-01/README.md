# ars-stand-01

Suporte de mesa pra **uma slab graduada ARS**, inclinada 12° pra trás.
**Uma peça só, aberta em cima**, imprime sem suporte. Mesmo desenho do
[`bgs-stand-01`](../bgs-stand-01/README.md), só com a medida da ARS.

## Como funciona

A slab **desce por cima**, entre os dois trilhos, e escorrega até o fundo do
canal. Pra tirar: pinça os **14,5 mm de slab que ficam acima dos trilhos** e
puxa pra cima.

O que segura a slab:

- **atrás — o painel.** A inclinação de 12° joga o peso da slab contra ele. O
  centro de massa da slab fica **18,4 mm atrás** da aresta de baixo/frente
  dela (o ponto em que ela giraria pra tombar pra frente), então ela não tomba
  nem sem aba;
- **na frente — a aba dos trilhos**, que cobre de 1,0 a 2,0 mm de cada borda lateral (1,5 com a slab centrada; varia com a folga de 0,5/lado) da
  face ao longo de 116,5 mm de trilho (seguro extra contra esbarrão);
- **dos lados — as paredes dos trilhos**;
- **embaixo — o piso do canal e o lábio da base.**

Pra cima só a gravidade segura — de propósito, é por onde ela sai.

> **Conferir na slab real:** o lábio da base cobre **~7,1 mm da parte de baixo
> da face** da slab (medido ao longo da slab, com ela assentada contra o
> painel). Se a ARS tiver algo importante nessa faixa, o ajuste é `lip_h`.

## Medidas

| | valor |
|---|---|
| **Slab ARS (medida real do usuário, 2026-10-13)** | **84 × 131 × 9,8 mm** |
| Vão do canal | 85,0 × 131,5 × 10,8 mm |
| Folga | 0,5/lado na largura e na espessura, 0,5 no comprimento; chanfro de entrada de 1 mm na boca |
| Trilhos e painel | sobem 116,5 mm ao longo da slab; com a slab assentada no piso, 14,5 mm dela ficam livres em cima |
| Suporte | 40,2 × 89,0 × 119,7 mm |
| Montado (com slab assentada) | 40,2 × 89,0 × 133,2 mm |
| Base que apoia na mesa | 33,4 mm de profundidade × 89,0 |
| Inclinação | 12° da vertical |
| Face da slab à vista | 81,0 dos 84 mm de largura |
| Lábio da base sobre a face | ~7,1 mm da parte de baixo |
| Painel / parede do trilho / aba | 3 / 2 / 2,5 mm |

Toda a peça é derivada de `slab_w`/`slab_h`/`slab_t`.

## Verificação feita (2026-10-13)

- **Interferência** (testada com a slab **centrada no vão**: 0,5 mm de folga
  em cada face): slab × suporte = interseção **vazia**, e deslocando 0,3 mm pra
  baixo, 0,6 mm pra frente ou 0,6 mm pro lado já colide — piso, aba e parede
  estão onde devem. Esses deslocamentos valem a partir do centro: com a slab
  ASSENTADA contra o painel (como no `part="check"`), a folga até a aba é 1,0 mm.
  O canal é prismático, então vazio numa posição = vazio no curso inteiro de
  116,5 mm de inserção.
- **Balanço real: 0 mm².** A única área virada pra baixo são os 2976 mm² de
  apoio na cama.
- **Tombamento**: centro de massa do suporte em x=9,7 e da slab em x=8,8, base
  apoiando de x=−13,0 a +20,4 → ~11 mm de margem pra trás, ~22 pra frente.
- `Volumes: 2` (sólido único). Bed-check AD5X: 40,2 × 89,0 × 119,7 → **ok**.

## Arquivos

- `ars-stand-01.scad` — fonte paramétrico
- `stl/ars-stand-01-stand.stl`
- `3mf/ars-stand-01.3mf` — job único, peça já em pé na orientação de impressão

## Como gerar

```sh
openscad -o <abs>/stl/ars-stand-01-stand.stl -D 'part="stand"' <abs>/ars-stand-01.scad
openscad -o <abs>/3mf/ars-stand-01.3mf       -D 'part="stand"' <abs>/ars-stand-01.scad
```

Caminhos absolutos. Nesta máquina Windows o binário é
`C:/Program Files/OpenSCAD/openscad.com`; no Linux, `flatpak run org.openscad.OpenSCAD`.
`part="check"` mostra o suporte com a slab fantasma, pra conferir o encaixe.

## Impressão

- **Sem suporte; brim opcional recomendado** (119,7 mm de altura numa base de
  33,4 mm de profundidade). Base na mesa, painel pra cima — como o 3MF já sai.
- Se a slab ficar dura ou frouxa no canal, o ajuste é `fit_w`/`fit_t`
  (0,5 por lado hoje).
