# sleeve-tower-01

Torre de **cartas/penny sleeves deitados** com **tampa deslizante**:
**78 × 102.5 × 150mm** (75 de corpo + cinta de 1.5 por lado no topo), três
paredes **maciças** de 3mm (duas laterais + fundo), a frente aberta num **sulco
vertical de 50mm** que fecha em **arco de 45° (ponta pra cima)** numa travessa
logo abaixo da boca, ladeado por **duas abas em L** que seguram a pilha. Piso de
10mm que é lastro e, embaixo dele, um **ressalto de empilhamento**.

A **tampa** é uma chapa retangular **lisa** de 2.6mm, sem puxador, que corre em **canaletas** no topo das
laterais, estilo estojo: entra pela frente e bate no fundo. **Sem trava** — o
trilho segura a tampa pra cima, mas ela pode deslizar pra fora pela frente
(ver [Sem trava](#sem-trava-o-que-segura-a-tampa)). A torre continua
**empilhável com a tampa fechada**.

Tudo imprime **sem suporte**: torre em pé, tampa de cabeça pra baixo.

Variante alta e reprojetada do `../PennySleeveHolderStacking_V2.3mf` (removido
do repo em 2026-08-28; Sazabi, MakerWorld, MakerWorld Exclusive License —
**arquivo de terceiro, não redistribuível**; serviu só de referência de
geometria, este `.scad` é reconstrução paramétrica própria).

## Como se manuseia

1. Fica **de pé** na mesa, sulco virado pra você. A carta entra **deitada**
   (66.7 no X, ~91 no Y) e a pilha cresce em Z: **133.9mm de curso útil**, do
   piso (z=10) ao fundo da tampa (z=143.9).
2. **Abrir**: ponta do dedo em cima da tampa, perto da frente (ela fica 3.5mm
   abaixo do aro), e arrasta pra você. A tampa desliza 99.3mm até sair. Não tem
   puxador — pedido do usuário (*"não precisa de puxador não"*).
3. **Abastecer / tirar**: pela **boca**, aberta nos 69.0 × 99.5 inteiros. Carta
   **já ensleevada** é rígida e **não passa pelo sulco** (66.7 de carta contra 50
   de vão): a boca é a única saída, por isso a tampa. O sulco é janela de ver o
   nível da pilha. A carta do **fundo** da pilha só sai **virando a torre**
   (tampa aberta, mão na boca).
4. **Fechar**: encosta a tampa (chanfro de baixo pra trás e pra baixo) na boca das
   canaletas e empurra até bater no fundo.
5. **Empilhar** (com ou sem tampa): a torre de cima desce na boca da de baixo,
   ressalto de 3mm com 0.4/lado. A tampa de baixo fica 0.5 abaixo do ressalto e
   não encosta.

> **Sem trava:** a tampa é presa **pra cima** pelo trilho, mas pode **deslizar
> pra fora pela frente** se a torre for inclinada pra frente ou ficar de cabeça
> pra baixo. Carregar de pé, ou com a mão sobre a frente.

## Tampa deslizante

Substituiu (2026-10-04) uma tampa de encaixe por cima que o usuário reprovou:
*"ela não segura nada, fica solta"*. Ele escolheu deslizante — e isso exigiu
mexer na torre (canaletas, cinta, travessa).

A 1ª versão deslizante tinha uma **trava de clique** (lingueta-mola com dente
num rebaixo da travessa). A peça de teste impressa **aprovou o trilho** e
**reprovou o clique**: *"ficou ruim, não precisa dessa trava, apenas o deslizar
já está ok"*. O clique saiu; o trilho ficou **exatamente como estava** (provado
abaixo) e as abas voltaram de 5.0 — fundura que só existia pra caber o rebaixo
— pra **3.5**. Depois o **puxador** também saiu (*"não precisa de puxador
não"*): a tampa virou uma chapa retangular lisa.

### Por onde entra e onde fica

- **Pela frente.** A frente já é a face aberta, o **fundo vira batente de graça**
  (a canaleta termina na face interna dele) e o lado de abrir é o que você olha.
- **Abaixo da zona do ressalto**, pra empilhar com a tampa fechada: o ressalto
  da torre de cima desce até z=147, a tampa vai de **143.9 a 146.5** (0.5 de
  folga). Preço: o curso útil cai de 137 (o que a torre empilhada já tinha)
  pra **133.9** — 3.1mm, ~9 cartas ensleevadas. Na boca (z 147..150) daria 137,
  mas aí teria que tirar a tampa pra empilhar.

### Perfil do trilho (corte XZ, lado +x)

| | |
|---|---|
| Tampa | chapa retangular **lisa** de **2.6** (z 143.9..146.5), **73.0 × 99.0**; frente em y=−50.95, **0.3 atrás da cara da frente** (onde o trilho já definia), nada projetando pra fora |
| Lingueta | entra **2.0** na parede além da face interna (x 34.5..36.5). Fundo plano; topo com **chanfro de 45°** de x=34.9 até a ponta de **1.0** de altura |
| Canaleta | piso plano em z=143.9, fundo em x=37.0, **teto a 45°** descendo pra dentro da parede (z=147.4 na boca → 144.9 no fundo) |
| Folgas | **0.5/lado** em X (regra 6), **0.5** vertical. Engate mínimo encostada num lado: **1.5** |
| Entrada | chanfro de **0.6** na boca da canaleta; cantos de trás da tampa chanfrados **0.8**; aresta de **baixo** da borda de ataque (a de trás, que entra primeiro) chanfrada **0.5** — passa por cima de carta empenada em vez de empurrar |
| Cinta | laterais engrossadas **1.5 pra fora** só no topo (z 142.9..150, chanfro de 45° embaixo), quinas **r=0.3**. Sobra **2.0** de parede atrás da canaleta — sem a cinta seriam 0.5 |
| Boca × quina | com chanfro de 0.8 e quina r=1 sobravam **0.2** de parede na cara da frente (lasca, regra 4); com **0.6 e r=0.3** sobram **1.1**, e 2.0 a 0.6mm pra dentro |

**Folga lateral e vertical são acopladas** pelo teto a 45°: tampa centrada sobe
0.5; tampa encostada num lado já tem o chanfro daquele lado no teto e não sobe
nada. A tampa tem 0.5 de jogo e pode fazer **um leve barulho** chacoalhando.

**Por que teto a 45° e não reto:** a torre imprime em pé, e canaleta horizontal
em parede vertical tem teto virado pra baixo — reto seria balanço de 2.5mm. A
45° descendo **pra dentro** da parede, cada camada avança sobre a de baixo presa
na parede. (A cauda de andorinha "de verdade", com o teto subindo pra dentro da
parede, começa numa lasca solta na face interna e não imprime em pé.)

### Travessa da frente

Barra na faixa das abas (y −51.25..−47.75), até z=143.9, ligando as duas
laterais. Fica, mesmo sem o clique, porque:

1. **Amarra o U.** O topo de uma torre de 150 impressa em pé faz barriga; com
   as pontas da frente soltas, as laterais fechariam (tampa trava) ou abririam
   (tampa solta). Com a travessa, a boca vira um quadro fechado.
2. É o **apoio da frente da tampa**: fechada, a frente da tampa (y=−50.95)
   apoia **3.2mm** na travessa na largura toda, além dos pisos das canaletas.

As cartas ficam atrás dela (y > −47.75) e saem pela boca sem encostar. Embaixo,
o sulco fecha em **arco de 45° de ponta pra cima** (z 115.3 → 140.3, no mesmo
lugar de antes; 3.6 de travessa acima da ponta): sem ponte, e é o único aceno à
colmeia numa peça que é maciça por pedido do usuário.

### Abas: de volta a 3.5

O 5.0 só existia pra caber o rebaixo do clique com parede dos dois lados. Sem
clique, nada mais depende disso: o apoio da tampa na travessa cai de 4.7 pra
**3.2mm** (sobra — a tampa também apoia nos dois pisos de canaleta em todo o
comprimento) e o arco do sulco não mudou. A carta ganha **1.5mm** em Y: **96.0**
de vão atrás da aba.

### Sem trava: o que segura a tampa

| Direção | Quem segura |
|---|---|
| pra cima / de cabeça pra baixo | o **teto a 45°** da canaleta: sobe no máximo 0.5, não cai pra baixo |
| pros lados | 0.5/lado |
| pra trás | o batente (face interna do fundo) |
| **pra frente** | **nada além do atrito** — inclinar a torre pra frente ou virar de cabeça pra baixo faz a tampa **escorregar pra fora** |

### Curso completo e provas (`part="lid_fit"`, rodadas)

| Teste | Resultado |
|---|---|
| curso inteiro em repouso: dy = 0, −1, −2, −3, −5, −10, −25, −50, −75, −95, −99 (dz=0.01) | **VAZIO em todos** |
| curso levantada até o teto: dy = 0, −2, −50, −99 (dz=0.5) | **VAZIO em todos** |
| fechada, 0.7 pra cima | 67mm³ — **não sai pra cima** |
| fechada, 0.6 pro lado | 27mm³ |
| fechada, 0.4 pra trás | 31mm³ — batente |
| torre × torre (`part="fit"`) | **VAZIO** |
| tampa fechada × torre de cima (`part="stack_fit"`) | **VAZIO**; +0.7 1305mm³ |

**Trilho inalterado desde o teste físico** — antes e depois de tirar o clique,
mesmo nº de triângulos, bbox e hash de vértices ordenados em: topo da torre
acima do piso da canaleta (z ≥ 143.95; 348 triângulos), paredes + cinta
(|x| ≥ 34.6, z 140..150; 476) e linguetas da tampa (|x| 33..37, y −45..47; 32).

## O que veio da referência, e o que mudou

Medido na malha da variante Stackable: externo **73.0 × 101.5 × 45.0**, parede
2.0, cavidade **69.0 × 99.5**, piso 10.0, ressalto z 0..3 de 68.6 × 99.3
(0.2/lado), abas em L de 3.5mm de fundura, sulco de **50.0**, quinas r ≈ 1.0.

| # | Mudança | Por quê |
|---|---|---|
| 1 | Altura **45 → 150** | pedido do usuário |
| 2 | Parede **2.0 → 3.0, pra fora** | a 150mm 2mm empena; pra dentro a carta não entraria |
| 3 | Parede **maciça**, sem colmeia | **pedido literal do usuário — sobrepõe a regra 5**, de propósito |
| 4 | Sulco **50.0**, fechando em arco de 45° em z 115.3..140.3 | pedido do usuário (2/3); o arco fecha na travessa sem ponte |
| 5 | Aba: retorno **9.5**, fundura 3.5 (igual à referência) | foi 5.0 só enquanto existiu o clique; atrás da aba sobram 96.0 em Y |
| 6 | Folga do ressalto **0.2 → 0.4/lado** + chanfro 0.8 | regra 6, lição do deckbox-02 |
| 7 | **Tampa deslizante** + canaletas + cinta + travessa, sem trava | pedido do usuário depois de reprovar a tampa de encaixe; o clique saiu depois do teste físico |

### Assento do empilhamento (inalterado)

Parede 3.0 + folga 0.4 = 3.4mm de saia em volta do ressalto, a 3mm da mesa.
Solução: **1.2mm de ledge plano + 2.2mm de rampa a 45°** — assento definido e
balanço plano de só 1.2mm. Contato real do ledge sobre o aro: **0.8mm** num anel
em U de ~276mm. Sem funil na boca (comeria o assento): quem guia é o chanfro de
0.8 do ressalto (aceita 1.2mm de erro de mão). Virada 180° a torre de cima bate
no fundo e fica 3mm alta.

## Specs

- **Externo**: 78.0 (cinta) / 75.0 (corpo) × 102.5 × 150.0mm
- **Cavidade**: 69.0 × 99.5; **curso útil 133.9** (piso → fundo da tampa), com
  ou sem torre empilhada
- **Parede**: 3.0mm maciça (laterais e fundo); 4.5 na cinta (z ≥ 142.9)
- **Piso**: 10.0 (ressalto 3.0 + laje 7.0)
- **Sulco**: 50.0mm de z=10 a 115.3, arco de 45° até a ponta em 140.3
- **Abas em L**: 3.5 de fundura, retorno 9.5, até a travessa (z=143.9)
- **Ressalto**: 68.2 × 99.1 × 3.0, folga 0.4/lado, chanfro 0.8; passo **147**
  (duas torres = 297mm)
- **Tampa**: chapa retangular lisa 73.0 × 99.0 × 2.6, 18.5 cm³; trilho
  0.5/lado; curso 99.3; sem trava, sem puxador
- **Volume**: torre **201.2 cm³** de sólido (medido na malha)

### Capacidade — é ESTIMATIVA

133.9mm ÷ ~0.35mm por carta ensleevada ≈ **~380 cartas**; ÷ 0.08 por sleeve vazio
≈ ~1670. **A espessura não foi medida.**

### Estabilidade (medida na malha)

Centro de massa (0, 4.11, **53.80**).

| | lado | frente | trás |
|---|---|---|---|
| uma torre | 34.9° | 45.8° | 41.2° |
| duas empilhadas (297mm, CM em z=127.3) | **16.4°** | 23.5° | 20.3° |

Vazias — cheias, pior. Coluna de duas: **encostada na parede ou na prateleira**.

## Arquivos

- `sleeve-tower-01.scad` — fonte paramétrico
- `stl/sleeve-tower-01.stl` — torre
- `stl/sleeve-tower-01-tampa.stl` — tampa, já de cabeça pra baixo
- `3mf/sleeve-tower-01-plate.3mf` — **job principal**: 1 torre + 1 tampa, vão de
  6mm (**157.0 × 102.5 × 150**)
- `3mf/sleeve-tower-01-par.3mf` — **2 torres numa fileira + 2 tampas na outra**,
  vão de 6mm (**162.0 × 207.5 × 150**). Sem o puxador a tampa tem 99.0 em Y e
  102.5 + 6 + 99.0 = 207.5 cabe no alvo de 210 — o par completo num job só
- `3mf/sleeve-tower-01-tampa.3mf` — 1 tampa (**73.0 × 99.0 × 2.6**). Pra fechar
  uma coluna empilhada (só a de cima leva tampa)
- `3mf/sleeve-tower-01-tampa-par.3mf` — 2 tampas (**152.0 × 99.0 × 2.6**), pra
  reimprimir só tampa

## Como gerar

Caminhos **absolutos** na hora de rodar (aqui abreviados):

```sh
flatpak run org.openscad.OpenSCAD -o stl/sleeve-tower-01.stl           -D 'part="tower"'   sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o stl/sleeve-tower-01-tampa.stl     -D 'part="lid"'     sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-plate.3mf     -D 'part="plate"'   sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-par.3mf       -D 'part="par"'     sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-tampa.3mf     -D 'part="lid"'     sleeve-tower-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-tampa-par.3mf -D 'part="lid_par"' sleeve-tower-01.scad
```

Diagnóstico (não vai pra `3mf/`): `part="fit"`, `part="lid_fit"` (com
`-D fit_dx=… fit_dy=… fit_dz=…`) e `part="stack_fit"` têm que
sair vazios na posição de projeto; `part="stack2"` e `part="with_lid"` são só
pra render.

## Impressão

- **Torre: em pé, boca pra cima, sem suporte, sem brim** (1ª camada = o ressalto
  inteiro, ~6.7 mil mm²). Os 102.5 vão no eixo Y da AD5X.
  - Único balanço plano: o **ledge de 1.2** do assento, em z=3. Todo o resto é
    vertical ou 45°: chanfro do ressalto, saia, cinta, **arco do sulco** (sem
    ponte) e **teto das canaletas**. Piso das canaletas e topo da travessa são
    faces pra cima.
  - **Se o fatiador estiver com suporte LIGADO**, conferir que ele não enfia
    nada nas canaletas nem embaixo do ledge de z=3.
- **Tampa: de cabeça pra baixo, topo liso na cama** (é como o STL/3MF sai),
  2.6mm de altura. O chanfro das linguetas vira balanço de 45° pra fora; a face
  à vista sai com o acabamento do PEI. **Preenchimento 100%** (ou no mínimo 5 camadas de
  topo e de fundo): chapa de 2.6 com grade fica mole e empena.

## ⚠️ Pendências declaradas

1. **A medida da carta NÃO é de régua.** A cavidade 69.0 × 99.5 veio da malha da
   referência. Medir a carta **já ensleevada** (largura × comprimento ×
   espessura). O conserto é um include:
   ```scad
   cav_w_override = <largura + 2>; cav_d_override = <comprimento + 2>;
   include <sleeve-tower-01.scad>
   ```
2. **Espessura da carta não medida** → capacidade é ordem de grandeza.
3. **Só a peça de teste foi impressa** (trilho aprovado na mão, clique
   reprovado e removido). A torre inteira e a tampa sem trava ainda não.
4. **Duas empilhadas balançam** (16.3° pro lado). Usar encostada.

## Verificação feita (2026-10-04, depois de tirar o clique)

- `Volumes: 2` na torre e na tampa (sólidos únicos); 3 nas chapas de 2 peças
- Trilho comparado por hash com a versão aprovada no teste (tabela acima)
- Curso completo, `fit` e `stack_fit` rodados (tabela acima)
- Preview lido: torre de frente, torre com tampa fechada (chapa lisa, sem
  puxador), tampa de cabeça pra baixo, corte YZ (tampa apoiada na travessa),
  chapas `plate` e `par` em topo ortográfico
- Bed-check AD5X: torre 78.0 × 102.5 × 150, tampa 73.0 × 99.0 × 2.6, plate
  157.0 × 102.5, par 162.0 × 207.5, tampa-par 152.0 × 99.0 — **todos ok**

## Parâmetros que valem mexer

| Parâmetro | Efeito |
|---|---|
| `cav_w_override` / `cav_d_override` | quando a régua chegar. Refaz tudo |
| `total_h_override` | altura da torre |
| `wall_override` | 2.6 economiza ~20 cm³ |
| `slide_clear` | folga do trilho (0.5 = regra 6) |
| `collar_w` | cinta; o assert reprova se sobrar menos de 1.6 atrás da canaleta |

Variante sempre **por include** nos `*_override`.

## Próximas iterações (ideias)

- Rebaixo de etiqueta na face do fundo
- Pé antiderrapante, se a torre escorregar
