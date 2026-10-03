# Modelos 3D para a FlashForge AD5X

Este repositório reúne **projetos paramétricos próprios** em [OpenSCAD](https://openscad.org/) e **arquivos baixados de terceiros**. Os projetos próprios têm fonte editável e jobs de impressão organizados. Os 110 downloads ficam em pastas individuais, classificados por função, com prévia e origem documentada.

A impressora do projeto é a **FlashForge AD5X**: volume de 220 × 220 × 220 mm, bico de 0,4 mm, mesa PEI flexível e IFS de 4 cores. Os projetos próprios miram uma área de até 210 × 210 mm na mesa, deixando margem para brim quando necessário. Peças maiores são divididas em jobs.

## Quero imprimir um projeto próprio

1. Escolha um modelo na lista abaixo e leia o README da pasta dele. Ali estão as medidas, o estado do projeto, as peças, a montagem e as orientações específicas de impressão.
2. Abra os arquivos da pasta `3mf/` no **Flash Studio Desktop**. Cada arquivo é um job de impressão; um modelo pode exigir vários jobs. Confira material, cores, suportes e perfil indicados no README do modelo antes de fatiar.
3. Use `stl/` para obter uma peça isolada ou montar outro arranjo de impressão. O `.scad` é a fonte para alterar dimensões e gerar novos exports.

Os modelos são iterativos. `em-andamento` indica que o projeto ainda pode mudar; `aguardando-teste-fisico` indica que o próximo passo é conferir a peça impressa na mão. Um arquivo exportado e verificado digitalmente ainda precisa de teste físico para confirmar encaixes e uso.

## Projetos paramétricos próprios

O [index.json](index.json) é o catálogo completo: reúne estado, descrição, peças, jobs, área ocupada na mesa e medidas-chave de cada projeto. A lista abaixo ajuda a encontrar o modelo; o README de cada categoria traz mais contexto.

| Categoria | Projetos | Para quê |
| --- | --- | --- |
| [Porta-cartas](cardholders/README.md) | [cardholder-01](cardholders/cardholder-01/README.md), [sleeve-tower-01](cardholders/sleeve-tower-01/README.md) | Pilhas de cartas ou penny sleeves à vista |
| [Cartões](cartoes/README.md) | [emergency-nfc-card-01](cartoes/emergency-nfc-card-01/README.md), [pokemon-filler-card-01](cartoes/pokemon-filler-card-01/README.md), [armarouge-card-2cores-01](cartoes/armarouge-card-2cores-01/README.md) | Cartão de emergência e cards para álbum, inclusive com IFS |
| [Moedas](coin_holders/README.md) | [pokemon-coin-binder-01](coin_holders/pokemon-coin-binder-01/README.md) | Insert de moeda Pokémon para bolso de fichário |
| [Deckboxes e estojos](deckboxes/README.md) | [deckbox-01](deckboxes/deckbox-01/README.md), [deckbox-02](deckboxes/deckbox-02/README.md), [deckbox-03](deckboxes/deckbox-03/README.md), [card-mailer-01](deckboxes/card-mailer-01/README.md) | Guardar decks e transportar cartas ou slabs; o card-mailer aguarda teste físico |
| [Ferragens](ferragens/README.md) | [parafuso-porca-01](ferragens/parafuso-porca-01/README.md) | Parafusos e porcas impressos |
| [Ferramentas](ferramentas/README.md) | [toolbox-snap-01](ferramentas/toolbox-snap-01/README.md) | Caixa de ferramentas com tampa deslizante |
| [Figuras](figures/README.md) | [dragon-01](figures/dragon-01/README.md) | Dragão decorativo em peça única |
| [Jogos](jogos/README.md) | [xadrez-01](jogos/xadrez-01/README.md) | Tabuleiro e peças de xadrez |
| [Organizadores](organizadores/README.md) | [snap-organizer-01](organizadores/snap-organizer-01/README.md), [vinyl-now-playing-01](organizadores/vinyl-now-playing-01/README.md), [switch-case-organizer-01](organizadores/switch-case-organizer-01/README.md) | Módulos de bancada, suporte para LPs e organizador de jogos Switch |
| [Organizadores TCG](organizadores_tcg/README.md) | [bgs-stand-01](organizadores_tcg/bgs-stand-01/README.md), [penny-holder-01](organizadores_tcg/penny-holder-01/README.md), [psa-box-01](organizadores_tcg/psa-box-01/README.md), [slab-tile-01](organizadores_tcg/slab-tile-01/README.md), [toploader-holder-01](organizadores_tcg/toploader-holder-01/README.md) | Cartas com sleeve, top loaders e slabs graduadas |
| [Playmats](playmats/README.md) | [pokemon-game](playmats/pokemon-game/README.md) | Campo de Pokémon TCG em placas encaixáveis |
| [Prateleiras](prateleiras/README.md) | [prateleira-modular-01](prateleiras/prateleira-modular-01/README.md) | Prateleira de parede modular com mão francesa integrada |
| [Anéis](rings/README.md) | [ring-01](rings/ring-01/README.md), [ring-02](rings/ring-02/README.md) | Anéis para enrolar playmat |
| [Suportes](suportes/README.md) | [xbox-stand-01](suportes/xbox-stand-01/README.md), [switch-lite-stand-01](suportes/switch-lite-stand-01/README.md) | Apoio de mesa para controle Xbox e bainha de mesa para Switch Lite com capa |

## Arquivos baixados de terceiros

Cada categoria com downloads tem um catálogo visual em `terceiros/README.md`. Cada item ocupa uma pasta com o arquivo de impressão, README próprio e prévia quando disponível. O README registra o nome original, autor e licença. Todos os arquivos também constam em `third_party` no [index.json](index.json). **Não presuma que um 3MF baixado já tenha o perfil da AD5X ou esteja pronto para imprimir:** confira a impressora, o material, a orientação e os suportes no Flash Studio.

| Acervo de downloads | Categorias |
| --- | --- |
| Cartas e colecionáveis | [Bumpers](bumpers/terceiros/README.md), [Porta-cartas](cardholders/terceiros/README.md), [Porta-moedas](coin_holders/terceiros/README.md), [Deckboxes](deckboxes/terceiros/README.md), [Organizadores TCG](organizadores_tcg/terceiros/README.md), [Logística Pokémon](logistica_pokemon/terceiros/README.md) |
| Casa e organização | [Casa](casa/terceiros/README.md), [Organizadores](organizadores/terceiros/README.md), [Caixas de remédio](saude/terceiros/README.md), [Suportes](suportes/terceiros/README.md) |
| Lazer e outros | [Figuras](figures/terceiros/README.md), [Miniaturas](miniaturas/terceiros/README.md), [Jogos](jogos/terceiros/README.md), [Pets](pets/terceiros/README.md), [Manutenção de impressoras](manutencao_impressoras/terceiros/README.md) |

As categorias Casa, Miniaturas, Pets, Caixas de remédio, Bumpers, Logística Pokémon e Manutenção de impressoras contêm apenas downloads. Outras misturam downloads e projetos próprios. Consulte autoria e licença no README do item antes de redistribuir um arquivo de terceiro.

As medidas dos downloads foram extraídas das malhas na orientação salva. O indicador AD5X informa se **cada peça** cabe nos 220 × 220 × 220 mm; a disposição conjunta das plates ainda precisa ser conferida no Flash Studio.

Alguns projetos próprios nasceram do estudo de um arquivo baixado. Quando isso acontece, o README do modelo explica a referência e quais medidas foram reaproveitadas; a fonte OpenSCAD do projeto fica na pasta do modelo.

Para atualizar as páginas dos downloads após editar o `index.json`, execute `python3 scripts/build_download_docs.py`. Os comandos `python3 scripts/build_download_docs.py --check` e `python3 scripts/measure_download_bounds.py --check` verificam as páginas e as medidas das malhas.

## Estrutura dos projetos próprios

```text
<categoria>/
├── README.md                   # índice da categoria
└── <modelo>/
    ├── README.md               # uso, medidas e estado do modelo
    ├── <modelo>.scad            # fonte paramétrica e comandos de export
    ├── 3mf/                    # jobs para abrir no Flash Studio
    └── stl/                    # peças individuais de referência
```

Essa árvore descreve os projetos próprios, não os downloads. O [pokemon-game](playmats/pokemon-game/README.md) usa mais de uma fonte `.scad`; seus arquivos e jobs estão descritos no README dele. Pastas como `art/` ou `validation/` guardam material de apoio de alguns projetos.

Os downloads seguem outra estrutura:

```text
<categoria>/terceiros/<item>/
├── README.md       # o que é, origem, licença e nome original
├── preview.png     # prévia do 3MF ou render da malha, quando disponível
└── <arquivo>.3mf   # ou .stl; nome legível, conteúdo original preservado
```

## Editar e exportar

Nesta máquina, o OpenSCAD é executado pelo Flatpak:

```sh
flatpak run org.openscad.OpenSCAD /caminho/absoluto/para/o/modelo.scad
```

O cabeçalho de cada `.scad` traz os comandos de export daquele modelo. Após mudar a geometria, gere uma nova prévia visual, exporte novamente STL e 3MF, confira as dimensões e a área de cada job na mesa, e atualize a entrada correspondente no `index.json`. Os 3MF de `3mf/` devem sempre corresponder à versão atual da fonte. A orientação de impressão e eventuais testes de encaixe estão no README de cada modelo.

Para editar, instale o [OpenSCAD](https://openscad.org/downloads.html). Para fatiar os jobs, use o **Flash Studio Desktop**. Nesta instalação, o OpenSCAD pode ser instalado com `flatpak install flathub org.openscad.OpenSCAD`.
