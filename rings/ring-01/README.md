# ring-01

Anel de **tapete de jogo (playmat)**: abraça o tapete enrolado pra ele não
desenrolar dentro da mochila. **Liso por dentro** — desliza no tecido sem
raspar — e com **colmeia hexagonal em relevo por fora**, a mesma identidade
visual das deckboxes.

Ø50 interno × 50mm de altura. Peça única, imprime em pé, sem suporte.

| | |
|---|---|
| Arquivo para imprimir | [`3mf/ring-01-plate.3mf`](./3mf/ring-01-plate.3mf) |
| Conteúdo | 1 anel em pé |
| Envelope | **58,4 × 58,4 × 50,0 mm** |
| Furo interno | Ø **50 mm** (liso, cilíndrico) |
| Parede estrutural | **3 mm** cheios |
| Relevo da colmeia | 1,2 mm acima da parede |
| Suportes | nenhum |
| Hardware | nenhum |

## Como a textura funciona

A colmeia **não fura a parede**. As células são rebaixadas até a parede lisa e
as linhas da teia (2,4mm de largura) ficam em relevo por cima dela — ou seja,
os 3mm de parede estrutural continuam inteiros e o furo interno segue
perfeitamente cilíndrico. São **18 colunas de células**, número que fecha os
360° exatos, com faixa lisa de pelo menos 6mm em cada borda do anel.

Os hexágonos ficam **de ponta pra cima**: em parede vertical isso imprime sem
ponte reta e sem suporte, que é a razão de a identidade do repo ser essa.

## Parâmetros

Tudo no topo do [`ring-01.scad`](./ring-01.scad): `inner_d` (furo), `height`,
`wall`, `relief`, `hex_cols`, `hex_web` e `edge_band`. Pra um tapete mais
grosso, mexer só em `inner_d` — o resto se recalcula.

```
flatpak run org.openscad.OpenSCAD -o 3mf/ring-01-plate.3mf ring-01.scad
flatpak run org.openscad.OpenSCAD -o stl/ring-01.stl       ring-01.scad
```

## Pendência

Ainda **não foi impresso**. O teste físico é: o tapete enrolado passa e fica
firme sem apertar demais, e a colmeia não marca o tecido.
