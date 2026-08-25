# xbox-stand-01

Suporte de mesa pra **controle de Xbox (Series X/S)**, versão **maciça**: bloco
baixo e liso, de **topo abaulado**, sem aletas e sem colmeia, com **dois berços
em vale** onde caem os dois punhos do controle. **Peça única**, sem montagem,
sem ferragem e **sem suporte de impressão**. Feito pra imprimir em **TPU**.

| | |
|---|---|
| Bloco | 60 × 170 × 25 mm (25 é o **coroamento**; a lateral tem 19,5 antes do rolamento R4) |
| Topo | **abóbada** de raio 230 mm, flecha 1,5 mm — não existe plano chapado nem aresta reta |
| Berços | 2, centros a ±62 mm (**124 entre centros**) |
| Boca do berço | **42** (profundidade) × **36** (comprimento) mm, no plano z = 24,04, com o centro **1,7 mm** pro lado do miolo |
| Mergulho | 21,54 mm, com **piso maciço de 2,5 mm** sob o ponto mais fundo (**o piso recebe carga** — ver abaixo) |
| Borda em volta da boca | **5,0 mm** na profundidade, **2,7 mm** até onde começa o rolamento da ponta (6,7 mm até a face externa), 84,6 mm de miolo |
| Encaixe do punho | **~17 a 20 mm** abaixo do plano da boca (faixa, não número — simulado com os dois berços; o máximo geométrico é 21,5) |
| Jobs | **1º** `3mf/xbox-stand-01-gauge.3mf` (170 × 60 × 13) → **depois** `3mf/xbox-stand-01-plate.3mf` (170 × 60 × 25) |
| Material | **TPU 95A**, 15% de infill — job cheio ~56 cm³ / **~68 g**; gabarito ~33 cm³ / **~40 g** |
| Balanço | **0,00 mm²** de face virada pra baixo fora do apoio na cama (medido na malha exportada) — não ligar suporte |

## Imprima o GABARITO primeiro

Nenhuma medida do controle veio de paquímetro (ver *Pendências*), e o job cheio
é de **~8–9,5 h e ~68 g**. O `part="gauge"` é a **fatia de cima da peça
inteira**, de z = 12 pra cima: 170 × 60 × **13 mm**, **~4,5–5,5 h e ~40 g**.

**Ele tem os DOIS berços, e isso não é luxo.** A versão anterior deste teste
era um cupom com **um** berço só — e um berço só deixa o punho **escorregar no
sentido do comprimento**, que é exatamente o movimento que a peça inteira
proíbe (o outro punho está preso no outro berço). O cupom da 2ª rodada lia
~21 mm de encaixe onde a peça inteira dava ~10: **+11 mm de falso positivo**, e
o deslocamento que ele permitia era *precisamente* o erro de projeto que a 3ª
rodada corrigiu. Ele diria "encaixe perfeito" numa peça errada. **Qualquer
gabarito honesto tem 170 mm de comprimento**, porque é essa a distância que
trava o Y.

### O que medir (é um número, não uma impressão)

O gabarito é vazado: a **ponta do punho sai pela face de baixo**.

1. Segure o gabarito no ar (não apoie na mesa — a mesa barra a ponta do punho).
2. Encaixe o controle por cima, **com a mão, sem forçar**, até ele parar.
3. Meça **quanto a ponta do punho sobra abaixo da face de baixo do gabarito**.

```
profundidade de encaixe = 12,04 + (o que sobrou por baixo)     [mm]
```

O **12,04** é o plano da boca (24,0396) menos o corte (12,000) — é aritmética
do corte, não predição de simulação. Faixas:

| leitura | encaixe | o que significa |
|---|---|---|
| sobra **≥ 9 mm** | ≥ 21 | a ponta chega no **prato** (o máximo geométrico é 21,5): o vale é mais fundo do que **este** punho precisa. É o **único** caso em que faz sentido fechar a boca, e só com sobra lateral evidente |
| sobra **5 a 9 mm** | 17 a 21 | **está certo** — é a faixa prevista (~17 a 20 mm) |
| sobra **3 a 5 mm** | 15 a 17 | um pouco curto, mas **ainda dentro do que a fonte permite**: o pior caso simulado (punho = negativo exato do bolso, folga zero) dá **4,7 mm** de sobra. Anotar o número e reportar |
| sobra **< 3 mm** | < 15 | o punho **empoleira** — não imprimir a chapa; **abrir** `cradle_x_open`/`cradle_y_open` |

**Não feche a boca se o punho empoleirar** (o README anterior mandava o
oposto): boca menor = punho parando ainda mais cedo. Fechar `cradle_x_open` /
`cradle_y_open` só faz sentido no caso de o punho **cair até o prato com sobra
lateral evidente**.

**ATENÇÃO — a faixa "está certo" mudou na 4ª rodada.** Até a 3ª, o README chamava
"sobra 3 a 6 mm" de *defeito* ("o punho está parando cedo") — mas a melhor
estimativa do caso **correto** cai exatamente ali. Quem imprimisse o gabarito
teria um resultado bom e reportaria como falha.

O corte em **z = 12** não é arbitrário: todas as reconstruções da descida põem
o aperto do punho **acima de z ≈ 14,7**, e com o bolso corrigido ele sobe ainda
mais (o punho para mais cedo, então o contato sobe junto). Abaixo do corte o
punho nem chega perto da parede que trava — o que o gabarito segura é o mesmo
que a peça inteira segura.

**Vale a pena?** O gabarito custa ~55% do job cheio — é caro pra um teste, e
não dá pra baratear sem mentir (os dois berços estão a 124 mm um do outro). Ele
existe porque as medidas do controle vêm de uma malha de terceiro, não de
paquímetro. Quem aceitar o risco pode pular direto pra chapa.

## Como se usa

O bloco fica deitado na mesa, com o lado comprido de frente pra quem senta. O
controle **desce de cima**: cada punho cai num berço e a "ponte" de baixo do
controle (a barra entre os punhos, com os gatilhos e o logo) passa **por cima**
do miolo de 84,6 mm que separa os dois berços — o miolo nunca encosta no
controle, ele só existe pra amarrar as duas metades da peça.

**O controle desce quase reto.** O ponto mais fundo do vale fica 4,5 mm pro
lado do fundo da mesa, então no *fim* do curso o punho está encostado na parede
de trás e o controle fica deitado pra trás — mas isso é o fim do movimento, não
é uma rampa que guia a entrada. Na boca as paredes já estão íngremes:

| parede | inclinação **local** na boca | ângulo de **corda** (boca → prato) |
|---|---|---|
| frente (−X) | **68,0°** | 44,4° |
| fundo (+X) | **77,0°** | 58,9° |
| fora (ponta do bloco) | **79,6°** | — |
| dentro (miolo) | **70,9°** | — |

O perfil é **côncavo**, então os ângulos de corda (que são o que aparece nos
`echo` do `.scad`) são uma **média** e não descrevem parede nenhuma. Quem
manda na sensação de entrada são os locais.

**Pra tirar:** puxa pra cima. Nas primeiras vezes convém **segurar o suporte
com a outra mão** — o punho fica plugado contra TPU, que tem atrito alto, e o
suporte pesa ~68 g contra 287 g do controle: ele é leve, não é âncora. Não tem
trava, não tem clipe e não tem undercut; o que segura é **profundidade de
encaixe** e mais nada.

## O vale: é aqui que mora a retenção

Como não há trava nem clipe, a retenção desta peça é **100% profundidade de
encaixe**. Cada milímetro que o punho sobe é retenção perdida.

### O centro do bolso — o erro que reprovou a 2ª rodada

A 2ª rodada só tinha a tabela de **vãos** da malha de referência, não a de
**centros**, e subiu `cradle_y_off` de 2 pra 4 pra comprar borda de topo. Com
os centros medidos, o erro aparece inteiro: a referência **segura o centro
embaixo** (chega a ir 0,96 mm pro lado do bico do bloco no meio da altura) e só
sobe ~1,7 mm no topo.

Centro do bolso por altura (mm, relativo ao centro do berço; **+** = pro miolo
do bloco):

| z | 4 | 8 | 12 | 16 | 20 | 24 (boca) | erro máx. |
|---|---|---|---|---|---|---|---|
| **referência** | −0,61 | −0,96 | −0,86 | +0,06 | +0,92 | +1,68 | — |
| 2ª rodada (`4,0·t`) | +1,40 | +2,35 | +2,92 | +3,36 | +3,73 | +4,00 | **3,78** |
| **agora** | −0,59 | −1,19 | −0,77 | +0,18 | +1,18 | +1,70 | **0,26** |

Duas causas somadas na 2ª rodada: `cradle_y_off` grande demais **e** a lei ser
linear em `t` — como `z ∝ t^2,5`, o `t` sobe cedo em `z` e o centro saía
correndo pro miolo já na primeira metade da altura. Agora:

```scad
ccy(t) = cradle_y_off·u − cradle_y_bow·(27/4)·u·(1−u)²      u = t^2,5
```

`u` é a **altura normalizada**, então o deslocamento é linear na *altura* (e
não no parâmetro do loft), e o `cradle_y_bow` é um **abaulamento pro lado da
ponta** que nasce e morre em zero. O `27/4` é `1/max[u(1−u)²]`, então
`cradle_y_bow = 1,7` quer dizer **1,7 mm de abaulamento máximo**, em milímetro
de verdade.

### O que isso compra

A **parede de fora** (a virada pro bico do bloco) é quem trava o punho. Posição
dela contra a referência:

| z | 8 | 10 | 12 | 14 | 16 | 18 | 20 | 22 |
|---|---|---|---|---|---|---|---|---|
| referência (tabela corrigida) | −12,21 | −13,26 | −14,36 | −14,65 | −14,89 | −15,26 | −15,63 | −16,05 |
| 2ª rodada | −9,00 | −9,76 | −10,40 | −10,97 | −11,48 | −11,95 | −12,38 | −12,79 |
| **agora** | −12,54 | −13,50 | −14,10 | −14,46 | −14,66 | −14,80 | −14,93 | −15,13 |

A linha da referência é reconstruída das tabelas de **vão** e de **centro**
(centro − vão/2), que têm resolução de 0,1 mm — as duas casas são aritmética,
não precisão de medida.

Erro contra a referência: de **+3,2 a +4,0 mm** → de **−0,3 a +0,7 mm** (e
+0,9 em z = 22). O erro que sobra é todo do **mesmo sinal na metade de cima**:
a parede do modelo fica *por dentro* da referência lá em cima, e é exatamente
isso que come inserção.

Profundidade de encaixe, com o punho preso pelos **dois** berços:

| | encaixe abaixo da boca |
|---|---|
| 2ª rodada (`cradle_y_off` = 4,0) | **~10 mm** — o punho empoleira |
| `cradle_y_off` = 1,7, sem o abaulamento | ~15,5 mm |
| **agora** (1,7 + abaulamento 1,7) | **~17 a 20 mm** — ver abaixo |
| máximo geométrico (ponta encostando no prato de 2,5) | 21,5 mm |

Essa tabela compara **leis diferentes contra o mesmo bolso**, então o que ela
mede com confiança é a **diferença entre as leis** — e não o valor absoluto, que
é justamente o que a fonte não sustenta (item 3 logo abaixo). O `print-review`
refez a simulação por conta própria e chegou em ~9,7 / ~15,6 / ~16,4 / ~20,1 nos
quatro cenários — mesma ordem, mesmo veredito, e é por isso que **nenhum desses
números aparece aqui com duas casas decimais**.

### A faixa honesta: ~17 a 20 mm

O que este projeto declara é uma **faixa**, e ela vem de três coisas:

1. **Pior caso, folga zero.** Com o punho = negativo exato do bolso **medido**
   (tabela já corrigida), a lei entregue dá **~16,7 mm** — a ponta para a
   **4,80 mm** do prato. Um punho de verdade é *menor* que o bolso, então o
   valor real mora **acima** disso.
2. **A sensibilidade é brutal.** Perto da boca a parede está a **74–80°**, então
   cada milímetro de folga **por lado** em Y vale **5,6 mm de inserção**:

   | folga por lado (Y) | 0 | 0,25 | 0,50 | 0,75 |
   |---|---|---|---|---|
   | encaixe (mm) | 16,7 | 18,1 | 19,5 | 20,9 |

3. **A fonte não amostra a parede que trava.** A malha de referência é vazada
   por aletas (**37 fendas de 1,95 mm a passo 4,55**) e as *fendas* caem em cima
   da parede de fora em toda a faixa que trava — a posição dessa parede entre
   **z = 12 e z = 24 não é amostrada**. Só com dados exatos de nervura a
   inserção fica em qualquer ponto de **[9,5 ; 21,1]**; com interpolação suave
   entre as linhas de nervura, **17 a 20 mm**.

Quem mede o valor real é o **gabarito**.

### Como esses números são calculados

Simulação de descida: o **punho é o negativo exato do bolso da referência**
(folga zero — pior caso possível; um punho de verdade é menor e desce mais),
amostrado a cada 0,05 mm de altura. Ele desce nos **dois** berços ao mesmo
tempo, o que **trava o Y** (deslocar o controle no comprimento ajuda um punho e
atrapalha o outro na mesma medida, então o ótimo é zero) e deixa o **X livre**.
Encaixe = plano da boca (24,04) menos o z onde a ponta do punho para.

É a mesma simulação que mede o falso positivo do teste de um berço só: com um
berço, o punho escorrega e a leitura vai direto ao **máximo geométrico
(21,5 mm)**, qualquer que seja o encaixe real.

### Vão do vale por altura

| z | 4 | 6 | 8 | 10 | 12 | 14 | 16 | 18 | 20 | 22 | boca |
|---|---|---|---|---|---|---|---|---|---|---|---|
| referência (profundidade, X) | 17,4 | 21,9 | 25,8 | 29,0 | 31,6 | 33,6 | 35,4 | 37,0 | 38,5 | — | 42,0 |
| **modelo (X)** | 18,55 | 23,21 | 26,42 | 28,99 | 31,17 | 33,09 | 34,82 | 36,40 | 37,86 | 39,22 | 42,0 |
| referência (comprimento, Y) | 14,6 | 18,5 | 22,5 | 24,7 | **27,0** | 28,5 | 29,9 | **31,5** | **33,1** | **34,7** | **36,4** |
| **modelo (Y)** | 16,13 | 20,02 | 22,69 | 24,83 | 26,65 | 28,25 | 29,69 | 31,01 | 32,23 | 33,37 | 36,0 |

**A coluna Y em negrito foi remedida na 4ª rodada.** O valor antigo de z = 18
(29,9) era cópia do de z = 16 — artefato de amostragem, que pegou a mesma
fileira de aletas nas duas alturas. Um bolso que *estreitasse* subindo seria
undercut e não existe. A remedição reconstrói a superfície nas **linhas de
nervura** (37 fendas de 1,95 mm a passo 4,55); a extrapolação por coluna até
z = 24 dá vão **36,34** e centro **+1,69**, contra os **36,40 / +1,68** medidos
direto na boca — bate em 0,06 e 0,01.

O **"erro ≤ 0,64 mm" vale só em X** (profundidade), no trecho z = 8..20. **Em Y**,
contra a tabela corrigida, o modelo fica em **+0,2 / −0,9 mm** nesse mesmo
trecho, mas é **~1,5 mm mais largo** em z = 4..6 e **~1,3 mm mais estreito** em
z = 22 (e 0,4 mais estreito na boca, porque `cradle_y_open` = 36 e a referência
mede 36,4). O estreitamento lá em cima é o que come inserção.

### O piso recebe carga

A 2ª rodada documentou o contrário ("o punho assenta nas paredes, o piso não
recebe carga") e usou isso pra justificar baixar o piso de 3,0 pra 2,5 mm. **O
piso de 2,5 continua certo; a justificativa estava de cabeça pra baixo.** Com o
centro corrigido, a ponta do punho de pior caso (folga zero) para a **4,80 mm**
do prato usando o **bolso medido** — e um punho real, que é *menor* que o
bolso, **encosta**. (O 1,45 mm que este README declarava era do punho
**sintético**, o negativo da própria lei do modelo; com o bolso medido são
4,80. O piso de 2,5 fica certo nos dois casos.)

Os 2,5 mm são dimensionados pra isso. O prato é um retângulo arredondado R2,5
de 7 × 6,5, ou seja `7·6,5 − (4−π)·2,5² =` **40,1 mm²** por berço e
**80,3 mm²** nos dois (o "~91 mm²" de antes ignorava os cantos arredondados).
287 g ali dão **~0,035 MPa**, longe de qualquer coisa que amasse TPU 95A
maciço.

## Topo abaulado e borda da ponta

A 1ª rodada tinha o topo **chapado** com uma **fita** de 2,0 mm dando a volta
em cada berço na última camada — em TPU isso enrola e o bico arrasta. **Quem
resolveu foi a abóbada**: raio 230 mm, flecha 1,5 mm do coroamento até a borda
do topo, convexa **pra cima** (cada camada é menor que a de baixo, então
continua zero balanço). Acabou o plano chapado, acabou a aresta reta e **acabou
a fita fechada**.

Com a abóbada, a **última camada tem 3 pedaços**: a tira do coroamento
(~19 × 80 mm) e duas plaquinhas nas pontas. O `print-review` fatiou a peça
(interseção com lajes de 0,2 mm, contando sólidos pelo `Volumes:` do CGAL):

- com `margin_end` = 5,0 (a 2ª rodada) as plaquinhas mediam **6,2 × 19 mm**;
- com `margin_end` = **2,7** (agora) medem **4,0 × 19 mm** — ~10 extrusões no
  lado curto, e **nenhuma delas é ilha** (a camada de baixo é maior).

Por isso o `assert` da borda da ponta caiu de 4,5 pra **2,5 mm**: com o centro
do bolso certo ele estava brigando com a função. `margin_x` continua **5,0**.

A boca do berço mora no **plano da abóbada em x = ±21** (z = 24,04), então os
42 mm são 42 mm **de verdade na superfície**, e o filete R1 morre tangente ao
topo exatamente ali. Nas duas pontas da boca (onde a abóbada está no
coroamento) sobra uma tirinha vertical de **0,96 mm** — é o preço de ter
abóbada e boca plana ao mesmo tempo, e é vertical, não é balanço.

## TPU e 15% de infill fazem parte do projeto

**"Maciço" aqui é FORMA sólida, não parede cheia.** O bloco é liso e sem
vazados; a **maciez vem do fatiador**. Se fatiar isto em PLA a 100% de infill
sai um tijolo de **264 g** (258 g em TPU).

| | |
|---|---|
| Filamento | **TPU 95A**, **SECO**, **spool EXTERNO** — não passar TPU pelo AMS lite |
| Infill | **15%**, padrão **gyroid** |
| Paredes | 2 |
| Topo / fundo | **5 camadas de topo, 4 de fundo** |
| Camada | 0,2 mm |
| Velocidade | 20–30 mm/s (parede externa 15–20), aceleração baixa |
| Retração | **0,4–0,8 mm a ~20 mm/s**, com **combing / "avoid crossing walls" LIGADO** |
| Temperatura | ~230–240 °C bico, cama 35–45 °C |
| Suporte | **NÃO** — 0,00 mm² de face virada pra baixo fora do apoio na cama |
| Brim | não precisa (1ª camada: 10 186 mm² na chapa, 8 760 mm² no gabarito) |
| Tempo estimado | **~8–9,5 h** no job cheio, **~4,5–5,5 h** no gabarito |

**Por que 5 camadas de topo:** pela **abóbada**. São 52 × 162 mm de superfície
quase plana (1,5 mm de queda em 52 mm de vão) apoiada só em gyroid a 15% — é
ali que mora o risco de *pillowing*. **Não** é pelo fundo do vale: a parte
quase plana do fundo do vale mede ~17,6 × 15,3 mm e assenta em **2,5 mm de TPU
maciço**, sem vazio nenhum pra cobrir. (A decisão estava certa desde a 2ª
rodada; o motivo documentado é que estava trocado.)

**Por que retração baixa e combing:** TPU é elástico, então retração longa
descola o filamento do engrenamento e é a origem clássica do entupimento; com
combing ligado o bico quase não precisa retrair, porque não cruza paredes.
Spool externo pelo mesmo motivo — o caminho do AMS lite é longo e curvo demais
pra filamento mole.

**Espere a chapa esfriar COMPLETAMENTE antes de tirar a peça.** São 10 186 mm²
de TPU 95A grudados na chapa texturizada: quente, ele sai deformado (ou leva
junto um pedaço do primeiro layer). Frio, solta sozinho com uma flexão da
chapa.

Estimativa de material (2 paredes de 0,42 + 5/4 camadas de casca a 0,2 + 15% de
infill, TPU a 1,21 g/cm³, sobre as áreas **medidas na malha**): job cheio
**~56 cm³ / ~68 g** (212,95 cm³ de sólido), gabarito **~33 cm³ / ~40 g**
(99,36 cm³ de sólido). Superfície inclinada ganha camada sólida extra, então
contar 65–80 g e 38–48 g. **O fatiador é quem dá o número final.**

Em PLA a peça também imprime, mas aí ela vira só um calço duro: o projeto
inteiro (berço grande, sem trava, parede de trás curta) conta com o TPU
deformar e **abraçar** o punho.

## Estabilidade — os números honestos

Medido na malha: o suporte tem CG em **z = 11,48 mm** e **x = −0,13 mm**
(praticamente na linha de centro). Com o controle a **287 g** e o suporte a
**~68 g** (4,2×):

- a borda de tombamento está a **30 mm** da linha de centro → o CG do controle
  pode ir até **37,1 mm** atrás do centro antes do conjunto tombar;
- com o CG do controle 15–25 mm atrás do centro e a ~55 mm de altura, o CG do
  conjunto fica a ~46,6 mm de altura e 12–20 mm atrás → sobra uma inclinação
  extra de **~12–21°** antes de tombar pra trás.

Continua sendo **apoio de mesa, não suporte de parede** — e as **pilhas AA** do
controle do Series X ficam no alto e atrás, o que empurra a conta pro lado ruim
da faixa.

## De onde vieram os números — e a licença

O conceito é o `../../diversos/Xbox_Controller_Stand_lines_by_Pork3D.3mf`
(autor **Pork3D**, *Standard Digital File License* — **não redistribuível**, e é
por essa família de licenças que este repositório é privado).

**Nada daquele arquivo foi copiado, importado ou convertido.** Dele saíram só
**números de referência medidos na malha** — bloco 170 × 50 × 25, berços a ±62
do meio, boca do bolso ~42 × 36, mergulho de ~24 mm com o fundo deslocado
~4,5 mm da linha do meio, **o vão da seção a cada 2 mm de altura e o centro da
seção a cada 4 mm de altura** (as duas tabelas lá em cima). Toda a geometria
aqui é remodelada do zero em OpenSCAD, no mesmo precedente do `bgs-stand-01`.

O original é **vazado por aletas verticais paralelas** ("lines"); este é o
oposto — **bloco maciço e liso, mesma função**, que foi o pedido do usuário.

## O que mudou em relação ao original, de propósito

1. **Piso de 2,5 mm** sob o ponto mais fundo (o original tem ~1,0 mm). 1 mm de
   TPU no fundo de um vale de 42 mm de boca é membrana — e o piso **recebe a
   carga da ponta do punho**. O preço: o mergulho aqui é 21,54 mm contra os
   23,5 mm da referência.
2. **Tudo arredondado**: cantos em planta e rolamento da aresta de topo com o
   mesmo R4 (hull de 4 "pinos" com uma corrente de esferas seguindo a abóbada —
   a soma de Minkowski feita à mão, sem o custo do `minkowski()`).
3. **Topo abaulado** em vez de chapado, e **profundidade 60** em vez de 50: o
   rolamento R4 come 4 mm do topo e a boca de 42 precisa de **5 mm de borda
   inteira** de cada lado pra não virar fita fina de TPU. A boca é o número que
   **não** se pode encolher — 42 mm é o que a referência reserva pra grossura do
   punho, e apertar isso faz o controle **empoleirar na borda** em vez de descer
   no vale.

## Sem colmeia — exceção consciente

Este é o segundo modelo do repo **sem** a colmeia hexagonal da regra 5 do
`CLAUDE.md` (o primeiro é o `deckbox-03`). O usuário pediu **maciço e liso**,
explicitamente. **Não "consertar" pondo hexágono.**

## Por que não precisa de suporte

Quatro superfícies, todas olhando pra cima ou pro lado: (a) o vale é um *loft*
cujas quatro bordas de seção só **andam pra fora** conforme sobem — a
meia-largura é linear em `t` e o centro anda devagar o bastante **nos dois
sentidos**, e é isso que os `assert` de `ccy_slope_max`/`ccy_slope_min` guardam
numericamente (**+11,15** e **−3,49** contra o limite de **±13,79**: o de cima
protege a parede de fora, o de baixo a de dentro — o guarda era assimétrico até
a 4ª rodada, e `cradle_y_bow` está exposto como parâmetro);
(b) o filete da boca também só abre subindo; (c) a abóbada é convexa
pra cima, cada camada menor que a de baixo; (d) o resto é chão chapado e parede
vertical.

Auditoria nas duas malhas exportadas (chapa e gabarito): fora o apoio na cama,
a área de faces viradas pra baixo é **0,00 mm²** nas duas. Não existe nenhuma
face entre 0° e 45° da horizontal.

## Parâmetros que valem a pena mexer

| parâmetro | o que faz |
|---|---|
| `cradle_gap` | distância entre os centros dos berços — é o que muda de controle pra controle |
| `cradle_x_open` / `cradle_y_open` | boca do berço; **abrir** se o punho empoleirar (nunca fechar por esse motivo) |
| `cradle_y_off` | quanto a **boca** é deslocada pro miolo do bloco (medido: 1,7) |
| `cradle_y_bow` | quanto o bolso **abaula pro lado da ponta** no meio da altura (medido: 1,7). 0 = centro linear na altura |
| `cradle_pow` | expoente do perfil: **maior** abre o meio da parede, **menor** fecha |
| `cradle_floor` | piso maciço sob o fundo do vale (mínimo 2,0) — **recebe carga** |
| `cradle_x_off` | deslocamento do fundo = quanto o controle acaba o curso deitado pra trás |
| `vault_rise` | flecha da abóbada; 0 volta ao topo chapado |
| `mouth_fillet` | filete da boca (R1 padrão, sempre por dentro dos 42 × 36) |
| `round_r` | raio dos cantos **e** do rolamento de topo (os dois juntos, por construção) |
| `cradle_steps` | fatias do loft (24 → desvio geométrico de 0,017 mm, 12× abaixo da camada) |
| `gauge_z` | altura do corte do gabarito (12,0; o `assert` não deixa passar de 12,5) |

Variante se faz por **include**, nunca por `-D` (os `*_override` só existem via
`-D` e o `is_undef()` do ternário é avaliado antes):

```scad
cradle_gap_override = 110;
include <xbox-stand-01.scad>
```

## Diagnósticos (não são peças)

```
openscad -o /abs/.../corte.png -D 'part="cut_depth"' xbox-stand-01.scad  # perfil do vale + piso + abóbada
openscad -o /abs/.../corte.png -D 'part="cut_len"'   xbox-stand-01.scad  # os dois berços em corte — é aqui que se vê o centro do bolso por altura
```

## Pendências

- **Não foi impresso nem testado na mão.** O veredito é o controle na peça —
  e o primeiro teste é o **gabarito**.
- As medidas do controle são as **da malha de referência**, não de paquímetro —
  decisão explícita do usuário (em TPU o berço deforma e acomoda folga).
- A simulação de descida usa o punho de **pior caso** (folga zero contra o bolso
  da referência) e o **contorno das seções por eixo**, não a forma redonda
  completa. **O encaixe declarado é uma faixa (~17 a 20 mm) e os 20 são a ponta
  OTIMISTA dela**, não um valor conservador — este README dizia o contrário até
  a 4ª rodada. A ponta pessimista da interpolação é 17, e o pior caso de folga
  zero é ~16,7. O gabarito é quem mede o valor real.
- **A fonte não amostra a parede que trava.** As fendas das aletas da malha de
  referência caem em cima da parede de fora em toda a faixa que segura o punho,
  então a posição dela entre z = 12 e z = 24 é *reconstruída*, não medida. Só
  com dados exatos de nervura a inserção fica em qualquer ponto de [9,5 ; 21,1].
- O tempo e o peso de impressão são **estimativa calculada**, não saída de
  fatiador. Abrir o 3MF no Flash Studio confirma os dois.
