# 3D Models

Base de modelagem 3D para impressão — projetos parametrizados para a
**FlashForge AD5X** (cama 220x220x220, bico 0.4, IFS de 4 cores), com export
final em **3MF** e STLs individuais de referência.

## Ferramenta de modelagem

Os modelos são feitos em **[OpenSCAD](https://openscad.org/)** (`.scad`):
código em vez de clique-clique, fácil de versionar no git, fácil de ajustar
dimensões/parâmetros depois (largura, tolerância de encaixe, altura etc).

Cada modelo gera os `.3mf` de impressão (chapas já na orientação certa, que
vão direto pro Flash Studio) e `.stl` individuais de cada peça, de referência.

## Estrutura

```
3dmodels/
├── README.md
├── index.json           # catálogo machine-readable de todos os projetos
├── cardholders/         # porta-cartas abertos e torres de sleeve (pilha à vista)
│   └── README.md
├── cartoes/             # cartões utilitários finos (emergência, NFC, identificação)
│   └── README.md
├── coin_holders/        # inserts de moeda para páginas de fichário (+ STL de terceiros)
│   └── README.md
├── deckboxes/           # caixas para decks de cartas (TCG/LCG/board games)
│   └── README.md
├── figures/             # figuras decorativas e miniaturas
│   └── README.md
├── jogos/               # jogos de mesa completos e componentes jogáveis
│   └── README.md
├── organizadores_tcg/   # organizadores de cartas soltas, sleeved e slabs graduadas
│   └── README.md
├── playmats/            # campos de jogo em placas encaixáveis
│   └── README.md
├── rings/               # anéis (tapete de jogo, organização, etc.)
│   └── README.md
├── suportes/            # suportes e apoios de mesa (controle de videogame, etc.)
│   └── README.md
├── bumpers/             # (só .3mf de terceiros — bumpers de slab graduado)
│   └── README.md
├── diversos/            # downloads avulsos + projetos paramétricos diversos
│   └── README.md
├── logistica_pokemon/   # (só .3mf de terceiros)
│   └── README.md
└── manutencao_bambu/    # (só .3mf de terceiros)
    └── README.md
```

Cada categoria de objeto (deckboxes, suportes, organizadores, etc.) vive na
sua própria pasta, com subpastas por modelo específico. As pastas marcadas
como "só .3mf de terceiros" guardam downloads usados como referência — não
têm `.scad` e não entram no `index.json` como projeto.

## Estrutura de um modelo

```
<categoria>/<nome-do-modelo>/
├── <nome-do-modelo>.scad   # fonte paramétrico
├── 3mf/                     # SÓ os jobs de impressão (abrir no Flash Studio)
├── stl/                     # peças individuais, referência
└── README.md                # medidas, notas de impressão, tolerâncias
```

## Impressão

- Impressora-alvo padrão: FlashForge AD5X (cama 220x220x220); projetos com
  outra máquina declaram isso no próprio README e no `index.json`
- Fatiador padrão: Flash Studio; projetos específicos podem trazer 3MF para o
  fatiador da impressora-alvo
- Formato de export: 3MF (jobs de impressão) + STL (peças individuais)

## Requisitos

- [OpenSCAD](https://openscad.org/downloads.html) instalado para editar/renderizar os `.scad`
  (nesta máquina, instalado via Flatpak: `flatpak install flathub org.openscad.OpenSCAD`,
  chamado como `flatpak run org.openscad.OpenSCAD ...`)
- Flash Studio para fatiar os `.3mf`

> Sistema Fedora Atomic (imutável): `dnf install` direto no sistema base não
> funciona. Use Flatpak (apps) ou Distrobox (ferramentas de linha de comando).
