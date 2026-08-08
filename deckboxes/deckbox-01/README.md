# deckbox-01

Deckbox estilo **caixa de fósforo (matchbox)** com fechamento magnético.

## Design

- **Bandeja** (`tray`): guarda as cartas em pé, fundo + 4 paredes fechadas,
  só o topo aberto.
- **Caixa externa** (`sleeve`): um tubo fechado em **uma** ponta (diferente
  de um fósforo de verdade, que é aberto nas duas). A bandeja entra pela
  ponta aberta e desliza até o fim.
- **Fechamento por ímã**: rebaixo pra um ímã de disco **4×2mm** na ponta da
  bandeja e outro na tampa da caixa, virados um pro outro. Quando a bandeja
  é empurrada até o fim, os dois ímãs se encostam e travam por atração.
- Um trecho da bandeja (`pull_tab`) sempre fica pra fora, pra puxar com o dedo.

## Specs atuais (parâmetros em `deckbox-01.scad`)

- Carta: 63×88mm (standard TCG)
- Capacidade: ~80 cartas com sleeve (placeholder — ajustar `card_count` pro
  número exato do deck)
- Espessura de carta sleeved: 0.8mm (placeholder — confirmar com a sleeve real)
- Ímã: disco 4mm × 2mm
- Parede lateral/fundo: 1.6mm | parede das pontas (onde ficam os ímãs): 3mm
- Tolerância de encaixe deslizante: 0.25mm por lado

## Arquivos

- `deckbox-01.scad` — fonte paramétrico (OpenSCAD), duas peças: `tray` e `sleeve`
- `stl/` — exports prontos pra fatiar no Bambu Studio

## Como gerar os STL

```sh
openscad -o stl/deckbox-01-tray.stl   -D 'part="tray"'   deckbox-01.scad
openscad -o stl/deckbox-01-sleeve.stl -D 'part="sleeve"' deckbox-01.scad
```

## Impressão

- Ambas as peças imprimem sem suporte (nenhum overhang além de paredes retas).
- Orientação: ponta fechada pra baixo, abertura pra cima.
- Ímãs: encaixe pressionado (press-fit) nos rebaixos; um pingo de cola CA
  resolve se ficar frouxo.

## Próximas iterações (ideias, ainda não implementadas)

- Chanfro na borda de entrada da caixa, pra facilitar a bandeja entrar
- Reentrância pro polegar na ponta de puxar da bandeja
- Divisória interna (ex: separar deck principal de sideboard)
- Texto/logo em relevo na caixa
