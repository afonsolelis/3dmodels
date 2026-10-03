# switch-lite-stand-01

Suporte de mesa tipo **bainha** pra **Nintendo Switch Lite COM capa protetora**:
bloco maciço em pé, com slot central onde o console desce de pé **em qualquer
das 4 orientações** (tela pra frente ou pra trás, borda de cima ou de baixo
primeiro), rebaixo pra dedo no meio do topo, 2 bolsos de cartucho na parede de
trás e 2 bolsos estreitos na parede da frente (caneta, ponta de cabo, fone
pequeno). **Peça única**, sem montagem, sem ferragem, **sem suporte de
impressão**, **PLA, sem brim**. Refeito do zero em OpenSCAD a partir dos
NÚMEROS de um 3MF de terceiro
([`../terceiros/nintendo-switch-lite-sleeve/`](../terceiros/nintendo-switch-lite-sleeve/README.md),
autor desconhecido) — nenhum triângulo da malha foi reaproveitado.

| | |
|---|---|
| Bloco | **220 × 78,2 × 97 mm** (comprimento × profundidade × altura), piso 5, arestas verticais **R3** |
| Console-com-capa | **210 × 93 × 16** ⚠️ ASSUMIDO (+2 mm por eixo sobre o Switch Lite nu 208 × 91 × 14), **não medido com régua** |
| Slot | **212 × 35**, 92 de fundo (o console sobra 1 mm acima do topo), chanfro de 1,2 na boca |
| Nervuras de guia | **8** (x = ±20 e ±40, nas duas paredes), **8 mm altas × 8 largas**, rampa de entrada a 45° — o corpo roda num **canal de 19** (1,5 mm/lado); fora da nervura a face do console fica a **9,5 mm** da parede centrado e a **8 mm no pior caso** (corpo encostado na nervura) → stick ~7 + **1,0 de folga** |
| Paredes | ponta **4** · frente **17,5** (3 + bolso 12 + 2,5) · trás **25,7** (3 + bolso 20,2 + 2,5) |
| Rebaixo pra dedo | U de **26 × 26** no centro, atravessa as duas paredes → **27 mm de console à mostra** pra pinçar |
| Bolsos de cartucho | 2 (trás, a 8 mm da ponta): **22 × 20,2**, **17 de fundo**, **pinça semicircular R8** (Ø16, quase a pilha inteira) nas duas paredes X, 4 mm de parede até a ponta — **6 cartuchos de pé** por bolso (31 × 21 × 3,2 + 0,5/lado), sobram **14 mm pra fora** |
| Bolsos estreitos | 2 (frente, nas pontas): **20 × 12**, 50 de fundo (caneta Ø8–11 com folga) |
| Colmeia | hexágonos de ponta pra cima, 8 mm entre faces, nervura 2, **baixo-relevo de 1 mm** nas 4 faces verticais (nas pontas só até z = 44); faixa sólida de 3 mm; **parede mínima atrás de hexágono 3 mm** (pontas) |
| Job | `3mf/switch-lite-stand-01-plate.3mf` — 1 peça, **girada 45°** na chapa: footprint **208,4 × 208,4 × 97** (cantos R3 incluídos; bate com o bbox do STL) |
| Material | **PLA**, ~15 % de infill → **~377 g** (1161 g se maciça; volume da malha 936 cm³ — o echo do `.scad` é estimativa analítica ~2 % abaixo) |
| Suporte / brim | **nenhum / nenhum** — tudo abre pra cima; base plana de 172 cm² com cantos R3 |

## Por que o slot tem 35 mm e nervuras

O Switch Lite não é uma placa lisa: os dois **analógicos** saem ~7 mm acima
da capa (a capa não cobre o stick) e os gatilhos **ZL/ZR** saem ~4 mm na face
de trás, nos cantos da borda de cima. Num slot plano de 18 (1ª versão, e
também a referência de terceiro) o console desce ~20 mm e **senta num stick**.

Aqui o slot abre pra 35 e o **corpo** é guiado por nervuras de 8 mm nas duas
paredes, só na faixa central |x| ≤ 50 onde o console é liso dos dois lados.
Entre nervuras opostas sobra um canal de 19; fora delas a face do console
fica a 9,5 mm da parede centrado — e a **8 mm no pior caso**, com o corpo
encostado na nervura do lado da tela (é esse o número que vale: 7 do stick
+ 1,0 de folga). Com nervura dos dois lados o corpo fica **centrado** —
por isso cada parede precisa de `stick_h + folga` (nervura de 3,5 num slot
de 25 centraria o corpo a 4,5 da parede e o stick de 7 bateria igual).

O `.scad` **simula as 4 orientações de entrada** e ecoa, pra cada stick,
ZL/ZR e bloco de botões, a posição z com o console no fundo, se cruza
nervura e a folga local **no pior caso** (corpo encostado na nervura do lado
da saliência); só imprime `CURSO OK` se tudo passar (passa: folga 1,0 nos
sticks, 4 nos ZL/ZR, 7 nos botões; nenhum cruza nervura).

## Como usar

O bloco fica deitado na mesa com os 220 mm de frente pra quem senta: a face
da frente é a dos bolsos estreitos, a de trás é a dos cartuchos. O console
entra **de cima, de pé**, de preferência **borda de BAIXO primeiro** (ali só
tem USB-C e P2, rebaixados); borda de cima primeiro também cabe, mas aí o
console apoia em power/volume/L/R. Tela pra frente ou pra trás, tanto faz. As
rampas das nervuras afunilam o corpo pro canal de 19 e ele desce até o piso. Só a gravidade e as
nervuras seguram (não tem trava). Pra tirar, pinça no rebaixo central
(27 mm de console exposto) e puxa pra cima.

Os cartuchos ficam **de pé, como livros**: a face de 21 mm ao longo do
comprimento do bloco, a espessura ao longo da profundidade, 6 por bolso.
Com 17 mm de fundo sobram 14 mm pra fora, e as pinças R8 nos dois lados
(Ø16, quase a pilha inteira de 19,2) deixam pegar o cartucho pela borda
estreita.

## Impressão

- Abrir `3mf/switch-lite-stand-01-plate.3mf` no Flash Studio. A peça **já vem
  girada 45°** porque os 220 mm de comprimento são a cama inteira da AD5X
  (reta, ela dá "justo" no bed-check: 220 × 78,2). **Não girar de volta.**
- **PLA**, 0,2 mm, ~15 % de infill, 3 paredes, **sem suporte, sem brim**
  (pedido do usuário): **mesa 60 °C, PEI limpo, 1ª camada lenta**. Os cantos
  verticais R3 ajudam o canto a não levantar; **se um canto soltar, brim
  externo de 5 mm**.
- Nada vira pra baixo: o fundo do U é côncavo pra cima, as rampas das
  nervuras são a 45° viradas pra cima, as pinças R8 são verticais e os
  hexágonos têm 1 mm de relevo com teto a 30°.

## Pendências (⚠️ medidas estimadas)

- **Console com a capa**: medir com paquímetro a **espessura total com capa
  no CENTRO do console** (sobre o lábio da capa em volta da tela e nas
  costas), **não no vidro** — esse valor vira `content_t` (hoje 16); medir
  também comprimento e altura (`content_l`, `content_h`, hoje 210 × 93).
  **A capa não pode ter kickstand/grip na faixa central de 88 mm (|x| ≤ 44)**,
  senão não passa no canal das nervuras.
- **Faltam 3 medidas do console** (hoje são estimativas): (1) **espessura
  total no stick, com a capa** → `stick_h` = essa medida − `content_t`
  (hoje 7); (2) **distância das bordas até o centro dos caps** → define a
  zona livre de nervura (`rib_zone_half`, hoje 50; caps estimados em
  x = ±82); (3) **saliência real dos ZL/ZR** (`zlzr_h`, hoje 4). O slot e as
  nervuras recalculam sozinhos e o echo `CURSO` precisa continuar `OK`.
- Cartucho por catálogo (31 × 21 × 3; 3,2 com etiqueta) com 0,5 mm de folga
  por lado — conferir no teste físico se os 6 entram e saem.
- Se precisar de mais margem na cama (hoje 208,4 na diagonal),
  `cart_count = 5` tira 3,2 mm da profundidade.

## Export

```
D=/home/afonsolelis/repos/3dmodels/suportes/switch-lite-stand-01
flatpak run org.openscad.OpenSCAD -o $D/stl/switch-lite-stand-01-stand.stl -D 'part="stand"' $D/switch-lite-stand-01.scad
flatpak run org.openscad.OpenSCAD -o $D/3mf/switch-lite-stand-01-plate.3mf -D 'part="plate"' $D/switch-lite-stand-01.scad
```
