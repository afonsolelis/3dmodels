# 3D Models

Base de modelagem 3D para impressão — projetos parametrizados, pensados para
impressoras **Bambu Lab**, com export final em **STL**.

## Ferramenta de modelagem

Os modelos são feitos em **[OpenSCAD](https://openscad.org/)** (`.scad`):
código em vez de clique-clique, fácil de versionar no git, fácil de ajustar
dimensões/parâmetros depois (largura, tolerância de encaixe, altura etc).

Cada peça gera um `.stl` exportado, que vai direto pro fatiador (Bambu Studio)
pra impressão.

## Estrutura

```
3dmodels/
├── README.md
└── deckboxes/       # caixas para decks de cartas (TCG/LCG/board games)
    └── README.md
```

Cada categoria de objeto (deckboxes, suportes, organizadores, etc.) vive na
sua própria pasta, com subpastas por modelo específico.

## Estrutura de um modelo

```
<categoria>/<nome-do-modelo>/
├── <nome-do-modelo>.scad   # fonte paramétrico
├── stl/                     # exports prontos pra fatiar
└── README.md                # medidas, notas de impressão, tolerâncias
```

## Impressão

- Impressora alvo: Bambu Lab
- Fatiador: Bambu Studio
- Formato de export: STL

## Requisitos

- [OpenSCAD](https://openscad.org/downloads.html) instalado para editar/renderizar os `.scad`
  (nesta máquina, instalado via Flatpak: `flatpak install flathub org.openscad.OpenSCAD`,
  chamado como `flatpak run org.openscad.OpenSCAD ...`)
- Bambu Studio para fatiar os `.stl`

> Sistema Fedora Atomic (imutável): `dnf install` direto no sistema base não
> funciona. Use Flatpak (apps) ou Distrobox (ferramentas de linha de comando).
