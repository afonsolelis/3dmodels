# Organizadores TCG

Caixas e organizadores para cartas de TCG — soltas, com sleeve, em toploader
ou **graduadas (slabs PSA/BGS)** — modelados em OpenSCAD e impressos na
Bambu Lab A1 mini.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [psa-box-01](./psa-box-01/) | 🚧 em andamento | caixa de 38 slabs PSA nuas em duas filas de 19, base + tampa telescópica, **fechada contra luz** (colmeia em baixo relevo, nada passante); ocupa a cama inteira da A1 mini (176.4 × 175.1mm, 2 jobs + gabarito de teste) |
| [psa-bumper-01](./psa-bumper-01/) | 🚧 em andamento | bumper clamshell de VITRINE pra UMA slab PSA: duas metades iguais de moldura, janela de vão único (carta + etiqueta juntas, dá pra ver frente e dorso), 10 pares de ímã Ø4x2 + degrau perimetral de alinhamento; aro de 9mm, 103.1 × 158.1 × 11.5mm fechado, 1 moldura por chapa (imprimir a mesma chapa 2x). **Acompanha gabarito de medição do slab (13.4g) que é o job a imprimir PRIMEIRO** — a chapa da moldura é provisória até a medida voltar. Não é à prova de queda, por escopo |

## Os `.3mf` soltos na raiz desta pasta

Todos os `.3mf` que estão direto nesta pasta (sem subpasta de modelo) são
**downloads de terceiros**, guardados como referência e material de estudo.
Não são modelos paramétricos do repo: não têm `.scad`, não seguem as
convenções e não entram no `index.json` como projeto.

O `psa-bumper-01` também: ele é o `Main.3mf` (PSA Graded Card Case, do
MaskForge) sem a travessa central da janela e sem tampa deslizante — virou
clamshell de duas metades iguais fechado por ímã.

> **Atenção: NENHUMA medida de slab deste repo saiu de régua.** O usuário foi
> consultado duas vezes e optou por não medir, então os dois modelos rodam em
> cima de estimativa:
>
> - `psa-bumper-01` usa **84.5 × 139.5 × 7.2mm**, um envelope conservador sobre
>   o consenso de 5 fontes (85.0 / 85.0×138.5 / 85.4×140.0 / 86.2×140.7 e o
>   nominal PSA 83.6×134.4 × 7.1);
> - `psa-box-01` usa ~83.6–85 × 134–140 × 7.1mm, de engenharia reversa de malhas.
>
> O `Main.3mf` é **outlier** e está documentado como tal: medindo a malha do
> `Frame PSA - Small.obj` dele, o bolso de slab é **81.0 × ~133.5 × 6.0mm** — a
> descrição de 80×135×6 é fiel à geometria *dele*, mas o nome "Small" e as
> outras 5 fontes indicam variante de slab menor, não a medida geral.
>
> Uma medida de régua resolve os dois modelos de uma vez — e o `psa-bumper-01`
> traz um **gabarito de medição** (`3mf/psa-bumper-01-gauge.3mf`, 13.4g) que
> devolve largura, altura e espessura em uma impressão, com os números gravados
> na peça. **É o job a imprimir primeiro**, e o número que sair dele serve para
> os dois modelos. Nos dois casos é trocar os parâmetros de slab e re-exportar.
>
> O envelope atual do bumper (84.5 × 139.5 × 7.2) é quase o **mínimo** das 5
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
