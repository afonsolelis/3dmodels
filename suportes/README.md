# Suportes

Suportes e apoios de mesa (controles, aparelhos, acessórios), modelados em
OpenSCAD e impressos na FlashForge AD5X.

> Suportes de **cartas graduadas** (slabs PSA/BGS) ficam em
> [`../organizadores_tcg/`](../organizadores_tcg/), junto com o resto do TCG.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [xbox-stand-01](./xbox-stand-01/) | 🚧 em andamento | suporte de mesa pra **controle de Xbox (Series X/S)**, versão **maciça** — bloco liso de 60 × 170 × 25mm de **topo abaulado** (abóbada R230, sem plano chapado nem aresta reta), **sem aletas e sem colmeia**, com dois berços em vale (boca 42 × 36, mergulho 21,5mm) a **124mm entre centros**, onde caem os dois punhos. Como a retenção é **100% profundidade de encaixe**, o bolso é copiado da malha de referência em **duas** tabelas medidas — o **vão** por altura (perfil z ∝ largura^2,5) e o **centro** por altura (erro ≤ 0,26mm), que é o que faz o punho encaixar **~17 a 20mm** abaixo da boca em vez de empoleirar (é faixa, não número: as fendas das aletas da malha de referência caem em cima da parede que trava, então ela não é amostrada entre z=12 e z=24). Peça única, **zero balanço medido** (0,00mm², sem suporte). **2 jobs: imprimir o GABARITO primeiro** (fatia de cima com **os dois berços**, 170 × 60 × 13, ~4,5–5,5h — teste de um berço só dá **+11mm de falso positivo**) e só depois a chapa cheia (170 × 60 × 25, ~8–9,5h, ~68g). **Feito pra TPU 95A a 15% de infill** — "maciço" é a FORMA, a maciez vem do fatiador. Remodelado do zero a partir dos NÚMEROS de um 3MF de terceiro (Pork3D, não redistribuível), sem reuso de malha. ⚠️ Medidas do controle vêm da malha de referência, não de paquímetro |

## Convenção da pasta

Cada modelo tem `<modelo>.scad` (fonte paramétrico), `3mf/` (só os jobs de
impressão, já na orientação certa) e `stl/` (peças individuais, referência).
Os números-chave de cada um estão no [`index.json`](../index.json) da raiz.
