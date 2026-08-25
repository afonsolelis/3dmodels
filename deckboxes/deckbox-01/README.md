# deckbox-01

Deckbox estilo **caixa de fósforo (matchbox)** com fechamento magnético e
**3 compartimentos**: dois decks lado a lado + um compartimento pra dados/moedas.

## Peças (3 no total)

| Nome | No código | Quantidade | O que é |
|---|---|---|---|
| **bandeja** | `tray` | 1 | peça interna, com os 3 compartimentos, desliza pra dentro da capa |
| **capa** | `sleeve` | 1 | peça externa, fechada numa ponta, a bandeja entra por dentro dela |
| **elevador** | `lifter` | 2 (uma por compartimento de deck) | plataforma solta com aba, fica embaixo do deck |

## Design

- **Bandeja**: fundo + 4 paredes fechadas, só o topo aberto. Três
  compartimentos internos:
  - dois compartimentos lado a lado, um pra cada deck (60 cartas com sleeve
    cada), **cartas deitadas** (empilhadas horizontalmente, não em pé — a
    caixa fica baixa e achatada, tipo gaveta de verdade). Cada compartimento
    tem um **elevador** por baixo do deck (ver abaixo) e um vão pequeno na
    parede externa, perto do chão, por onde passa a aba do elevador
  - um compartimento abaixo dos dois (ocupando toda a largura), mais fundo
    na bandeja, pra dados/moedas/tokens
- **Capa**: um tubo fechado em **uma** ponta (diferente de um fósforo de
  verdade, que é aberto nas duas). A bandeja entra pela ponta aberta e
  desliza até o fim, como uma gaveta na capa. A capa cobre **todo** o
  compartimento de cartas e de dados quando fechada — só a parede sólida de
  trás da bandeja (`back_wall`) fica exposta, nada de compartimento fica
  desprotegido pra fora.
- **Elevador**: uma plataforma fina e solta que fica no chão de cada
  compartimento de deck, embaixo das cartas. Tem uma aba que sai pelo vão
  da parede lateral — puxa a aba e o deck inteiro sobe junto, até a última
  carta, sem precisar pinçar cartas uma a uma. A mesma peça serve nos dois
  compartimentos, só virando 180°.
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
- Elevador: plataforma de 1.6mm de espessura, folga de 0.3mm pra subir livre; aba de 12mm de largura × 8mm de saliência
- Vão pra aba do elevador: 14mm de largura × 10mm de altura, rente ao chão
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

- `deckbox-01.scad` — fonte paramétrico (OpenSCAD), três peças: `tray`, `sleeve`, `lifter`
- `stl/` — exports prontos pra fatiar no Flash Studio (`deckbox-01-lifter.stl` imprime 2×)

## Como gerar os STL

OpenSCAD está instalado via Flatpak (`org.openscad.OpenSCAD`) nesta máquina.

```sh
flatpak run org.openscad.OpenSCAD -D 'part="tray"'   -o stl/deckbox-01-tray.stl   deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="sleeve"' -o stl/deckbox-01-sleeve.stl deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="lifter"' -o stl/deckbox-01-lifter.stl deckbox-01.scad
```

> Nota: renderizar PNG (`-o preview.png`) não funciona headless nesta máquina
> (sem servidor gráfico pro OpenGL offscreen). Exportar STL funciona normal,
> não depende de display.

## Impressão

- As três peças imprimem sem suporte (nenhum overhang além de paredes retas).
- Bandeja e capa: ponta fechada pra baixo, abertura pra cima.
- Elevador: deitado, face de baixo (lisa) na mesa — imprimir 2×.
- Ímãs: encaixe pressionado (press-fit) nos rebaixos; um pingo de cola CA
  resolve se ficar frouxo. Confira a polaridade antes de colar — os 4 pares
  (bandeja × capa) precisam se atrair, não repelir.

## Próximas iterações (ideias, ainda não implementadas)

- Grade/furos vazados no elevador (visual de grade de verdade, economiza filamento)
- Chanfro na borda de entrada da capa, pra facilitar a bandeja entrar
- Texto/logo em relevo na capa
- Divisória extra dentro do compartimento de dados (dados vs moedas)
