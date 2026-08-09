# psa-bumper-01

Bumper (case **clamshell**) pra **uma** slab PSA graduada: duas metades de
moldura que fecham em cima da slab e se prendem por **10 pares de ímã Ø4×2**,
alinhadas por um **degrau perimetral** que trava o escorregamento lateral.

> ## 🔴 IMPRIMA O GABARITO PRIMEIRO — a chapa da moldura é PROVISÓRIA
> A medida do slab **nunca foi tirada com régua**, e o envelope adotado
> (84.5 × 139.5 × 7.2) é quase o **mínimo** das 5 fontes: **2 delas não entram**,
> e em Z a cavidade de 7.5 contra 0.30" = 7.62mm já dá **interferência**.
>
> 1. imprima **`3mf/psa-bumper-01-gauge.3mf`** (13.4g, ~30min)
> 2. meça largura, altura e espessura da sua slab nele
> 3. corrija `slab_w` / `slab_h` / `slab_t` e **re-exporte**
> 4. só então imprima `3mf/psa-bumper-01-plate.3mf` (2x)
>
> Imprimir a moldura antes disso é ~62g de PLA apostando num número que a
> própria auditoria classificou como provisório.

> ### Escopo: é um bumper de VITRINE
> Segura a slab em prateleira, mesa e na mão, e abre fácil pra trocar a carta.
> **Não é à prova de queda.** Uma queda de 1m em piso duro põe **~1.2 J** contra
> os **~0.06 J** que bastam pra separar os 10 pares — o case pode abrir e
> liberar a slab. Isso é **decisão de escopo** (o uso é exposição), não defeito:
> é por isso que não entra detente mecânica no degrau. Nenhum ímã de tamanho
> razoável sobrevive a essa queda; só retenção mecânica resolveria, e ela
> atrapalharia justamente o abrir-fácil.

Duas diferenças em relação ao case que inspirou (PSA Graded Card Case, do
MaskForge — `../Main.3mf`):

1. **Sem a travessa central.** A janela é um **vão único e contínuo**: carta e
   etiqueta PSA aparecem juntas, sem haste cortando o meio.
2. **Sem tampa deslizante.** Em vez de a slab entrar por cima, o conjunto é
   duas metades que fecham em cima dela e travam por ímã.

As **duas** metades têm janela aberta — nenhuma é placa cega, então dá pra ver
a frente **e** o dorso da carta.

## Peças (2: a moldura, impressa 2x, e o gabarito)

| Nome | No código | Quantidade | O que é |
|---|---|---|---|
| **moldura** | `frame` | **2 (a mesma peça)** | metade da concha: placa da frente com a janela + aro de 9mm com os ímãs e o degrau |
| **gabarito** | `gauge` | **1 (imprimir PRIMEIRO)** | instrumento de medição do slab: 3 estações de escada em Z, 95×150×31.4mm, 13.4g — **é um job de impressão de verdade** |

Frente e verso são a **MESMA geometria**. O que faz isso funcionar:

- **Layout de ímã simétrico nos dois eixos centrais** — centros em
  (±47.05, ±74.55), (±47.05, ±24.85) e (0, ±74.55). Virando a cópia por
  qualquer um dos dois eixos, cada ímã cai em cima de uma posição de ímã
  válida (conferido nos três mapeamentos: 180°, espelho em X e espelho em Y).
- **Degrau com simetria de rotação de 180°** — ressalto nos quadrantes 1 e 3,
  rebaixo nos 2 e 4 (dois "L" de ressalto em cantos opostos, dois de rebaixo
  nos outros). Esse padrão é *anti*-simétrico em cada espelhamento, que é
  exatamente o que faz ressalto sempre encontrar rebaixo, tombando a cópia
  pelo lado curto **ou** pelo longo.
- **Polaridade**: uma cópia com o polo **N** pra cima, a outra com **S** pra
  cima — aí os 10 pares atraem.

> ⚠️ **Depois de imantadas, as metades não são mais intercambiáveis.** Saem
> idênticas da impressora, mas duas metades "iguais" se **repelem**. Marque as
> duas antes de colar (um ponto de caneta numa, dois na outra).

### Isso está provado na geometria, não só no desenho

```sh
# 1) não colide: interseção das duas metades acasaladas -> "object is empty"
flatpak run org.openscad.OpenSCAD -o /tmp/fit.stl   -D 'part="fit"'   -D 'mate_flip="x"' psa-bumper-01.scad
# 2) engata de verdade: ressalto de uma DENTRO do rebaixo da outra -> Volumes: 9
flatpak run org.openscad.OpenSCAD -o /tmp/grip.stl  -D 'part="grip"'  -D 'mate_flip="x"' psa-bumper-01.scad
# 3) ímãs alinhados em XY: discos onde os bolsos se encontram -> Volumes: 11
flatpak run org.openscad.OpenSCAD -o /tmp/pairs.stl -D 'part="pairs"' -D 'mate_flip="x"' psa-bumper-01.scad
# 4) ímãs alinhados em Z: coluna de ar de cada ímã atravessando a costura -> 10 colunas
flatpak run org.openscad.OpenSCAD -o /tmp/col.stl   -D 'part="column"' -D 'mate_flip="x"' psa-bumper-01.scad
```

O `column` existe porque o `pairs` prova alinhamento só em **XY**. A coluna de ar
mede **62.2109mm³** contra **62.2113** teóricos — desvio de **0.001%** — o que
prova que nada (degrau, chanfro) invade o caminho do disco em **Z**.

Os três passam com `mate_flip="x"` (tomba pelo eixo curto) e `"y"` (pelo eixo
longo). O `grip` existe porque **`fit` vazio, sozinho, pode ser vácuo**: um
ressalto de altura zero não colide com nada e passa no `fit` igual. Controles
negativos rodados pra confirmar que os testes têm dente:

| Controle (quebra de propósito) | Esperado | Resultado |
|---|---|---|
| padrão espelhado em vez de rotacional | colidir só num dos flips | `fit` vazio no x, **Volumes: 9** no y |
| ressalto 2.0 em rebaixo 1.6 (variados independentes) | colidir nos dois | **Volumes: 17** nos dois |
| ressalto 3.4 em rebaixo 2.9 (variados independentes) | colidir nos dois | **Volumes: 33** nos dois |
| ressalto de altura ~zero | `fit` passa, `grip` denuncia | `fit` vazio, **`grip` vazio** |
| **positivo**: `-D step_keepout=-2` | o `column` tem que acusar | volume das colunas **cai 15.8%** ✓ |

Cuidado ao montar controle: `groove_z` deriva de `step_h` e `groove_w` de
`step_w`, então mexer só no ressalto não prova nada — os dois acompanham. Nos
controles acima a derivada foi fixada na mão.

## O gabarito de medição (`part="gauge"`, 13.4g)

Três estações, cada uma um par de pilares: um de **face lisa** (referência) e um
com a face interna em **escada no eixo Z** — vão maior em cima, menor embaixo.
Encosta a aresta do slab no pilar liso, desce entre os dois e **para de descer
quando travar**. O número gravado na face externa naquela altura é o limite
inferior; o degrau de cima, que passou, é o superior.

| Estação | Faixa | Passo | Degraus |
|---|---|---|---|
| **ALT** (altura) | 133 → 142 | 1.0mm | 10 |
| **LARG** (largura) | 87.0 → 83.0 | 0.5mm | 9 |
| **ESP** (espessura, entra a aresta) | 8.00 → 7.00 | 0.25mm | 5 |

Ex.: passa no 85.0 e trava no 84.5 → largura entre 84.5 e 85.0. Para ler, olhe
**de lado**: o perfil da escada e a aresta do slab aparecem juntos.

### Por que escada em Z, e não degraus lado a lado

A aresta do slab é uma reta de 85 a 140mm. Qualquer escada **no plano** é varrida
inteira por essa aresta ao mesmo tempo, então o gabarito lê sempre o **extremo**
(o vão menor) e o valor nunca muda — **duas versões desta peça foram descartadas
por isso**. Em Z o vão é **uniforme ao longo de toda a linha de contato** em cada
altura, que é a única forma de um passa/não-passa medir um objeto rígido
comprido. De bônus, com o vão maior em cima cada degrau se apoia inteiro no de
baixo: sem balanço, imprime sem suporte.

### Por que gabarito impresso e não régua

A régua herda o erro de escala da impressora (0.3% em 140mm = 0.4mm). O gabarito
sai da **mesma máquina** com a **mesma retração** da moldura — ele mede em
"unidades de impressora", que é exatamente o que a cavidade precisa.
Auto-calibrado. Os 24 vãos foram medidos na malha: batem com o número gravado com
erro **0.0000**.

## Como se manuseia

1. Deita uma metade na mesa de boca pra cima e põe a slab na cavidade — ela
   afunda 3.75mm. **Atenção: nessa hora a slab está só APOIADA.** O lip de 2mm
   é o **chão** da cavidade (z 0..2); os 2.7mm de pega por cima da borda da
   slab são do lip da **outra** metade e só existem depois de fechar. Virar a
   metade cheia na mão antes de fechar = slab no chão.
2. Vira a segunda cópia de boca pra baixo e encaixa: o degrau guia (o topo do
   ressalto afina 0.2mm e a boca do rebaixo abre 0.2mm, justamente pra 184mm
   de tongue não brigar na entrada) e os 10 pares de ímã puxam as faces até se
   encostarem. O chanfro de 0.5mm na boca da cavidade faz o **degrau** guiar o
   fechamento — sem ele quem guiava era o próprio slab, numa aresta viva.
3. **Pra abrir** (fácil de propósito — o fecho inteiro tem ~40N e o degrau é
   só alinhamento, com folga de 0.25/lado): use as **meia-luas** — 2 em cada lado curto, flanqueando o
   ímã do meio. A costura passa no meio delas e o chanfro de 45° das **duas**
   metades forma um **V de 2.4mm de boca**. **Ferramenta: palheta ou espátula**
   de plástico — não unha e não moeda (a força de abertura é 17-25N; unha engata
   0.8mm e não faz 17N).
   Método secundário, sempre disponível: **dedo na janela empurrando a slab**
   por dentro (~45N) descola as metades sem ferramenta nenhuma.

## Specs atuais (parâmetros em `psa-bumper-01.scad`)

| O quê | Valor |
|---|---|
| Slab PSA | 84.5 × 139.5 × 7.2mm (**estimativa adotada**, ver aviso) |
| Cavidade da slab | 85.1 × 140.1 × 7.5mm (3.75 por metade) |
| Externo de uma metade | 103.1 × 158.1 × 5.75mm (6.95 com o ressalto) |
| **Conjunto fechado** | **103.1 × 158.1 × 11.5mm** |
| Janela (vão único) | 79.1 × 134.1mm, cantos R4 |
| Chanfro da boca da cavidade | 0.5mm a 45° (guia o fechamento pelo degrau, não pelo slab) |
| Aro | **9mm** uniforme em toda a volta (sem orelhas nos cantos) |
| Lip | 2mm de espessura, pega 2.7mm da borda da slab |
| Faixa visível da face | 12mm (9 de aro + 3 de lip) |
| Ímãs | **20 discos Ø4 × 2mm (10 pares)**, bolso Ø4.3 × **2.1** + alívio de cola Ø2×0.3 no fundo |
| Parede em volta do bolso | 2.35mm de cada lado, 3.65mm de material atrás |
| Maior vão entre ímãs vizinhos | 49.7mm (lado longo) e 47.05mm (lado curto) |
| Degrau | ressalto 2.4 × 1.2 / rebaixo 2.9 × 1.6, **184mm de engate em 8 segmentos** (seção média 2.20mm²) |
| Meia-luas | 4 (2 por lado curto, em ±16), boca 14.3mm, 3mm de profundidade, **chanfro 1.2 → V de 2.4mm** |
| Colmeia | **42 hexágonos de 4.2mm**, ponta pra cima, 0.6mm de baixo relevo |
| Massa | ~31g por moldura em PLA sólido, ~92g o conjunto montado + gabarito 13.4g |

**Folgas**: 0.3/lado no plano (peça solta em cavidade, padrão do repo);
**0.15/lado na espessura** — de propósito menor, porque quem fecha é a face de
plástico contra a outra, não a slab: folga demais em Z só faz a slab
chacoalhar. Degrau com 0.25/lado de deslize e **0.4 de sobra em profundidade**,
pro fundo do rebaixo **não** escorar no topo do ressalto — se escorar, as faces
não se tocam e o ímã perde contato.

> ⚠️ **A medida da slab não foi tirada com régua.** 84.5 × 139.5 × 7.2mm é um
> **envelope conservador** sobre o consenso de 5 fontes catalogadas pelo
> `../psa-box-01` (85.0 / 85.0×138.5 / 85.4×140.0 / 86.2×140.7 e o nominal PSA
> 83.6×134.4 × 7.1). O usuário foi consultado duas vezes e optou por não medir.
>
> O case original é **outlier**: medindo a malha do `Frame PSA - Small.obj`
> dentro do `../Main.3mf`, o bolso de slab dele é **81.0 × ~133.5 × 6.0mm** — a
> descrição de 80×135×6 é fiel à geometria *dele*, mas o nome "Small" e as
> outras 5 fontes indicam variante de slab menor, não a medida geral.
>
> **Imprima o gabarito primeiro** (13.4g) em vez de apostar ~62g nos dois lados
> da moldura. Trocar `slab_w`/`slab_h`/`slab_t` e re-exportar resolve: a cadeia
> inteira é derivada, e já foi conferido que mudar o envelope não pede
> redesenho — os quatro testes de acasalamento continuam passando.

## Por que degrau e não pino

A primeira versão alinhava com 2 pinos Ø3 × 2.5mm em diagonal. Pino fino
impresso **em pé** pega esforço de flexão na base, atravessando as linhas de
camada — a direção fraca do FDM — e sem filete de raiz. O degrau troca isso por
**184mm de engate de borda com 1.2mm de altura**: não tem o que quebrar.

**Não tem filete na raiz do ressalto, de propósito.** Filete engorda o macho
exatamente no plano da costura: 2.4 + 2×0.25 = 2.9 = a largura *inteira* do
rebaixo, ou seja folga zero e a peça deixa de fechar. O alívio equivalente foi
pra **boca da fêmea** (rebaixo abre 0.4mm nos 0.4mm de cima), que acomoda
qualquer barriga de extrusão na raiz sem comer a folga de alinhamento. O
argumento de resistência do pino também não transfere: o pino era Ø3 × 2.5 em
balanço com carga **pontual**; o ressalto é 2.4 × 1.2 (razão de aspecto 0.5)
com a carga espalhada por 184mm.

## Por que 10 pares de Ø4, e como o layout foi dimensionado

O ímã é o que o usuário **comprou**: neodímio **Ø4 × 2mm**, kit de 50 (20 em
uso, 30 de sobra). Ø4×2 em contato dá **~3.4-4.9 N por par** (catálogo N35), ou
seja o fecho inteiro fica em **~34-49 N (~4 kgf)** — contra os ~78-110 N que um
Ø8×2 daria. **Isso inverte o que segura a costura fechada**: não é mais a força
do ímã, é **o aro não flexionar** entre um ímã e o vizinho.

Por isso o layout foi dimensionado por **vão**, não por contagem. Com
`I = 12 · 5.75³/12 = 190.1 mm⁴` e `k = 48EI/L³`:

| vão entre ímãs | k (aro 9) | força pra abrir 0.3mm |
|---|---|---|
| 99mm (ímã só nas pontas do lado longo) | 17 N/mm | 5 N |
| 75mm | 39 N/mm | 12 N |
| **49.7mm (o que este layout usa)** | **167 N/mm** | **50 N** |

Layout final, ~50mm de espaçamento em todo o perímetro:

- **4 nos cantos**: (±47.05, ±74.55)
- **4 nos lados longos**: (±47.05, **±24.85**) → 3 vãos iguais de 49.7
- **2 nos lados curtos**: (0, ±74.55) → 2 vãos de 47.05

> ⚠️ O intermediário do lado longo vai na **posição** ±`my/3` = ±24.85, **não**
> em ±49.7, que é o **vão**. Ímã em ±49.7 deixaria o vão do meio com 99.4mm —
> k de 17 N/mm — pior que os 75mm que o adensamento veio consertar. É um erro
> fácil de cometer e a peça não reclama.

### E por que o aro desceu de 12 para 9

As **duas** justificativas dos 12mm caíram: com ímã Ø4 o bolso deixa 2.35mm de
parede (folgado), e a deflexão do aro sob os ~4 N de um par é **0.019mm com aro
12 contra 0.024mm com aro 9** — as duas irrelevantes. Rigidez **não exige** 12,
ela **permite** estreitar.

O que se compra estreitando: footprint **103.1 × 158.1** em vez de 109.1 × 164.1,
o que põe um brim de 5mm em **168.1 dos 180mm** (com aro 12 dava 174.1 — sem
margem). A colmeia acompanhou: `hex_d` de 6 → **4.2mm**, porque um hexágono de
ponta pra cima mede `2·hex_d/√3` de ponta a ponta e o de 6mm deixaria só 1.03mm
de material nos aros curtos — lasca. Com 4.2 a margem mínima é 2.07mm e a folga
real medida é 2.18mm.

## Ímãs: leia antes de montar

- **Ø4 × 2mm neodímio, 20 unidades** (10 pares). O kit do usuário tem 50, então
  sobram 30 — folga pra perder alguns na montagem e pra um segundo bumper.
- **Cola é OBRIGATÓRIA**, não é "se ficar frouxo". A ficha do produto confirma
  *"É autoadesivo: Não"*, e ao **abrir** o ímã da outra metade puxa cada disco
  **pra fora** do bolso — com Ø4 tem menos parede agarrando que com Ø8, então
  sem cola ele migra pra outra metade nas primeiras aberturas. Os 20 bolsos
  ficam voltados **pra cima** na impressão, então colar é trivial.
- **Bolso Ø4.3 (0.15/lado), não interferência.** Interferência nominal de
  0.075/lado é loteria: furo pequeno no A1 mini sai 0.05-0.2mm menor que o
  nominal, ou seja ou prensa forte ou fica solto. Quem segura é a cola.
- **Profundidade = 2.1mm** (não 2.0). 2.0 exato dá entreferro nominal zero mas
  tem orçamento de tolerância **zero**, e todo o erro vai **pra fora** — que é o
  lado ruim, porque disco saliente afasta as faces e abre a costura. Somam contra:
  tolerância do disco (±0.1), filme de cola (0.02–0.05) e quantização de camada
  (em 0.16mm a profundidade sai 1.96 → 0.04/lado de saliência). 2.1 custa ~17% de
  força ((2/2.2)² = 0.83) e compra 0.1/lado de margem. O filme de cola sai de
  graça com o **alívio de Ø2×0.3 no fundo do bolso**, pra a cola ter pra onde ir
  em vez de levantar o disco.
- **Confira a polaridade antes de colar**: uma cópia toda com N pra fora, a
  outra toda com S. Se as duas ficarem iguais, as metades se repelem.

## Colmeia hexagonal (identidade do repo)

Baixo relevo de 0.6mm na **face visível**, correndo a linha do meio de cada
aro. Regras que a malha respeita:

- fica **só em cima do aro** de 12mm, nunca em cima do lip de 2mm;
- faixa sólida de **≥2.54mm** até qualquer borda (nada de lasca);
- folga real de **≥3.96mm** de todo ímã e meia-lua — os aros curtos ficam com
  só 2 hexágonos por canto, porque o ímã do meio e as 2 meia-luas tomam aquela
  faixa inteira;
- o anel externo fica **100% sólido** em toda a volta, o que também segura a
  peça na mesa (a face texturizada é a que vai contra a cama);
- fica na face **oposta** ao degrau: entre o fundo do rebaixo e o fundo do
  hexágono sobram 3.55mm de material.

## Arquivos

- `psa-bumper-01.scad` — fonte paramétrico
- `3mf/psa-bumper-01-gauge.3mf` — **o job a imprimir PRIMEIRO** (gabarito, 13.4g)
- `3mf/psa-bumper-01-plate.3mf` — a moldura, **provisória** até o gabarito voltar
- `stl/psa-bumper-01-frame.stl`, `stl/psa-bumper-01-gauge.stl` — referência

## Impressão

```sh
# 1) o gabarito, que vem primeiro
flatpak run org.openscad.OpenSCAD -o 3mf/psa-bumper-01-gauge.3mf -D 'part="gauge"' psa-bumper-01.scad
flatpak run org.openscad.OpenSCAD -o stl/psa-bumper-01-gauge.stl -D 'part="gauge"' psa-bumper-01.scad
# 2) a moldura, depois de corrigir o envelope do slab
flatpak run org.openscad.OpenSCAD -o stl/psa-bumper-01-frame.stl -D 'part="frame"' psa-bumper-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/psa-bumper-01-plate.3mf -D 'part="plate"' psa-bumper-01.scad
```

- **1 moldura por chapa — imprimir a MESMA chapa 2x.** Duas molduras não cabem
  juntas na A1 mini em orientação nenhuma: cada uma precisa de 103.1mm no eixo
  curto (2× = 206.2 > 180) e a diagonal de 188mm impede girar. O `.3mf`
  **não** vem com as duas metades dentro.
- **BRIM OBRIGATÓRIO na moldura: brim ears nos 4 cantos, ou brim ≤ 2.5mm.** A
  planeza da face de encontro é funcional: 0.2mm de empeno no meio de um lado
  **dobra** o entreferro do ímã do meio, e anel comprido e baixo é candidato
  clássico a curvar as pontas. Com aro 9 o footprint é 103.1 × 158.1, então um
  brim de 5mm ainda fica em 168.1 dos 180mm — mas 2.5mm já resolve e sobra mais
  margem. O gabarito não precisa de brim (é maciço e baixo).
- **Sem suporte**, de boca pra cima (como exportado): nada em balanço, o
  ressalto sobe reto, o rebaixo é aberto em cima e a única ponte é o teto raso
  de cada hexágono, a 0.6mm da mesa.
- Aro em **9mm** — ver a conta acima. Não vale ajustar "pra fechar em nº inteiro
  de perímetros de 0.4": o Arachne do Bambu/Orca redistribui sobra de parede em
  linhas de largura variável, sem vazio e sem perder perímetro.

## Armadilhas de `include`/`-D` (as duas já custaram um teste falso-positivo)

Isto foi **medido**, não suposto — a versão anterior deste README tinha a causa
errada:

1. Variável **já atribuída no arquivo**: o `-D` substitui a atribuição no lugar e
   o valor **propaga pros derivados**. Medido: `a=1; b=a*10;` com `-D a=5` dá
   `b=50`. É assim que os controles de teste variam `step_h`, `step_w`,
   `groove_z`, `groove_w`, `mag_pocket_z` e `step_keepout`.
2. Variável que **só existe via `-D`** (os `*_override`): o `-D` a acrescenta no
   **fim** do escopo, então quando o ternário `is_undef(x_override) ? … : …` é
   avaliado ela ainda está `undefined`. Medido: com `-D x_override=85`, o
   `is_undef` no fim do arquivo já dá `false` mas `x` continua 80. Por isso
   variante se faz por **`include`**.
3. `part` e `mate_flip` funcionam por `-D` **inclusive através de `include`**
   (medido). O que **não** funciona é atribuí-los no arquivo que inclui: a
   atribuição do modelo sobrescreve (`part was assigned … but was overwritten`).

## Pendências

1. **IMPRIMIR O GABARITO E MEDIR A SLAB.** É a única pendência que bloqueia: a
   chapa da moldura é provisória até os três números voltarem. Depois é corrigir
   `slab_w`/`slab_h`/`slab_t` e re-exportar (a cadeia toda é derivada — conferido
   que trocar o envelope não pede redesenho).
2. Reconciliar a medida com o `../psa-box-01`, que usa outra estimativa.
3. Teste físico: confirmar se o V de 2.4mm com palheta vence os 17-25N de
   abertura.
4. Teste físico: confirmar se 0.25/lado no degrau fecha macio com 184mm de
   engate, ou se a folga precisa abrir.
5. Teste físico: confirmar se ~34-49N de fecho dá a sensação certa na
   prateleira. Se ficar frouxo, o caminho é mais pares (o kit tem 30 ímãs de
   sobra e o aro tem espaço no perímetro), não ímã maior.
