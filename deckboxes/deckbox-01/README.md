# deckbox-01

Deckbox estilo **caixa de fósforo (matchbox)** com fechamento magnético e
**3 compartimentos**: dois decks lado a lado + um compartimento pra dados/moedas.

## Peças (3 no total)

| Nome | No código | Quantidade | O que é |
|---|---|---|---|
| **bandeja** | `tray` | 1 | peça interna, com os 3 compartimentos, desliza pra dentro da capa |
| **capa** | `sleeve` | 1 | peça externa, fechada numa ponta, a bandeja entra por dentro dela |
| **cestinha** | `basket` | 2 (uma por compartimento de deck) | cesta solta de paredes finas, vazada em colmeia, que segura o deck inteiro |

## Design

- **Bandeja**: fundo + 4 paredes fechadas, só o topo aberto. Três
  compartimentos internos:
  - dois compartimentos lado a lado, um pra cada deck (60 cartas com sleeve
    cada), **cartas deitadas** (empilhadas horizontalmente, não em pé — a
    caixa fica baixa e achatada, tipo gaveta de verdade). Cada compartimento
    guarda uma **cestinha** com o deck dentro (ver abaixo) e tem um furo
    Ø16mm no chão da bandeja, embaixo dela, pra empurrar com o dedo
  - um compartimento abaixo dos dois (ocupando toda a largura), mais fundo
    na bandeja, pra dados/moedas/tokens
- **Capa**: um tubo fechado em **uma** ponta (diferente de um fósforo de
  verdade, que é aberto nas duas). A bandeja entra pela ponta aberta e
  desliza até o fim, como uma gaveta na capa. A capa cobre **todo** o
  compartimento de cartas e de dados quando fechada — só a parede sólida de
  trás da bandeja (`back_wall`) fica exposta, nada de compartimento fica
  desprotegido pra fora.
- **Cestinha**: uma cesta solta de paredes de 1,2mm que vive dentro do
  compartimento, com o deck deitado dentro dela. O dedo empurra o chão dela
  **por baixo**, pelo furo Ø16mm no chão da bandeja — igual ao miolo de uma
  caixa de fósforo — até a borda aparecer; daí é só pegar e tirar a cestinha
  inteira, com o deck junto. Chão e paredes são **vazados em colmeia** e os
  dois lados compridos têm **recorte em U de 40mm** que desce até o chão,
  então dá pra pinçar até a última carta com a cestinha fora da bandeja. A
  mesma peça serve nos dois compartimentos.

  > A primeira versão desta peça era um **elevador** — plataforma com aba
  > saindo por um vão na parede lateral. Foi **impressa e reprovada**: 10mm
  > de vão para um curso de 48mm, a aba travava a capa. A cestinha é a
  > substituta e não tem aba nenhuma.
- **Fechamento por 4 ímãs**: um em cada canto da ponta da bandeja (disco
  4×2mm), espelhados por outros 4 na tampa da capa. Quando a bandeja é
  empurrada até o fim, os ímãs se encostam e travam por atração — 4 pontos
  de contato em vez de 1 central, pra não bambolear numa caixa larga.
- **Furo pra empurrar**: um furo passante no fundo da capa (entre os 4
  ímãs) pra empurrar a bandeja de volta com o dedo.
- A parede de trás da bandeja (`back_wall`, sólida) sempre fica pra fora da
  capa quando fechada. Como os compartimentos de deck ficam do lado dela,
  eles aparecem primeiro ao puxar a bandeja; o compartimento de dados fica
  mais fundo (só aparece puxando quase até o fim, ou empurrando pelo furo
  do outro lado).

## Specs atuais (parâmetros em `deckbox-01.scad`)

- Carta: 63×88mm (standard TCG), deitada (empilhada na vertical)
- Capacidade: 60 cartas com sleeve **por compartimento** (2 decks)
- Espessura de carta sleeved: 0.8mm (placeholder — confirmar com a sleeve real)
- Compartimento de dados/moedas: 30mm de profundidade × largura dos dois decks juntos
- Cestinha: paredes 1.2mm, chão 1.6mm, folga 0.3mm/lado pra subir livre, borda 3mm acima da pilha; recorte em U de 40mm nas duas laterais compridas
- Furo pra empurrar a cestinha: Ø16mm no chão da bandeja, um por compartimento
- Ímãs: 4× disco 4mm × 2mm por peça (bandeja e capa), 10mm de margem da borda
- Furo pra empurrar a bandeja: 12mm de diâmetro, no meio da tampa da capa
- Paredes: externa/tubo 1.6mm | ponta do ímã 4mm | parede de trás (aba de puxar) 2mm | divisórias internas 1.6mm
- Tolerância de encaixe deslizante (bandeja × capa): **0.5mm por lado**
  (era 0.25 — o deckbox-02 impresso travou no meio do curso em 2026-08-10;
  ver a nota em `fit_tolerance` no `.scad` e a regra 6 do `CLAUDE.md`)
- Chanfro de entrada na boca da capa: 2.5mm de rampa abrindo 0.8mm por lado,
  pra bandeja não morder a quina e entrar torta
- Dimensões externas medidas nos STL atuais: bandeja 135.6×150.8×53.8mm,
  capa 137.6×155.0×58.0mm, conjunto fechado 139.6×155.0×58.0mm

## Arquivos

- `deckbox-01.scad` — fonte paramétrico (OpenSCAD), três peças: `tray`, `sleeve`, `basket`
- `stl/` — peças individuais (`deckbox-01-basket.stl` imprime 2×)
- `3mf/` — os **2 jobs de impressão**: `deckbox-01-plate.3mf` (capa em pé +
  2 cestinhas, ~155 × 161mm) e `deckbox-01-tray.3mf` (a bandeja, 136 × 151mm
  — não cabe junto)
- A variante de **um deck só** é a [`deckbox-02`](../deckbox-02/), que inclui
  este arquivo com `deck_lanes = 1` e `dice_depth = 64`

## Como gerar os STL

OpenSCAD está instalado via Flatpak (`org.openscad.OpenSCAD`) nesta máquina.

```sh
flatpak run org.openscad.OpenSCAD -D 'part="tray"'   -o stl/deckbox-01-tray.stl   deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="sleeve"' -o stl/deckbox-01-sleeve.stl deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="basket"' -o stl/deckbox-01-basket.stl deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="plate"'  -o 3mf/deckbox-01-plate.3mf  deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="tray"'   -o 3mf/deckbox-01-tray.3mf   deckbox-01.scad
```

> Use **caminhos absolutos**: o flatpak não enxerga `/tmp` e, com caminho
> relativo, o erro é `Can't open input file` — que não contém "error" e passa
> batido em filtro de log.
>
> PNG **funciona**, mas precisa de display: acrescente
> `--env=DISPLAY=:0 --socket=x11` ao `flatpak run`.

## Impressão

- As três peças imprimem sem suporte (nenhum overhang além de paredes retas).
- Bandeja e capa: ponta fechada pra baixo, abertura pra cima.
- Cestinha: chão na mesa, boca pra cima — imprimir 2×. Os hexágonos são de
  ponta pra cima, então as paredes vazadas saem sem ponte e sem suporte.
- Ímãs: encaixe pressionado (press-fit) nos rebaixos; um pingo de cola CA
  resolve se ficar frouxo. Confira a polaridade antes de colar — os 4 pares
  (bandeja × capa) precisam se atrair, não repelir.

## Próximas iterações (ideias, ainda não implementadas)

- Texto/logo em relevo na capa
- Divisória extra dentro do compartimento de dados (dados vs moedas)

*(Já implementados e riscados desta lista: vazado em colmeia — hoje é a
cestinha inteira — e o chanfro de entrada na boca da capa.)*
