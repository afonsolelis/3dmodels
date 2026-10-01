# parafuso-porca-01

Jogo de **4 parafusos com porca**, impressos. Rosca **métrica ISO** (V de 60°)
de **Ø3,7 nominal × 14mm de rosca total** — a rosca nasce colada na cabeça e
vai até a ponta, sem haste lisa —, **cabeça chata** cilíndrica com serrilha de
dedo, e **porca sextavada** engrossada pra FDM.

É um **thumbscrew**: aperta com a ponta dos dedos na serrilha, **até encostar,
e para**. A cabeça é chata, ou seja, **assenta em cima da superfície** — o furo
da peça a ser presa é um furo passante reto de **Ø4,4mm**, não um cone de
escareado.

| | |
|---|---|
| Arquivo para imprimir | [`3mf/parafuso-porca-01-plate.3mf`](./3mf/parafuso-porca-01-plate.3mf) |
| Conteúdo | 4 parafusos em pé + 4 porcas deitadas |
| Envelope da chapa | **100,4 × 38,1 × 16,0 mm** |
| Testar antes | [`3mf/parafuso-porca-01-cupom.3mf`](./3mf/parafuso-porca-01-cupom.3mf) — 1 parafuso de rosca curta + 1 porca, 23,8 × 9,0 × 12,0 mm, ~10 min |
| Aperta no máximo | **9,0 mm** de espessura (`thread_len − nut_h`) |
| Furo na peça a prender | Ø **4,4 mm** passante reto |
| Suportes | nenhum |
| Hardware | nenhum |

## Não tem fenda de chave de fenda — e isso é o projeto

A v1 tinha uma fenda de 1,4 × 1,0mm no topo. O print-review reprovou, com
razão:

- o núcleo deste parafuso **rompe entre 25 e 55 N·mm**;
- uma chave de fenda pequena entrega **300 a 1000 N·mm** na mão de qualquer
  pessoa.

Ou seja: a fenda era um **convite desenhado na peça pra destruir a peça**. E de
quebra, o corte atravessava a cabeça de lado a lado, o que fazia a primeira
camada ser **duas meias-luas de 13,5mm²** que só se uniam 5 camadas acima.

Sem ela, a primeira camada volta a ser um **disco inteiro de 35,3mm²** (número
integrado no `.scad`, já descontando as mordidas da serrilha) e o acionamento
único é o **dedo na serrilha**, que entrega 20–30 N·mm — o único patamar dentro
do envelope. A chave de boca 9 na porca serve pra **segurar**, nunca pra dar
torque.

## Limite físico — leia antes de apertar

Núcleo Ø2,347 → área 4,33mm², módulo de torção polar 2,54mm³. A ~25MPa de
resistência **intercamadas** do PLA:

| patamar | torque |
|---|---|
| torção pura, sem mais nada | ~63 N·mm |
| somando a tração da pré-carga de aperto (von Mises, F≈T/(K·d), K≈0,25 → 0,7266·T) | ~46 N·mm |
| somando o entalhe da raiz do filete (chato de p/4 com canto vivo, Kt≈2–3) | 32–21 N·mm |
| **faixa de trabalho** | **25–55 N·mm** |

O dedo na serrilha entrega 20–30 N·mm: o aperto de dedo **firme já encosta no
limite de baixo**. Aperte até encostar e pare — sem alavanca de espécie
nenhuma. Pra serviço estrutural de verdade: parafuso de metal.

A área de cisalhamento da rosca **engatada** na porca (3,04 voltas úteis,
16,4mm²) é **3,8×** a área do núcleo — então o parafuso **torce antes de a
rosca espanar**, que é o modo de falha desejado: quem morre é o parafuso, a
porca sobrevive.

## Cadeia de dimensões da rosca

| | Macho (parafuso) | Fêmea (porca) |
|---|---|---|
| Maior (crista / raiz) | **Ø3,700** | Ø4,100 |
| Efetivo (de passo) | Ø2,888 | Ø3,288 |
| Menor (núcleo / crista) | **Ø2,347** | Ø2,747 |

Passo **1,25mm**, 1 entrada, mão direita, 11,2 voltas em 14mm. Altura do dente
**0,677mm**, dos quais **0,477mm (70%) engatam de verdade** depois da folga.
A porca tem 5,0mm de altura mas só **3,8mm de roscado útil** (os dois funis de
0,6 comem rosca nas bocas) = **3,04 voltas**.

## Por que passo 1,25 e não os 1,5 pedidos

A rosca come o núcleo pelos dois lados: `d_núcleo = 3,7 − 1,0825 × passo`.

| Passo | Núcleo | Torção relativa | Camadas por passo (0,2mm) |
|---|---|---|---|
| 1,50 | Ø2,08 | 1,00 | 7,5 |
| **1,25** | **Ø2,35** | **1,44** | **6,2** |
| 1,00 | Ø2,62 | 2,00 | 5,0 |

Em Ø3,7 o passo 1,5 é o passo de um **M10 comercial** — sobra um núcleo de 2mm
que torce no dedo. Descer pra 1,25 devolve **44% de torção** sem cair abaixo de
6 camadas por passo na camada padrão de 0,2mm da AD5X. O dente ainda tem
0,68mm de altura radial, ~1,6 larguras de extrusão no bico 0,4 — é um dente que
o fatiador traça de verdade.

Trocar é uma linha: `thread_pitch = 1.5` reproduz o pedido original, `1.0`
maximiza o núcleo. **Os três passos foram testados por CLI e compilam** (na v1
o 1,0 quebrava: `tip_chamfer` era uma constante mágica casada com 1,25; agora é
derivado de `thread_dep`).

## Folga de rosca: 0,4 no diâmetro (0,2/lado) — mas comece testando em 0,5

Rosca não segue a regra de deslize do CLAUDE.md (0,5/lado) nem a de peça solta
(0,3/lado) — aquelas são pra encaixe deslizante **longo**, onde o inimigo é o
empeno. Aqui o encaixe é **helicoidal e curto** (3,8mm de roscado) e folga
demais vira folga **angular**.

**Espere que a porca entre dura na primeira tentativa.** As duas peças têm o
perfil da rosca deitado em XY, e é isso que torna o caso ruim: o macho é um
contorno **convexo** (sai superdimensionado — pé de elefante, superextrusão,
droop de flanco) e a fêmea é um contorno **côncavo** (sai subdimensionado — o
clássico "furo impresso sai menor"). Os dois erros andam no **mesmo sentido de
fechar a folga: eles somam**, e juntos podem comer os 0,2mm/lado inteiros.

A cadeia perigosa que sai daí é **porca dura → forçar → torque → núcleo
quebrado**, que é exatamente o modo de falha da seção anterior. Por isso:

- `0.4` é o **default do modelo**;
- o **primeiro cupom deve ser rodado em `thread_clearance = 0.5`** (63% de
  dente, ainda passa todos os asserts);
- se em 0,5 chacoalhar demais, descer pra 0,4 e depois 0,3. **Abaixo de 0,3
  emperra.**

### A folga angular é esperada, não é defeito

Backlash axial 2 × 0,115 = **0,231mm**, que em passo 1,25 dá **66,5° de giro
livre** antes de o flanco encostar, e a porca **inclina 4,57°** no parafuso.
Isso é geometria de rosca com folga, não folga sobrando: é o preço de a porca
entrar. Vai parecer que "chacoalha" — e descer de 0,3 pra matar o chacoalho é
que emperra a peça.

## Orientação de impressão

**Parafuso em pé, cabeça na cama, ponta pra cima.** Em pé a rosca sai como
contorno fechado por camada (crista redonda, flanco contínuo, zero suporte);
deitada ela vira uma sequência de balanços que o fatiador esmaga. A cabeça vai
na cama porque a alternativa apoiaria uma torre de 16mm num pé de Ø2,3 — tomba
no primeiro contato do bico. Com a fenda fora, a face que encosta na cama é um
disco inteiro: sem ponte, sem ilha, nada acontecendo na primeira camada.

Consequência assumida: o torque carrega as camadas ao cisalhamento. Não existe
orientação que resolva isso num parafuso impresso — existe imprimir com mais
perímetros e mais temperatura.

**Porca deitada, furo em Z**: as duas faces saem planas e a rosca interna nasce
como furo redondo por camada. O flanco de baixo da rosca interna é um balanço
de **60° da vertical**, muito além dos 45° de regra — e funciona, mas **não**
porque "cada camada apoia na anterior deslocada de 0,2mm". Isso é falso: no
mesmo ângulo, de uma camada pra de baixo o raio anda `dr/dz × 0,2 = 1,732 ×
0,2 = 0,347mm` contra 0,42mm de largura de cordão, ou seja o cordão novo pousa
com **17% de sobreposição** — quase em falso. O que salva é o **vão ser curto**:
o flanco tem `5p/16 = 0,39mm` de percurso axial, isto é **duas camadas** de
balanço antes de a geometria virar pra raiz e reencostar. Dois cordões meio
pendurados não caem; vinte cairiam. É por isso que porca impressa sai sem
suporte, e por isso que porca de passo grosso demais não sairia.

Chanfro de 0,7 nas duas faces da porca e de 0,3 na aresta da cabeça que fica na
cama: matam o pé de elefante exatamente nas arestas que o dedo pega. Na porca,
o funil de 0,6 nas duas bocas apaga justamente as voltas que o pé de elefante
ataca; a rosca do macho nasce em z = 2,0, já fora da zona.

## Fatiamento — os dois ajustes que decidem a rosca

- 0,2mm de camada, 3+ perímetros, preenchimento 100% (as peças são minúsculas,
  o sólido sai de graça), sem suporte.
- **Brim obrigatório.** Não é "brim se descolar": a cabeça apoia ~35mm² pra
  16mm de altura, e quando se descobre que descolou a peça já foi.
- **Min layer time ≥ 8–10s, ventoinha 100%.** Acima de z = 5 sobram só as 4
  hastes, ~11mm² de seção somada, o que dá ~2,6s por camada a 40mm/s. Sem freio
  de camada a crista sai quente, incha, e a folga de 0,2/lado desaparece — ou
  seja, é este ajuste, e não o `thread_clearance`, que estraga a rosca primeiro.

As 8 peças ficam a 30mm entre centros justamente pra dar tempo de resfriamento
por camada.

## Parâmetros

Tudo no topo do [`parafuso-porca-01.scad`](./parafuso-porca-01.scad):
`thread_d`, `thread_pitch`, `thread_len`, `thread_clearance`, `head_d`,
`head_h`, `knurl_n`, `nut_af`, `nut_h`, `nut_lead_in`, `coupon_thread_len`,
`plate_pitch_x/y`, `plate_n`. Os `part` de conferência (`assembly`, `section`,
`head_section`) não são jobs de impressão.

```
flatpak run org.openscad.OpenSCAD -o stl/parafuso-porca-01-parafuso.stl -D 'part="screw"' parafuso-porca-01.scad
flatpak run org.openscad.OpenSCAD -o stl/parafuso-porca-01-porca.stl    -D 'part="nut"'   parafuso-porca-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/parafuso-porca-01-plate.3mf    -D 'part="plate"' parafuso-porca-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/parafuso-porca-01-cupom.3mf    -D 'part="plate_coupon"' parafuso-porca-01.scad
```

## Pendências

Ainda **não foi impresso**. O teste físico é, em ordem:

1. **Cupom, em `thread_clearance = 0.5`** (não no 0,4 do default — ver a seção
   de folga). Os 10mm de rosca do cupom dão **5mm de curso** da porca, que é
   onde o empeno morde; com os 6mm da v1 dava 1mm e testava só a entrada.
   A porca entra com os dedos, **corre** e sai? Se ficar dura, é a folga; se
   ficar frouxa, descer pra 0,4.
2. **Jogo**: a porca corre os 14mm inteiros sem catar? A serrilha dá pega
   suficiente pro dedo apertar até encostar?
3. **Faltou informar**: a **espessura da peça que o parafuso vai atravessar** e
   o **diâmetro do furo dela**. O modelo aperta no máximo **9,0mm**
   (`thread_len − nut_h`) — se a peça for mais grossa, `thread_len` tem que
   subir. E o furo recomendado é **Ø4,4** e não 4,2: a crista impressa sai em
   ~3,80–3,85 (droop de flanco + superextrusão), e com 4,2 sobrariam só
   0,17mm de cada lado.
