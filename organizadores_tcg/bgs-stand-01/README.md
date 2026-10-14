# bgs-stand-01

Suporte de mesa pra **uma slab graduada Beckett (BGS)**, inclinada 12° pra trás.
**Uma peça só, aberta em cima**, imprime sem suporte.

## Como funciona

A slab **desce por cima**, entre os dois trilhos, e escorrega até o fundo do
canal. Pra tirar: pinça os **14,5 mm de slab que ficam acima dos trilhos** e puxa
pra cima.

O que segura a slab:

- **atrás — o painel.** A inclinação de 12° joga o peso da slab contra ele. O
  centro de massa da slab fica **17,8 mm atrás** da aresta de baixo/frente
  dela (o ponto em que ela giraria pra tombar pra frente), então ela não tomba
  nem sem aba;
- **na frente — a aba dos trilhos**, que cobre de 1,0 a 2,0 mm de cada borda lateral (1,5 com a slab centrada; varia com a folga de 0,5/lado) da
  face ao longo de 115,8 mm de trilho (seguro extra contra esbarrão);
- **dos lados — as paredes dos trilhos**;
- **embaixo — o piso do canal e o lábio da base.**

Pra cima só a gravidade segura — de propósito, é por onde ela sai.

## Medidas

| | valor |
|---|---|
| **Slab (medida real do usuário, 2026-10-13)** | **82,8 × 130,3 × 8,8 mm** |
| Medida anterior (paquímetro, 2026-08-11) | 82,5 × 130,2 × 8,5 mm |
| Vão do canal | 83,8 × 130,8 × 9,8 mm |
| Folga | 0,5/lado na largura e na espessura, 0,5 no comprimento; chanfro de entrada de 1 mm na boca |
| Trilhos e painel | sobem 115,8 mm ao longo da slab; com a slab assentada no piso, 14,5 mm dela ficam livres em cima |
| Suporte | 39,0 × 87,8 × 118,8 mm |
| Montado (com slab assentada) | 39,0 × 87,8 × 132,3 mm |
| Lábio da base sobre a face | cobre ~7,3 mm da parte de baixo da face da slab (conferir na slab real que não pega nada importante) |
| Base que apoia na mesa | 32,5 mm de profundidade × 87,8 |
| Inclinação | 12° da vertical |
| Face da slab à vista | 79,8 dos 82,8 mm de largura |
| Painel / parede do trilho / aba | 3 / 2 / 2,5 mm |

Toda a peça é derivada de `slab_w`/`slab_h`/`slab_t`. Pra outra marca (PSA, CGC),
medir e trocar só esses três números.

## Verificação feita (2026-10-13)

- **Interferência** (testada com a slab **centrada no vão**: 0,5 mm de folga
  em cada face): slab × suporte = interseção **vazia**, e deslocando 0,3 mm pra
  baixo, 0,6 mm pra frente ou 0,6 mm pro lado já colide — piso, aba e parede
  estão onde devem. Esses deslocamentos valem a partir do centro: com a slab
  ASSENTADA contra o painel (como no `part="check"`), a folga até a aba é 1,0 mm.
  O canal é prismático, então vazio numa posição = vazio no curso inteiro de
  115,8 mm de inserção.
- **Balanço real: 0 mm².** A única área virada pra baixo são os 2850 mm² de
  apoio na cama. O pé dos trilhos afunda 1 mm na base pra fundir de verdade
  (com o pé exatamente no plano do piso sobrava uma lasca de 0,00001 mm).
- **Tombamento**: centro de massa do suporte em x=9,9 e da slab em x=8,8, base
  apoiando de x=−12,0 a +20,4 → ~11 mm de margem pra trás, ~21 pra frente.
- `Volumes: 2` (sólido único). Bed-check AD5X: 39,0 × 87,8 × 118,8 → **ok**.

## Arquivos

- `bgs-stand-01.scad` — fonte paramétrico
- `stl/bgs-stand-01-stand.stl`
- `3mf/bgs-stand-01.3mf` — job único, peça já em pé na orientação de impressão

## Como gerar

```sh
openscad -o <abs>/stl/bgs-stand-01-stand.stl -D 'part="stand"' <abs>/bgs-stand-01.scad
openscad -o <abs>/3mf/bgs-stand-01.3mf       -D 'part="stand"' <abs>/bgs-stand-01.scad
```

Caminhos absolutos. Nesta máquina Windows o binário é
`C:/Program Files/OpenSCAD/openscad.com`; no Linux, `flatpak run org.openscad.OpenSCAD`.
`part="check"` mostra o suporte com a slab fantasma, pra conferir o encaixe.

## Impressão

- **Sem suporte; brim opcional recomendado** (118,8 mm de altura numa base de
  32,5 mm de profundidade). Base na mesa, painel pra cima — como o 3MF já sai.
- Se a slab ficar dura ou frouxa no canal, o ajuste é `fit_w`/`fit_t`
  (0,5 por lado hoje).

## Histórico

- 2026-08-11: primeira versão com medida de paquímetro (82,5 × 130,2 × 8,5) e
  uma peça de cima removível que fechava acima da slab.
- 2026-10-13: slab remedida (82,8 × 130,3 × 8,8) e a peça de cima saiu — o
  suporte ficou aberto em cima, como o modelo de referência pedido pelo
  usuário. Folga do canal de 0,4 → 0,5/lado (padrão de deslize longo do repo)
  e chanfro de entrada.

## Origem

Conceito medido na malha do [suporte de slab PSA/CGC de terceiro](../terceiros/display-stand-for-psa-cgc-slab/README.md)
(Functional3D, MakerWorld, Standard Digital File License — arquivo de terceiro,
**não redistribuir**). De lá vieram só os números de referência: inclinação
11,9°, canal de 81,0 mm, painel de ~3 mm. A geometria daqui é toda nova.

## Próximas iterações (ideias)

- Colmeia hexagonal vazada no painel (identidade do repo; hoje é liso de
  propósito, pra servir de fundo pra slab)
- Versão de 2-3 slabs lado a lado, compartilhando base
- Rebaixo pra ímã na base, pra prender numa chapa metálica
