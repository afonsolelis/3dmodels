# sleeve-tower-01

Torre de **penny sleeves deitados**: bandeja aberta em cima, **75 × 102.5 × 150mm**,
três paredes **maciças** de 3mm (duas laterais + fundo), a frente aberta num **sulco
vertical de 50mm** que vai do piso ao topo, ladeado por **duas abas em L** que
seguram a pilha. Piso de 10mm que é lastro e, embaixo dele, um **ressalto de
empilhamento**. Peça única, imprime **em pé, na orientação de uso, sem suporte**.

É a variante ALTA do
[`../../organizadores_tcg/PennySleeveHolderStacking_V2.3mf`](../../organizadores_tcg/)
(Sazabi, MakerWorld, MakerWorld Exclusive License — **arquivo de terceiro, não
redistribuível**; serviu só de referência de geometria, este `.scad` é
reconstrução paramétrica própria e nada da malha foi copiado).

## Como se manuseia

1. Fica **de pé** na mesa, sulco virado pra você. O sleeve entra **deitado** (66
   no X, 91 no Y) e a pilha cresce em Z: **140mm de curso**, do piso (z=10) à
   boca (z=150).
2. **Abastecer** pela boca, aberta e livre nos 69.0 × 99.5 inteiros.
3. **Tirar** pelo sulco: dois dedos nos 50mm de vão, pinça e puxa. O sleeve tem
   ~66.7 de largura e o sulco tem 50 — ele sai **arqueando entre as abas**, e é
   justamente isso que impede a pilha inteira de vir junto.
4. **Empilhar**: a de cima desce na boca da de baixo, ressalto de 3mm com
   0.4/lado, e assenta no aro.

> ### ⚠️ Sleeve VAZIO x carta JÁ ENSLEEVADA
> O sulco tem 50.0mm e o conteúdo tem ~66.7 de largura: **8.35mm de mordida em
> cada aba**.
> - **Sleeve vazio** (filme mole): sai pelo sulco arqueando, sem esforço. É pra
>   isso que a peça existe e é o que a referência faz.
> - **Carta já enseleevada** (rígida, não dobra): **não passa pelo sulco.** Sai
>   pela boca, por cima. O sulco vira janela de ver o nível da pilha.
>
> Nenhuma das duas é defeito, mas é bom saber qual você tem antes de encher.
> Quem quiser a carta enseleevada saindo pela frente precisa de
> `open_frac_override = 0.93` (sulco de ~70) e aí perde a aba.

## O que veio da referência, e o que mudou

Medido na malha da variante Stackable (`3D/Objects/object_1.model`, 296 vértices):
externo **73.0 × 101.5 × 45.0**, parede 2.0, cavidade **69.0 × 99.5**, piso 10.0,
ressalto z 0..3 de 68.6 × 99.3 (0.2/lado), abas em L de 3.5mm de fundura, sulco
de **50.0 na cara da peça** (68.5% dos 73.0), quinas em r ≈ 1.0.

| # | Mudança | Por quê |
|---|---|---|
| 1 | Altura **45 → 150** | pedido do usuário. Piso segue 10.0, cavidade vai de 35 pra **140** |
| 2 | Parede **2.0 → 3.0, crescendo PRA FORA** (73→75 em X, 101.5→102.5 em Y) | a 150mm 2mm empena. Com 3mm **pra dentro** a cavidade cairia pra 67.0 e o sleeve de ~66.7 não entraria |
| 3 | Parede **MACIÇA**, sem colmeia | **pedido literal do usuário — sobrepõe a regra 5 do CLAUDE.md**, de propósito. O preço está medido em [Material e tempo](#material-e-tempo) |
| 4 | Sulco = **2/3 do externo = 50.0mm**, do piso ao topo | pedido do usuário. Sem travessa nenhuma |
| 5 | Retorno da aba **7.25 → 9.5mm** | consequência do item 4: sulco em x ±25.0 com a face interna da lateral em ±34.5 |
| 6 | Folga do ressalto **0.2 → 0.4/lado** + chanfro de 0.8 | regra 6 do CLAUDE.md, lição do deckbox-02 impresso que **travou no meio do curso**. Peça de 150mm em pé empena mais que uma de 45 |
| 7 | Retorno da aba **cortado 3.4mm abaixo da boca** (z=146.6) | ver abaixo |

### Por que o retorno da aba para em z=146.6

O ressalto da torre de cima ocupa os 3mm de cima da cavidade da de baixo. Se a
aba subisse até a boca, o ressalto teria que ser **recortado em volta dela** — e
esse recorte deixaria, na frente, dois trechos de **12.9 × 3.9mm de laje
horizontal boiando no ar** (é o que a referência faz; o perfil dela vem com
suporte LIGADO). Cortando 3.4mm só do **retorno** (a parede lateral sobe inteira
até 150), o ressalto vira um prisma limpo e esses balanços somem.

Custo: os 3.4mm de cima da pilha ficam sem aba na frente — e com uma torre
empilhada em cima esses 3mm estão ocupados pelo ressalto dela.

### O problema da saia, e como foi resolvido

Parede 3.0 + folga 0.4 = **3.4mm de saia** em volta do ressalto, a 3mm da mesa
(na referência eram 2.2). Laje horizontal saindo do nada — e a superfície que
pende é justo a que faz o assento do empilhamento.

| Saída | Veredito |
|---|---|
| degrau reto de 3.4 | assento perfeito, superfície pendurada e ondulada — ondulação no assento é torre balançando |
| chanfro de 45 puro | imprime lindo e **não tem assento**: a torre de cima escorrega na rampa até cunhar na aresta do aro, abrindo a parede |
| **adotada: 1.2mm de ledge plano + 2.2mm a 45** | assento definido, e o balanço cai de 3.4 pra **1.2mm** — metade do que a referência já imprime hoje |

O aro da torre de baixo tem 3.0 de largura (x 34.5..37.5) e o ledge da de cima
pousa em 34.1..35.3: **0.8mm de contato real** num anel contínuo em U de ~276mm
= ~220mm². Por isso **não existe funil na boca**: um funil de 0.6 comeria esses
0.8 e o assento sumiria. Quem guia o encaixe é o chanfro de 0.8 do ressalto,
sozinho.

## Curso do empilhamento (simulado com número, e depois provado na geometria)

| Separação | O que acontece |
|---|---|
| 3.00mm | a base do ressalto (66.6 × 97.5, já com o chanfro) procura a boca (69.0 × 99.5). Aceita **1.2mm de erro lateral de mão** (0.4 de folga + 0.8 de chanfro) |
| 2.20mm | acaba o chanfro, entra o reto: **2.2mm de engate reto** com 0.4/lado |
| 0.00mm | assenta. O batente é o **ledge contra o aro**, nunca o fundo do ressalto contra sleeve |

Provas rodadas na geometria (não deduzidas):

- `part="fit"` (passo real de 147) → **VAZIO**: encaixa sem tocar em nada.
- passo 146 (1mm fundo demais) → **382mm³** de interferência em z 146..150. É o
  assento parando a descida: o teste tem dente, não é vazio por acidente.
- virada 180° → **589mm³** em y 48.05..51.25, z 147..150. Não há chaveta
  desenhada, mas o **contorno assimétrico do ressalto** (rente na frente,
  recuado atrás) já é uma: virada, ela bate no fundo e fica **3mm alta**.

## Specs

- **Externo**: 75.0 × 102.5 × 150.0mm
- **Cavidade**: 69.0 × 99.5 × 140.0 (curso útil **137** com torre empilhada em
  cima — o ressalto dela come 3mm)
- **Parede**: 3.0mm maciça, laterais e fundo. Frente sem parede
- **Piso**: 10.0 (ressalto 3.0 + laje cheia 7.0)
- **Sulco**: 50.0mm (2/3 do externo), do piso ao topo, sem travessa
- **Abas em L**: 3.5mm de fundura em Y, **retorno de 9.5mm**, do piso a z=146.6
- **Ressalto**: 68.2 × 99.1 × 3.0, folga 0.4/lado, chanfro de entrada 0.8,
  engate reto 2.2
- **Assento**: ledge 1.2 + rampa de 45° de 2.2 (externo cheio a partir de z=5.2)
- **Passo do empilhamento**: 147mm → duas torres = **297mm** de coluna
- **Quinas**: r = 1.0 nas verticais externas e nas arestas do sulco
- **1ª camada**: ~6.7 mil mm² maciços (o ressalto inteiro) — **não precisa brim**

### Capacidade — é ESTIMATIVA, não conta com ela

140mm de curso ÷ 0.08mm por sleeve vazio ≈ **1750 sleeves** (≈1710 com torre
empilhada). **A espessura do sleeve não foi medida** e ela varia muito entre
marcas — o número serve pra ordem de grandeza, nada além. Com carta enseleevada
(~0.35mm) seriam ~400.

### Material e tempo

| | |
|---|---|
| Volume sólido **medido na malha** | **197.3 cm³** |
| Só as três paredes | 115 cm³ = 3.0 × 150 × (2×102.5 + 69) |
| Estimativa fatiada (2 perímetros, 15% grade) | ~120 cm³, **~150g, ~7h** — o número real quem dá é o fatiador |
| Comparação | o `penny-holder-01` tem o mesmo envelope de 150mm e **78 cm³**, porque é todo em colmeia |

É o preço da parede maciça (item 3), e foi escolha consciente. Se incomodar, os
botões honestos, nesta ordem: `wall_override = 2.6` (−20 cm³); baixar a altura
(`total_h_override = 100`); **não** baixar o infill do piso — ali o peso é
feature, é o lastro.

## ⚠️ Pendências declaradas

1. **A medida do sleeve NÃO é de régua.** A cavidade 69.0 × 99.5 veio da malha
   da referência (peça impressa e aprovada por terceiros), não do sleeve do
   usuário. Mesma ressalva que o [`README de organizadores_tcg`](../../organizadores_tcg/README.md)
   faz pro `penny-holder-01`. Quando a régua chegar, o conserto é um include de
   3 linhas:
   ```scad
   cav_w_override = 66.7 + 2; cav_d_override = 91.6 + 2;
   include <sleeve-tower-01.scad>
   ```
   O modelo inteiro se refaz — externo, sulco, abas e ressalto são todos
   derivados desses dois números.
2. **Espessura do sleeve não medida** → a capacidade é chute com ordem de
   grandeza.
3. **Não foi impressa nem testada na mão.** O veredito é o teste físico.
4. **Duas empilhadas balançam.** Centro de massa medido na malha:
   (0, 4.85, **52.11**) numa torre; empilhadas, **125.6**. Ângulo de tombamento:

   | | lado | frente | trás |
   |---|---|---|---|
   | uma torre | 35.7° | 47.1° | 41.7° |
   | duas empilhadas (297mm) | **16.6°** | 24.1° | 20.3° |

   E isso **vazias** — cheias o conteúdo sobe o centro de massa. Duas
   empilhadas é coluna que um esbarrão derruba: usar encostada na parede ou na
   prateleira, não solta no meio da mesa.

## Verificação feita

- `Volumes: 2` no sumário CGAL → **um sólido único** (o ressalto foi fundido no
  corpo de propósito com 0.02mm de sobreposição interna; encostados só na face
  saíam dois volumes)
- Seções do STL conferidas nos níveis críticos: **0.05 / 0.79 / 0.85 / 2.99 /
  3.01 / 5.19 / 5.25 / 10 / 146.5 / 146.7 / 149.9** — batem com o projeto ao
  centésimo (ex.: z=3.01 dá 70.62 × 100.31 = o ledge; z=5.25 dá 75.00 × 102.50)
- Ray-cast na malha: aba presente em z=20 e 146 (sólido de x=25.0 a 37.5) e
  **ausente** em z=147 e 149 (só a parede, 34.5 a 37.5) → o corte do retorno
  existe de fato
- Preview lido em 6 câmeras: perspectiva, topo ortográfico, elevação frontal,
  duas de baixo e **um corte no plano XZ** mostrando o perfil do pé (chanfro →
  ressalto reto → ledge → rampa de 45 → parede)
- Bed-check A1 mini: 75.0 × 102.5 × 150.0 (**ok**) e o par 156.0 × 102.5 × 150.0
  (**ok**, abaixo do teto confortável de 170)

## Arquivos

- `sleeve-tower-01.scad` — fonte paramétrico
- `stl/sleeve-tower-01.stl` — peça individual
- `3mf/sleeve-tower-01-plate.3mf` — **job principal**: 1 torre (75 × 102.5)
- `3mf/sleeve-tower-01-par.3mf` — job: 2 torres lado a lado, vão de 6mm
  (156 × 102.5). Conveniência pra quem já vai empilhar; dobra o tempo e põe
  duas torres de 150mm balançando no eixo Y da A1 mini

## Como gerar

```sh
flatpak run org.openscad.OpenSCAD -o stl/sleeve-tower-01.stl       -D 'part="tower"' sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-plate.3mf -D 'part="plate"' sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-par.3mf   -D 'part="par"'   sleeve-tower-01.scad
```

Diagnóstico (não vai pra `3mf/`): `part="fit"` (tem que sair vazio) e
`part="stack2"` (as duas empilhadas, só pra render).

## Impressão

- **Em pé, na orientação de uso, boca pra cima. Sem suporte.**
- Os **102.5 vão no eixo Y** de propósito: é o eixo que a cama da A1 mini
  balança, e a base maior é o que segura a inércia de uma torre de 150mm.
- **Brim não é necessário**: a 1ª camada é o ressalto inteiro, ~6.7 mil mm²
  maciços.
- Inventário de balanço — o **único** balanço plano da peça é o **ledge de
  1.2mm** do assento, em z=3. Todo o resto é vertical ou 45°, e **não existe uma
  única ponte** na peça (a frente é aberta do piso ao topo, sem travessa).
- Perfil de partida: `0.20mm Standard @BBL A1M`. **Se o fatiador estiver com
  suporte LIGADO**, conferir que ele não vai enfiar nada embaixo do ledge de
  z=3: é justamente a superfície de assento do empilhamento, e resto de suporte
  ali deixa a torre de cima bamba.

## Parâmetros que valem mexer

| Override | Efeito |
|---|---|
| `cav_w_override` / `cav_d_override` | quando a régua chegar. Refaz o modelo inteiro |
| `total_h_override` | altura da torre (assert reprova acima de 180) |
| `wall_override` | 2.6 economiza ~20 cm³; abaixo disso a 150mm de altura não vale |
| `open_frac_override` | largura do sulco. 0.93 deixa passar carta enseleevada e mata a aba |
| `stack_clear_override` | folga do empilhamento; 0.4 é o mínimo que a lição do deckbox-02 recomenda pra esta altura |

Variante sempre **por include, nunca por `-D`** (os `*_override` só existem via
`-D` e o ternário `is_undef()` é avaliado antes).

## Próximas iterações (ideias)

- Rebaixo de etiqueta na face do fundo (é a única face cega da peça)
- Pé antiderrapante / rebaixo pra TPU nos cantos do ressalto, se o teste físico
  mostrar que a torre escorrega
- Variante de 2 alturas empilháveis (75 + 150) pra quem quer boca própria em
  cada camada, como o `penny-holder-01` sugere
