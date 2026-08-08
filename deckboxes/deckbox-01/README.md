# deckbox-01

Deckbox estilo **caixa de fósforo (matchbox)** com fechamento magnético e
**3 compartimentos**: dois decks lado a lado + um compartimento pra dados/moedas.

## Design

- **Bandeja** (`tray`): fundo + 4 paredes fechadas, só o topo aberto. Três
  compartimentos internos:
  - dois compartimentos lado a lado, um pra cada deck (60 cartas com sleeve
    cada), **cartas deitadas** (empilhadas horizontalmente, não em pé — a
    caixa fica baixa e achatada, tipo gaveta de verdade), com um **sulco
    arredondado** de cada lado (parede externa e divisória central) pra
    pinçar e tirar o deck com facilidade
  - um compartimento abaixo dos dois (ocupando toda a largura), mais fundo
    na bandeja, pra dados/moedas/tokens
- **Caixa externa** (`sleeve`): um tubo fechado em **uma** ponta (diferente
  de um fósforo de verdade, que é aberto nas duas). A bandeja entra pela
  ponta aberta e desliza até o fim, como uma gaveta na capa. A capa cobre
  **todo** o compartimento de cartas e de dados quando fechada — só a
  parede sólida de trás da bandeja (`back_wall`) fica exposta, nada de
  compartimento fica desprotegido pra fora.
- **Fechamento por 4 ímãs**: um em cada canto da ponta da bandeja (disco
  4×2mm), espelhados por outros 4 na tampa da caixa. Quando a bandeja é
  empurrada até o fim, os ímãs se encostam e travam por atração — 4 pontos
  de contato em vez de 1 central, pra não bambolear numa caixa larga.
- **Furo pra empurrar**: um furo passante no fundo da capa (entre os 4
  ímãs) pra empurrar a bandeja de volta com o dedo, sem depender só da
  aba de trás pra desencaixar.
- A parede de trás da bandeja (`back_wall`, sólida) sempre fica pra fora
  da capa quando fechada — é a aba pra puxar com o dedo. Como os
  compartimentos de deck ficam do lado dessa aba, eles aparecem primeiro
  ao puxar a bandeja; o compartimento de dados fica mais fundo (só aparece
  puxando quase até o fim, ou empurrando pelo furo do outro lado).
- Os sulcos das laterais de cada compartimento de deck vão do **teto até o
  chão** da bandeja, não só uma mordida perto do topo — dá pra pinçar e
  tirar o deck inteiro, até a última carta que sobrar no fundo.

## Specs atuais (parâmetros em `deckbox-01.scad`)

- Carta: 63×88mm (standard TCG), deitada (empilhada na vertical)
- Capacidade: 60 cartas com sleeve **por compartimento** (2 decks)
- Espessura de carta sleeved: 0.8mm (placeholder — confirmar com a sleeve real)
- Compartimento de dados/moedas: 30mm de profundidade × largura dos dois decks juntos
- Sulco pra pegar o deck: 20mm de largura (raio 10mm), do teto até o chão, nas duas laterais de cada compartimento
- Ímãs: 4× disco 4mm × 2mm por peça (um em cada canto da ponta), 10mm de margem da borda
- Furo pra empurrar a bandeja: 12mm de diâmetro, no meio da tampa da caixa
- Parede externa/tubo: 1.6mm | parede da ponta do ímã: 3mm | parede de trás (aba de puxar): 15mm | divisórias internas: 1.6mm
- Tolerância de encaixe deslizante: 0.25mm por lado
- Dimensões externas aproximadas (com os defaults): bandeja ~139.6×134.8×57.2mm, capa ~127.6×138.5×60.9mm, montada ~142.6mm de comprimento total

## Arquivos

- `deckbox-01.scad` — fonte paramétrico (OpenSCAD), duas peças: `tray` e `sleeve`
- `stl/` — exports prontos pra fatiar no Bambu Studio

## Como gerar os STL

OpenSCAD está instalado via Flatpak (`org.openscad.OpenSCAD`) nesta máquina.

```sh
flatpak run org.openscad.OpenSCAD -D 'part="tray"'   -o stl/deckbox-01-tray.stl   deckbox-01.scad
flatpak run org.openscad.OpenSCAD -D 'part="sleeve"' -o stl/deckbox-01-sleeve.stl deckbox-01.scad
```

> Nota: renderizar PNG (`-o preview.png`) não funciona headless nesta máquina
> (sem servidor gráfico pro OpenGL offscreen). Exportar STL funciona normal,
> não depende de display.

## Impressão

- Ambas as peças imprimem sem suporte (nenhum overhang além de paredes retas).
- Orientação: ponta fechada pra baixo, abertura pra cima.
- Ímãs: encaixe pressionado (press-fit) nos rebaixos; um pingo de cola CA
  resolve se ficar frouxo. Confira a polaridade antes de colar — os 4 pares
  (bandeja × capa) precisam se atrair, não repelir.

## Próximas iterações (ideias, ainda não implementadas)

- Chanfro na borda de entrada da caixa, pra facilitar a bandeja entrar
- Texto/logo em relevo na caixa
- Divisória extra dentro do compartimento de dados (dados vs moedas)
