# Jogos

Jogos de mesa e componentes paramétricos, modelados para impressão 3D.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [xadrez-01](./xadrez-01/) | ⛔ bloqueado (não cabe na AD5X) | xadrez compacto completo: tabuleiro bicolor e 32 peças Staunton simplificadas. A placa única tem 248,2mm em Y contra os 220 da cama — foi feita para a Creality K2 (260). Precisa relayout em 2 jobs |

## Convenção da pasta

Cada modelo tem `<modelo>.scad` como fonte paramétrica, `3mf/` com a placa
pronta para o fatiador e `stl/` com os corpos de cor e as peças individuais de
reposição. As medidas e notas principais também ficam no
[`index.json`](../index.json).
