# Organizadores TCG

Caixas e organizadores para cartas de TCG — soltas, com sleeve, em toploader
ou **graduadas (slabs PSA/BGS)** — modelados em OpenSCAD e impressos na
Bambu Lab A1 mini.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [psa-box-01](./psa-box-01/) | 🚧 em andamento | caixa de 38 slabs PSA nuas em duas filas de 19, base + tampa telescópica, **fechada contra luz** (colmeia em baixo relevo, nada passante); ocupa a cama inteira da A1 mini (176.4 × 175.1mm, 2 jobs + gabarito de teste) |
| [psa-bumper-01](./psa-bumper-01/) | 🚧 em andamento | bumper clamshell de VITRINE pra UMA slab PSA: duas metades iguais de moldura, janela de vão único (carta + etiqueta juntas, dá pra ver frente e dorso), 10 pares de ímã Ø4x2 + degrau perimetral de alinhamento; aro de 9mm, 103.1 × 158.1 × 11.5mm fechado, 1 moldura por chapa (imprimir a mesma chapa 2x). **Acompanha gabarito de medição do slab (13.4g) que é o job a imprimir PRIMEIRO** — a chapa da moldura é provisória até a medida voltar. Não é à prova de queda, por escopo |
| [penny-holder-01](./penny-holder-01/) | 🚧 em andamento | caixa de cartas com **penny sleeve deitadas na aresta longa, em 2 camadas** (~300 cartas), derivada do `PennySleeveHolder_Stackable_Colmeia_80mm.3mf` (Sazabi) — mesma pegada de 74.2 × 102.7, mas **150mm de altura** em vez de 80. Gaveta de fichário em pé: boca aberta em cima e **janela de vão contínuo na frente, do piso ao alto, sem travessa no meio**; quem amarra os lados é a **cinta de 8mm** que fecha a volta no topo, o piso em colmeia de 10mm e os dois montantes de 8mm que viram flange de canto em L. Empilhável (ressalto de 3mm + chaveta que só deixa encaixar numa orientação). Colmeia passante nas laterais e no fundo (47 furos) com **bico de 45°**, colmeia regular de 24mm no piso. ~97g, sem suporte. ⚠️ A medida da carta (66 × 91) é **catálogo, não régua** — ver o bloco abaixo. ⚠️ Com 2 camadas e sem prateleira, **a camada de baixo é arquivo, não é a de giro** (ver README do modelo) |
| [psa-bumper-02](./psa-bumper-02/) | 🚧 em andamento | bumper clamshell de VITRINE pra UMA slab PSA, reprojeto em **PLA rígido** do `Trading_card_bumper_-_PSA(2).3mf` (que é peça única em TPU e depende de um lábio flexível de 1mm — em PLA não funciona). Duas metades iguais que fecham por cima e por baixo e travam por **4 pinos Ø3 impressos** de press-fit em padrão diagonal (2 pinos + 2 furos por metade, **sem ímã e sem parafuso**), alinhadas por degrau perimetral de 180.7mm; janela nos dois lados, 52 hexágonos em baixo relevo; aro de 9mm, 98.87 × 153.97 × 11.13mm fechado, **30.9g por metade**. **A diagonal da peça é 182.98mm, então duas metades NUNCA dividem chapa** — 1 metade por job, imprimir a mesma chapa 2x. ⚠️ Usa o envelope de slab do arquivo de origem (80.27 × 135.37 × 5.83), que é o **outlier pequeno** das 6 fontes — escolha consciente do usuário, e o risco está assumido. Não é à prova de queda, por escopo |

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

O `psa-bumper-01` também: ele é o `Main.3mf` (PSA Graded Card Case, do
MaskForge) sem a travessa central da janela e sem tampa deslizante — virou
clamshell de duas metades iguais fechado por ímã.

> **Atenção: NENHUMA medida de slab deste repo saiu de régua.** O usuário foi
> consultado três vezes e optou por não medir, então os **três** modelos rodam
> em cima de medida de terceiro:
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
> mesmo jeito: o `Main.3mf` (medindo a malha do `Frame PSA - Small.obj` dele) tem
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
> A1 mini só é atingido com `card_w = 81`.
>
> Uma medida de régua resolve os três modelos de uma vez — e o `psa-bumper-01`
> traz um **gabarito de medição** (`3mf/psa-bumper-01-gauge.3mf`, 13.4g) que
> devolve largura, altura e espessura em uma impressão, com os números gravados
> na peça. **É o job a imprimir primeiro**, e o número que sair dele serve para
> os três modelos. Nos três casos é trocar os parâmetros de slab e re-exportar.
>
> O envelope do `psa-bumper-01` (84.5 × 139.5 × 7.2) é quase o **mínimo** das 5
> fontes: 2 delas não entram, e em Z 7.5mm de cavidade contra 0.30" = 7.62mm já
> dá interferência. Por isso a chapa da moldura está marcada como PROVISÓRIA.

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
