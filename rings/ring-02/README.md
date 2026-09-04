# ring-02

Anel de playmat **"cristal torcido"** — o irmão invocado do
[`ring-01`](../ring-01/). Mesmo furo cilíndrico liso Ø50 por dentro; por fora,
a identidade hexagonal do repo promovida de textura a **silhueta**: um prisma
hexagonal com **torção espelhada** (+30° na metade de baixo, −30° na de cima)
que forma uma **cintura de 6 chevrons** no meio, como uma pedra lapidada.

Peça única, imprime em pé, sem suporte.

| | |
|---|---|
| Arquivo para imprimir | [`3mf/ring-02-plate.3mf`](./3mf/ring-02-plate.3mf) |
| Conteúdo | 1 anel em pé |
| Envelope | **64,7 × 64,7 × 50,0 mm** |
| Furo interno | Ø **50 mm** (liso, com chanfro de 45°) |
| Parede mínima | **3 mm** (do furo ao meio de cada face) |
| Torção | **30°** por metade, espelhada |
| Suportes | nenhum |
| Hardware | nenhum |

## Por que 30° e por que imprime sem suporte

A hélice dos cantos inclina `atan(vertex_r · twist / meia-altura)` ≈ **34° da
vertical** — abaixo dos 45° em que o teto começaria a pedir suporte. Acima de
`twist ≈ 45` a peça passa a precisar de apoio, então 30 é escolha de projeto,
não estética solta.

Com 30° os cantos da cintura caem **exatos no meio das faces das bocas**, e as
duas bocas ficam alinhadas entre si — o anel apoia em pé e **empilha**. Canto
de hexágono é rombudo (120°), então não rasga o tecido da mochila. As duas
bocas do furo têm **chanfro de 45° (1,2mm)** pra guiar o tapete na hora de
vestir.

## Parâmetros

No topo do [`ring-02.scad`](./ring-02.scad): `inner_d`, `height`, `wall`,
`twist`, `chamfer` e `slices` (suavidade da hélice).

```
flatpak run org.openscad.OpenSCAD -o 3mf/ring-02-plate.3mf ring-02.scad
flatpak run org.openscad.OpenSCAD -o stl/ring-02.stl       ring-02.scad
```

## Pendência

Ainda **não foi impresso**. Teste físico: encaixe no tapete e se a cintura
torcida sai limpa sem suporte na AD5X.
