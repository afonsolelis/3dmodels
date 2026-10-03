# Suportes

Suportes e apoios de mesa (controles, aparelhos, acessórios), modelados em
OpenSCAD e impressos na FlashForge AD5X.

> Suportes de **cartas graduadas** (slabs PSA/BGS) ficam em
> [`../organizadores_tcg/`](../organizadores_tcg/), junto com o resto do TCG.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [xbox-stand-01](./xbox-stand-01/) | 🚧 em andamento | suporte de mesa pra **controle de Xbox (Series X/S)**, versão **maciça** — bloco liso de 60 × 170 × 25mm de **topo abaulado** (abóbada R230, sem plano chapado nem aresta reta), **sem aletas e sem colmeia**, com dois berços em vale (boca 42 × 36, mergulho 21,5mm) a **124mm entre centros**, onde caem os dois punhos. Como a retenção é **100% profundidade de encaixe**, o bolso é copiado da malha de referência em **duas** tabelas medidas — o **vão** por altura (perfil z ∝ largura^2,5) e o **centro** por altura (erro ≤ 0,26mm), que é o que faz o punho encaixar **~17 a 20mm** abaixo da boca em vez de empoleirar (é faixa, não número: as fendas das aletas da malha de referência caem em cima da parede que trava, então ela não é amostrada entre z=12 e z=24). Peça única, **zero balanço medido** (0,00mm², sem suporte). **2 jobs: imprimir o GABARITO primeiro** (fatia de cima com **os dois berços**, 170 × 60 × 13, ~4,5–5,5h — teste de um berço só dá **+11mm de falso positivo**) e só depois a chapa cheia (170 × 60 × 25, ~8–9,5h, ~68g). **Feito pra TPU 95A a 15% de infill** — "maciço" é a FORMA, a maciez vem do fatiador. Remodelado do zero a partir dos NÚMEROS de um 3MF de terceiro (Pork3D, não redistribuível), sem reuso de malha. ⚠️ Medidas do controle vêm da malha de referência, não de paquímetro |
| [switch-lite-stand-01](./switch-lite-stand-01/) | 🚧 em andamento | suporte de mesa tipo **bainha** pra **Nintendo Switch Lite COM capa**: bloco maciço de 220 × 78,2 × 97 em pé (arestas verticais R3), slot central de 212 × **35** × 92 onde o corpo do console é guiado por **8 nervuras de 8 mm** (x = ±20/±40, nas duas paredes, rampa a 45°) num canal de 19 — fora das nervuras sobram 9,5 mm (8 no pior caso) pros **analógicos (~7 mm) e ZL/ZR (~4 mm)** em **qualquer das 4 orientações de entrada** (simulado no pior caso e ecoado `CURSO OK` no .scad; principal: borda de baixo primeiro). Rebaixo pra dedo em U de 26 × 26 (27 mm de console à mostra), 2 bolsos de cartucho atrás (22 × 20,2 × 17, a 8 da ponta, pinça R8 nos dois lados — **6 cartuchos de pé** por bolso, 14 mm pra fora) e 2 bolsos estreitos na frente (20 × 12 × 50, caneta/ponta de cabo/fone pequeno). Colmeia de ponta pra cima em baixo-relevo de 1 mm nas 4 faces. Peça única, **PLA, sem suporte, sem brim**, ~377 g a 15 %. Job único **girado 45°** na chapa (208,4 × 208,4). Refeito do zero a partir dos NÚMEROS de um 3MF de terceiro (autor desconhecido, que tem o defeito do slot plano). ⚠️ Console-com-capa 210 × 93 × 16 **assumido** e stick/ZL-ZR **estimados** — faltam 3 medidas (ver README) |

## Convenção da pasta

Cada modelo tem `<modelo>.scad` (fonte paramétrico), `3mf/` (só os jobs de
impressão, já na orientação certa) e `stl/` (peças individuais, referência).
Os números-chave de cada um estão no [`index.json`](../index.json) da raiz.

## Downloads de terceiros

Veja o [catálogo visual dos 18 arquivos](terceiros/README.md). Cada item registra origem, licença, nome anterior e prévia quando disponível.
