# Jogos

Jogos de mesa e componentes paramétricos, modelados para impressão 3D.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [xadrez-01](./xadrez-01/) | 🚧 em andamento | xadrez compacto completo: tabuleiro bicolor de 168mm e 32 peças Staunton simplificadas. **Três jobs** desde 28/08/2026 (tabuleiro bicolor 168×168×3,6 + dois exércitos de 16 peças 4×4, 76,2×73,6×46 cada, uma cor por job — zero purga nas peças). Dama subiu pra 41mm (era mais baixa que o bispo) e o chanfro da base foi pra 45°. Falta fatiar e imprimir |

## Convenção da pasta

Cada modelo tem `<modelo>.scad` como fonte paramétrica, `3mf/` com a placa
pronta para o fatiador e `stl/` com os corpos de cor e as peças individuais de
reposição. As medidas e notas principais também ficam no
[`index.json`](../index.json).
