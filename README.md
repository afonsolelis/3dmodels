# 3D Models

Base de modelagem 3D para impressão — projetos parametrizados, pensados para
a **Bambu Lab A1 mini** (cama 180x180), com export final em **3MF** (pronto
pra abrir no Bambu Studio) e STLs individuais de referência.

## Ferramenta de modelagem

Os modelos são feitos em **[OpenSCAD](https://openscad.org/)** (`.scad`):
código em vez de clique-clique, fácil de versionar no git, fácil de ajustar
dimensões/parâmetros depois (largura, tolerância de encaixe, altura etc).

Cada modelo gera os `.3mf` de impressão (chapas já na orientação certa, que
vão direto pro Bambu Studio) e `.stl` individuais de cada peça, de referência.

## Estrutura

```
3dmodels/
├── README.md
├── index.json           # catálogo machine-readable de todos os projetos
├── cardholders/         # porta-cartas abertos e torres de sleeve (pilha à vista)
│   └── README.md
├── cartoes/             # cartões utilitários finos (emergência, NFC, identificação)
│   └── README.md
├── deckboxes/           # caixas para decks de cartas (TCG/LCG/board games)
│   └── README.md
├── organizadores_tcg/   # organizadores de cartas soltas, sleeved e slabs graduadas
│   └── README.md
├── playmats/            # campos de jogo em placas encaixáveis
│   └── README.md
├── rings/               # anéis (tapete de jogo, organização, etc.)
│   └── README.md
├── suportes/            # suportes e apoios de mesa (controle de videogame, etc.)
│   └── README.md
├── diversos/            # (só .3mf de terceiros, sem modelo paramétrico)
├── logistica_pokemon/   # (só .3mf de terceiros)
└── manutencao_bambu/    # (só .3mf de terceiros)
```

Cada categoria de objeto (deckboxes, suportes, organizadores, etc.) vive na
sua própria pasta, com subpastas por modelo específico. As pastas marcadas
como "só .3mf de terceiros" guardam downloads usados como referência — não
têm `.scad` e não entram no `index.json` como projeto.

## Estrutura de um modelo

```
<categoria>/<nome-do-modelo>/
├── <nome-do-modelo>.scad   # fonte paramétrico
├── 3mf/                     # SÓ os jobs de impressão (abrir no Bambu Studio)
├── stl/                     # peças individuais, referência
└── README.md                # medidas, notas de impressão, tolerâncias
```

## Impressão

- Impressora alvo: Bambu Lab A1 mini (cama 180x180x180)
- Fatiador: Bambu Studio
- Formato de export: 3MF (jobs de impressão) + STL (peças individuais)

## Requisitos

- [OpenSCAD](https://openscad.org/downloads.html) instalado para editar/renderizar os `.scad`
  (nesta máquina, instalado via Flatpak: `flatpak install flathub org.openscad.OpenSCAD`,
  chamado como `flatpak run org.openscad.OpenSCAD ...`)
- Bambu Studio para fatiar os `.3mf`

> Sistema Fedora Atomic (imutável): `dnf install` direto no sistema base não
> funciona. Use Flatpak (apps) ou Distrobox (ferramentas de linha de comando).
