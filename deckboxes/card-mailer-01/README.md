# Card mailer 01

Três estojos rígidos internos para envio, cada um com base e tampa solta para lacrar com fita. Usar **dentro de caixa externa de papelão com amortecimento**. Ainda sem teste físico de encaixe ou transporte.

| Job | Conteúdo de referência (mm) | Estojo fechado (mm) |
|---|---|---|
| [cards3.3mf](3mf/cards3.3mf) | 3 cards com sleeves: 68 × 93 × 2,25 | 79,8 × 104,8 × 10,05 |
| [cards10.3mf](3mf/cards10.3mf) | 10 cards com sleeves: 68 × 93 × 7,5 | 79,8 × 104,8 × 15,3 |
| [bgs.3mf](3mf/bgs.3mf) | 1 slab Beckett BGS: 82,5 × 130,2 × 8,5 | 94,3 × 142 × 16,3 |

Os sleeves reutilizam os 68 × 93 mm reais do `deckbox-03`. Espessuras de pilha são **estimativas**, 45 mm / 60 cards × quantidade; a compressão e o tipo de sleeve podem mudar o resultado. A slab usa a medida real do `bgs-stand-01`. Não é um encaixe universal de graduados nem foi dimensionado para toploaders.

Cada arquivo contém base e tampa na posição de impressão: ambas de boca para cima, teto da tampa apoiado na mesa. Selecionar perfil FlashForge AD5X, bico 0,4 mm; sugestão inicial: camada 0,2 mm, 4 perímetros e 6 camadas superiores/inferiores. Sem suportes. Os 3MF são geometria, sem perfil de fatiamento embutido.

## Embalar e abrir

1. Colocar fita macia de tecido (cerca de 10 mm de largura e 180 mm de comprimento nos sleeves, 210 mm na BGS; espessura até 0,2 mm) atravessando o fundo, deixando duas pontas para levantar o conjunto. Nada de adesivo tocando os sleeves.
2. Colocar forro macio não abrasivo de **1 mm**, cortado a 69 × 94 mm nos sleeves ou 83,5 × 131,2 mm na BGS. Não colar nas cartas.
3. Colocar o conteúdo deitado e outro forro de 1 mm por cima; dobrar as pontas da fita para dentro. Há 1 mm adicional em altura para fita e folga. Ajustar forro se o conjunto ficar solto, sem comprimir ou curvar cards.
4. A tampa assenta no aro da base, sem pressionar o conteúdo dimensionado. Tem folga de 0,5 mm por lado, chanfro de entrada de 0,6 mm e **não trava sozinha**. Lacrar com fita adesiva em dois sentidos, envolvendo base e tampa.
5. Proteger o estojo com amortecimento e acondicionar em papelão. O estojo não é estanque e não substitui a embalagem externa.
6. Para abrir, remover o lacre, segurar os 3 mm expostos da base, levantar a tampa e usar ambas as pontas da fita para erguer o conteúdo plano.

Faces sólidas e lisas preservam a proteção e a área de adesão do lacre; sem vazados, ímãs ou peças pequenas. Fundo, teto e paredes da base têm 2,4 mm, saia da tampa 2 mm. Alterar `variant` no SCAD para `cards3`, `cards10` ou `bgs`; pela CLI usar a variável final, não `_override`.
