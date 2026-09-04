# Organizadores TCG

Caixas e organizadores para cartas de TCG — soltas, com sleeve, em toploader
ou **graduadas (slabs PSA/BGS)** — modelados em OpenSCAD e impressos na
FlashForge AD5X.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [slab-tile-01](./slab-tile-01/) | 🚧 em andamento | sistema MODULAR: tile de UMA slab que encaixa por rabo-de-andorinha formando pagina de fichario 2x2/3x3/4x4, paginas empilham em torre. Aceita PSA/CGC/TAG/SGC (fora Beckett e ARS) com tres molas de lamina que autocentram a slab — sao 7mm entre a PSA e a SGC. 2 tiles por chapa (209.9 x 155.2mm) |
| [psa-box-01](./psa-box-01/) | 🚧 em andamento | caixa de 38 slabs PSA nuas em duas filas de 19, base + tampa telescópica, **fechada contra luz** (colmeia em baixo relevo, nada passante); 176.4 × 175.1mm, 2 jobs + gabarito de teste (folgado na cama de 220 da AD5X) |
| [penny-holder-01](./penny-holder-01/) | 🚧 em andamento | caixa de cartas com **penny sleeve deitadas na aresta longa, em 2 camadas** (~300 cartas), derivada do `PennySleeveHolder_Stackable_Colmeia_80mm.3mf` (Sazabi) — mesma pegada de 74.2 × 102.7, mas **150mm de altura** em vez de 80. Gaveta de fichário em pé: boca aberta em cima e **janela de vão contínuo na frente, do piso ao alto, sem travessa no meio**; quem amarra os lados é a **cinta de 8mm** que fecha a volta no topo, o piso em colmeia de 10mm e os dois montantes de 8mm que viram flange de canto em L. Empilhável (ressalto de 3mm + chaveta que só deixa encaixar numa orientação). Colmeia passante nas laterais e no fundo (47 furos) com **bico de 45°**, colmeia regular de 24mm no piso. ~97g, sem suporte. ⚠️ A medida da carta (66 × 91) é **catálogo, não régua** — ver o bloco abaixo. ⚠️ Com 2 camadas e sem prateleira, **a camada de baixo é arquivo, não é a de giro** (ver README do modelo) |
| [toploader-holder-01](./toploader-holder-01/) | 🚧 em andamento | dispenser **2-em-1 de top loader (em cima) e penny sleeve (embaixo)**, 84 × 109 × **150mm**, derivado do `2-in-1_Top_Loader___Sleeve_Holder.3mf` (HeyHalo, **CC0**) — mesma ideia, mas 150mm em vez de 84, o que leva o curso de top loader de 50 pra **116mm (~40 → ~92 peças)**. **Quem separa os dois conteúdos é a gravidade**: um DEGRAU a 34mm do chão deixa o bolso de baixo com 71mm de vão, estreito demais pro top loader (76,2 → para no degrau com 2,6/lado de apoio) e folgado pro penny sleeve (66,7 → cai livre). Sem divisória, sem prateleira, sem ponte — e como o material RECUA subindo, o degrau tem **balanço zero**. Boca aberta em cima, janela de vão contínuo de 60 × 138 na frente e cinta de 8mm fechando a volta no topo. Colmeia passante de 18mm com bico de 45° nas laterais e no fundo, só **acima** do degrau (o bolso fica maciço: sleeve mole faz barriga pelo furo). ~197g, **sem suporte** — auditado, 100% da área virada pra baixo está a 45°. ⚠️ As medidas de top loader e sleeve são **catálogo/engenharia reversa, não régua** — ver o bloco abaixo |
| [bgs-stand-01](./bgs-stand-01/) | 🚧 em andamento | suporte de mesa pra UMA slab **Beckett (BGS)**, inclinada 12°, em **duas peças (suporte + tampa que encaixa)**, ambas **sem suporte de impressão**. **Primeiro modelo do repo com medida real de PAQUÍMETRO** (82.5 × 130.2 × 8.5, medida em 2026-08-11). A slab fica presa nos quatro lados e só sai por cima — puxa a tampa e ela desliza pra fora. Como a tampa é removível, a slab não precisa bascular pra entrar: isso libera os trilhos a terem aba (captura de verdade) e deixa a **tampa fechar ACIMA da aresta da slab, sem cobrir nada da face — a etiqueta de nota fica 100% visível**. Encaixe por ranhura sobre o painel + batente nos topos dos trilhos, 0.25mm/lado. Chapa 56.8 × 87.3 × 142.6mm, 0.0mm² de balanço nas duas peças |

## A subpasta `display-box-graded/`

`display-box-graded/psa/my_psa_slab.3mf` é **arquivo de terceiro**
(Functional3D, MakerWorld), guardado numa subpasta só porque veio assim do
download. É a fonte de medidas de referência do
[`bgs-stand-01`](./bgs-stand-01/) — inclinação 11,9°, canal de 81,0mm, painel
de ~3mm — e está catalogado no `third_party` do `index.json` como todo o
resto. Não é modelo paramétrico do repo.

## Os `.3mf` soltos na raiz desta pasta

Todos os `.3mf` que estão direto nesta pasta (sem subpasta de modelo) são
**downloads de terceiros**, guardados como referência e material de estudo.
Não são modelos paramétricos do repo: não têm `.scad` e não seguem as
convenções, então não entram no `index.json` como **projeto** — desde
2026-08-09 eles são catalogados à parte, no array `third_party` do
`index.json` (autor, licença, footprint da maior peça e perfil de fatiador
embutido).

> **Licença:** quase todos são *Standard Digital File License*, *MakerWorld
> Exclusive* ou *BY-NC-SA*, que **não permitem redistribuição**. Foi por isso
> que o repositório virou **privado** em 2026-08-09. Não republicar.

> **Nota 2026-08:** os modelos paramétricos `psa-bumper-01` e `psa-bumper-02`
> foram **removidos do repo** (substituídos pelos bumpers de terceiro em
> [`bumpers/`](../bumpers/)). O bloco de medidas de slab abaixo fica como
> **registro histórico**; dos modelos PSA paramétricos, só o `psa-box-01` continua.

> **Atualização 2026-08-11 — a primeira medida real chegou.** O usuário mediu
> uma slab **Beckett (BGS)** com **paquímetro**: **82.5 × 130.2 × 8.5mm**. É a
> medida que o `bgs-stand-01` usa. Duas ressalvas antes de propagar pros outros
> modelos: (1) **Beckett não é PSA** — são marcas diferentes, com carcaças
> diferentes, então isso não fecha a questão da slab PSA; (2) ainda assim, 82.5
> de largura cai **abaixo** de todas as estimativas de PSA adotadas aqui
> (83.6–86.2), o que reforça a suspeita de que os números grandes estão
> inflados.
>
> **Correção de fonte (2026-08-11):** o `my_psa_slab.3mf` era citado como fonte
> de "85.00 × 138.52" pra largura de slab. **Está errado** — 85.00 × 138.52 é o
> envelope externo do *suporte*, não da slab. Medindo a malha dele, o canal de
> slab tem **81.0mm** (e o autor escreve "within 81mm in width"). Ou seja, essa
> fonte aponta pra slab MENOR que 81, não maior que 85: some uma das "fontes
> grandes" e o rótulo de *outlier* do `psa-bumper-02` fica bem menos justificado.
>
> **Atenção: nenhuma medida de slab PSA deste repo saiu de régua ou paquímetro.**
> Os **três** modelos PSA rodam em cima de medida de terceiro:
>
> - `psa-bumper-01` usa **84.5 × 139.5 × 7.2mm**, um envelope conservador sobre
>   o consenso de 5 fontes (85.0 / 85.0×138.5 / 85.4×140.0 / 86.2×140.7 e o
>   nominal PSA 83.6×134.4 × 7.1);
> - `psa-box-01` usa ~83.6–85 × 134–140 × 7.1mm, de engenharia reversa de malhas;
> - `psa-bumper-02` usa **80.27 × 135.37 × 5.83mm**, que é o bolso medido na
>   malha do `Trading_card_bumper_-_PSA(2).3mf`. **É o menor de todos**, e a
>   escolha de copiá-lo foi do usuário, avisado deste bloco. Risco assumido: se a
>   slab não entrar, o conserto é trocar `slab_w`/`slab_h`/`slab_t` e re-exportar.
>
> Os dois arquivos de terceiro que servem de base são **outliers pequenos**, e do
> mesmo jeito: o `bumper_main.3mf` (ex-`cardholders/Main.3mf`, hoje em
> [`bumpers/`](../bumpers/); medindo a malha do `Frame PSA - Small.obj` dele) tem
> bolso de **81.0 × ~133.5 × 6.0mm** e o `Trading_card_bumper_-_PSA(2).3mf` tem
> **80.27 × 135.37 × 5.83mm**. As descrições são fiéis à geometria *deles* — mas
> as outras 5 fontes indicam variante de slab menor, não a medida geral. (No
> caso do bumper de TPU tem um agravante: TPU **estica**, então um bolso apertado
> lá não prova que a slab é pequena.)
>
> **O mesmo vale para carta com sleeve, não só para slab.** O
> `penny-holder-01` usa **66 × 91mm** (carta 63 × 88 + penny sleeve), que é
> **catálogo, não régua**. O usuário foi consultado e optou por seguir assim.
> A caixa inteira é derivada desses dois números — altura = `10 + camadas×66 +
> 8`, profundidade = `91 + 6,5 + 5,2` — então trocar `card_w`/`card_h` e
> re-exportar conserta o modelo todo. Em Z o efeito é alavancado: **cada 1mm a
> mais de largura de carta cresce 2mm na altura da caixa**, e o teto de 180 da
> AD5X só é atingido com `card_w = 81`.
>
> Uma medida de régua resolve o `psa-box-01` (e os outros modelos de slab PSA
> que vierem a existir) de uma vez: é trocar os parâmetros de slab e re-exportar.
> O `psa-box-01` já traz seu próprio **gabarito de teste** como job de medição.

O `psa-box-01` nasceu de um deles: a geometria das vagas foi tirada por
engenharia reversa da malha do `Porta_carte_PSA_x10.3mf`, e as medidas da
slab foram cruzadas com `my_psa_slab.3mf` e `Slab_Protectors.3mf` — que
**divergem entre si**. Está tudo documentado no README do modelo; é o motivo
de existir um job de gabarito antes da caixa grande.

## Parâmetros que costumam definir um organizador de slabs

- **Medidas da slab** — a única medida de consenso entre as fontes é a
  espessura (~7.1mm); largura e altura variam de 83.6 × 134 a 85 × 140
  conforme a fonte, e é o que decide se o projeto cabe na cama
- **Passo da vaga** (espessura da slab + folga + divisória)
- **Quanto a slab sobra pra fora** — é a pegada da mão; sem isso não se tira
  uma slab do meio de uma fila cheia
- **Altura das nervuras** — se subirem demais, as slabs não abrem em leque
- **Footprint × cama** — duas filas de slab já comem ~169mm dos 180 da A1
  mini, então wall, espinho e folga disputam 11mm
- **Luz** — carta graduada desbota com UV. Se a peça for de guardar (e não de
  expor), nada que dá pro lado de fora pode ser passante: a colmeia da
  identidade do repo entra como **baixo relevo**, não como furo. Custa peso
  (no `psa-box-01` foram +114g), então é decisão de projeto, não default.
