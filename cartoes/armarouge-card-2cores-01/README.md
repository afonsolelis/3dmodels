# armarouge-card-2cores-01

Card tapa-buraco de álbum Pokémon com o **Armarouge**, **sem nome e sem
número**, em **duas cores no IFS**: corpo preto e arte cinza claro.

Derivado do [pokemon-filler-card-01](../pokemon-filler-card-01/) — as medidas
do bolso do álbum, a espessura e o pipeline de relevo vêm de lá. O que muda:

| | 01 (com texto) | 02 (este) |
|---|---|---|
| texto | `ARMAROUGE` + `#936` em alto-relevo | **nenhum** |
| faixa de baixo | 12mm reservados pro texto | 0 — vira área de arte |
| arte | 38,3 × 62,8mm | **45,7 × 74,8mm** |
| filamentos | 4 | **2** |

## Medidas

- Card **67 × 90mm**, de propósito maior que o oficial de 63 × 88 (o card real
  fica solto no bolso do álbum).
- Corpo **1,20mm** (6 camadas a 0,20mm), relevo até **+0,80mm** → **2,00mm**
  acabado, a mesma espessura já impressa e aprovada no `pokemon-coin-binder-01`.
- Quinas R3,5mm; chanfro de 0,40mm na aresta de baixo contra pé de elefante.
- Moldura a 3,5mm da borda, linha de 1,6mm, alto-relevo de 0,40mm.
- Relevo da arte em 4 níveis: +0,20 / +0,40 / +0,60 / +0,80mm — cada degrau é
  **uma camada inteira** a 0,20mm, então cai em fronteira de camada no fatiador.

## Cores

| Filamento | Cor | Peças |
|---|---|---|
| 1 | `#C8C8C8` cinza claro | corpo do card, detalhe interno da figura |
| 2 | `#1A1A1A` preto | moldura, hexágonos, figura |

As cores vão gravadas no `3mf` (`Metadata/project_settings.config`, só chaves
de filamento — nenhuma de impressora ou de processo), então ele abre colorido
no Flash Studio. Pra trocar, basta reordenar o `--colors` do `multicolor3mf.py`.

### Como a arte virou duas cores

`svg2relief.py --colors 2` **não serve** aqui: lá os grupos saem de k-means em
RGB, que num traço do Armarouge separa amarelo de vermelho — duas cores
igualmente claras, que em preto/cinza viram uma mancha chapada só. Foi testado
e a figura sumiu.

O que dá leitura é separar **claro de escuro**, e a luminância já está no
heightmap: o `svg2relief.py` converteu luminância em **altura**, então o nível
do relevo *é* o tom. O `art2parts.py` corta por aí:

| Nível | Altura | Área | Filamento |
|---|---|---|---|
| 1 | +0,20mm | 23,6% | 1, cinza claro — vira o detalhe/linha dentro da figura |
| 2–4 | +0,40 a +0,80mm | 76,4% | 2, preto — a silhueta cheia |

Cortar em 1×3 e não em 2×2 foi escolha de render: com os níveis 1–2 juntos no
escuro, quase metade da figura ia pro preto e a silhueta se partia.

## Impressão

| 3MF | Fundo | Figura |
|---|---|---|
| `3mf/armarouge-card-2cores-01.3mf` — **recomendado** | cinza claro | preta |
| `3mf/armarouge-card-2cores-01-fundo-preto.3mf` | preto | cinza claro |

Mesma geometria nos dois, só o mapa de filamento troca. O recomendado é o de
fundo claro porque no fundo preto os vazios escuros da arte se fundem com o
corpo do card e a silhueta se perde (comparar
`armarouge-card-2cores-01-render-v1.png` com `-fundo-preto-v1.png`).

1 card, **67 × 90 × 2,0mm**, verso na placa e relevo pra cima. Sem suporte, sem
ponte. **BRIM recomendado**: placa de 67 × 90 com 1,2mm de corpo é a geometria
clássica de empeno.

## Regerar

```sh
# corpo (filamento 1) e moldura (filamento 2)
flatpak run org.openscad.OpenSCAD -o stl/armarouge-card-2cores-01-body.stl -D 'part="body"' armarouge-card-2cores-01.scad
flatpak run org.openscad.OpenSCAD -o stl/armarouge-card-2cores-01-trim.stl -D 'part="trim"' armarouge-card-2cores-01.scad

# heightmap (art-w/h/cx/cy TÊM que bater com os ECHO do .scad)
python3 svg2relief.py art/armarouge.svg art/armarouge.png --px-w 128 --levels 4 \
  --h-min 0.20 --h-step 0.20 --relief-max 0.80 --relief-bury 0.05

# heightmap -> duas malhas de cor, cortadas por NÍVEL de relevo
python3 art2parts.py art/armarouge.png stl --prefix armarouge-card-2cores-01-arte \
  --split 1 --art-w 45.6712 --art-h 74.80 --art-cx 33.50 --art-cy 45.00

# 3MF de 2 filamentos (troque a ordem do --colors pra variante de fundo preto)
python3 multicolor3mf.py 3mf/armarouge-card-2cores-01.3mf --name "armarouge-card-2cores-01" \
  --colors "#C8C8C8,#1A1A1A" \
  --part corpo 1 stl/armarouge-card-2cores-01-body.stl \
  --part moldura 2 stl/armarouge-card-2cores-01-trim.stl \
  --part arte-detalhe 1 stl/armarouge-card-2cores-01-arte-escuro.stl \
  --part arte-figura 2 stl/armarouge-card-2cores-01-arte-claro.stl
```

## Pendências

Não impresso. Falta o teste físico e falta **abrir o 3MF no Flash Studio** pra
confirmar as 4 peças nos 2 filamentos certos — o fatiador não roda headless
nesta máquina.

A arte é um trace automático a 0,36mm/px: em duas cores chapadas ela lê como
silhueta com sombreado, não como o Armarouge desenhado. Se o teste físico
decepcionar, o caminho é limpar o SVG à mão (fechar o contorno, engrossar as
linhas finas) antes de gerar o heightmap de novo — não é problema de fatiador
nem de altura de camada.
