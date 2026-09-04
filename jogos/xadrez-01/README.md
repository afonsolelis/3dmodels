# xadrez-01

Conjunto de xadrez compacto completo — tabuleiro de 168 mm e 32 peças — em
**duas cores** e **três jobs** na FlashForge AD5X.

![Prévia dos três jobs: exército claro, tabuleiro e exército escuro](./xadrez-01-preview.png)

| | Job 1 — tabuleiro | Job 2 — peças claras | Job 3 — peças escuras |
|---|---|---|---|
| Arquivo | [`3mf/xadrez-01-tabuleiro-bicolor.3mf`](./3mf/xadrez-01-tabuleiro-bicolor.3mf) | [`3mf/xadrez-01-pecas-claras.3mf`](./3mf/xadrez-01-pecas-claras.3mf) | [`3mf/xadrez-01-pecas-escuras.3mf`](./3mf/xadrez-01-pecas-escuras.3mf) |
| Conteúdo | 1 tabuleiro (laje clara + 32 casas escuras) | 16 peças claras, 4 × 4 | 16 peças escuras, 4 × 4 |
| Envelope | **168,0 × 168,0 × 3,6 mm** | **76,2 × 73,6 × 46,0 mm** | **76,2 × 73,6 × 46,0 mm** |
| Folga na cama (220) | 26 mm por lado | 71,9 em X, 73,2 em Y | 71,9 em X, 73,2 em Y |
| Cores | **2** (filamentos 1 e 2) | **1** (filamento 1) | **1** (filamento 2) |
| Trocas de filamento | ~3 (só nas 3 camadas do topo) | **nenhuma** | **nenhuma** |
| Triângulos | 1.100 | 24.648 | 24.648 |
| Suportes | nenhum | nenhum | nenhum |

Os jobs 2 e 3 têm **a mesma malha** (`stl/xadrez-01-exercito.stl`); o que muda
é só o filamento atribuído.

## Por que as peças deixaram de dividir chapa

Até 2026-08-28 as 32 peças iam num **único job bicolor de 230 camadas**, com
troca de cor em *todas* elas. As 16 claras e as 16 escuras são sólidos
disjuntos — não existe razão geométrica pra elas dividirem chapa, ao contrário
do tabuleiro, onde as casas **precisam** nascer alinhadas com a laje.

Pela conta derivada do fatiamento oficial da placa antiga (mesma geometria):
~320 mm³ de purga por troca × 230 camadas ≈ **89 g de purga para fazer ~44 g de
peça**, e nas últimas 43 camadas só imprimiam as duas cruzes dos reis — razão
de 65:1 de purga por peça naquele trecho. Separando por cor, a purga das peças
vai a **zero** e sobra só a do tabuleiro (~3 trocas).

A travessia também encolheu: o arranjo saiu de 2 fileiras de 8 (156 mm de
largura) para **4 × 4 a passo de 20 mm** (76,2 × 73,6 mm).

## O que vem no conjunto

Cada lado tem oito peões, duas torres, dois cavalos, dois bispos, uma dama e um
rei. As peças seguem uma silhueta Staunton simplificada e foram redesenhadas
para FDM: o cavalo é um perfil autoportante de 6 mm, a cruz do rei vence só
2,9 mm por lado e os recortes de torre, bispo e dama não exigem suporte.

| Peça | Quantidade | Dimensões de uma unidade |
|---|---:|---:|
| Peão | 16 | 13,6 × 13,6 × 24,5 mm |
| Torre | 4 | 16,0 × 16,0 × 28,8 mm |
| Cavalo | 4 | 16,0 × 16,0 × 33,5 mm |
| Bispo | 4 | 15,8 × 15,8 × 37,5 mm |
| **Dama** | 2 | 16,2 × 16,2 × **41,0 mm** |
| Rei | 2 | 16,2 × 16,2 × 46,0 mm |

**A dama subiu de 37,09 para 41,0 mm em 2026-08-28.** Ela estava 0,41 mm mais
baixa que o bispo, o que inverte a hierarquia Staunton e confunde a leitura no
tabuleiro. Os 3,9 mm entraram no pescoço (+2,5) e na coroa (+1,4); a base não
mudou. Agora a ordem é rei 46,0 > dama 41,0 > bispo 37,5 > cavalo 33,5 >
torre 28,8 > peão 24,5, e o `.scad` tem um assert que segura isso.

**O chanfro da base foi de 56° para 45°** nas 32 peças, na mesma data. O flare
subia 0,8 mm enquanto abria 1,2 mm de raio: 0,30 mm de avanço por camada contra
0,42 mm de largura de extrusão — cada cordão das quatro primeiras camadas
apoiava em só 29% da própria largura e saía caído. Agora `dr = dz`, o flare
sobe 1,2 mm (1,1 no peão) e **nenhuma altura total mudou**, só o ponto onde o
flare termina.

> A cruz do rei continua **sem chanfro**: os braços vencem 2,9 mm por lado em
> balanço reto. Decisão do usuário — fica registrado como risco conhecido pro
> teste físico.

No job de peças elas ficam em **grade 4 × 4** a passo de 20 mm nos dois eixos:
uma fileira de peões, torre/cavalo/bispo/dama, rei/bispo/cavalo/torre, outra
fileira de peões. A base mais larga tem 16,2 mm, então o menor vão entre duas
bases vizinhas é de **3,9 mm**, verificado par a par por assert no `.scad` nos
dois eixos.

O tabuleiro é uma única peça física: a cor clara forma uma laje contínua e as
32 casas escuras ocupam somente os 0,6 mm superiores. Um filete claro de 0,4
mm separa as casas escuras e evita fronteiras ambíguas no fatiador.

## Como abrir e imprimir

1. Abra o 3MF no Flash Studio e selecione **FlashForge AD5X 0.4 nozzle**.
2. No **job 1** confirme os dois componentes de cor e mande cada um pro seu
   slot do IFS: `COR_1_CLARA…` no claro, `COR_2_ESCURA…` no escuro. Não use
   **Organizar automaticamente** nem separe a montagem: os dois corpos já
   compartilham o alinhamento exato.
3. Nos **jobs 2 e 3** há um objeto só, de uma cor: escolha o filamento claro no
   job 2 e o escuro no job 3. Nada de troca, nada de torre de purga.
4. PLA, perfil 0,20 mm Standard, 2 paredes, suporte desligado.

### Brim

- **Job 1 (tabuleiro): ligue brim.** É uma laje de 168 × 168 × 3,6 mm — razão
  de 46,7:1 entre largura e espessura, o caso clássico de canto empenando e
  descolando. Com 5 mm de brim o job vai a 178 mm, contra os 220 da cama:
  cabe folgado.
- **Jobs 2 e 3 (peças): brim se a adesão estiver ruim.** Cada job é um objeto
  de build com 16 ilhas separadas na primeira camada, então o brim do Orca
  nasce em volta de **cada uma das 16 bases**. Com 3,9 mm de vão entre bases,
  use **largura de brim de 1,5 mm** (o padrão de 5 mm funde os brins dos
  vizinhos e vira uma placa só, chata de destacar). (O README anterior mandava
  "brim localizado só nas peças altas do job 2": isso era impossível, porque
  brim no Orca é por objeto de build e as 32 peças eram um objeto só.)

### Topo do tabuleiro

A face visível do tabuleiro é 168 × 168 mm de superfície plana sobre infill.
Use **5 camadas de topo** ou **infill ≥ 25%** nesse job — a 15% e 3 camadas o
pillowing aparece justamente onde ninguém quer, na cara do tabuleiro. Nas peças
15% continua valendo.

Ordem sugerida: imprimir **primeiro o tabuleiro** (18 camadas, job curto, e é
ele que valida cor e planicidade) e só depois os dois exércitos.

## Arquivos de referência e reposição

A pasta [`stl/`](./stl/) tem os três corpos de impressão
(`tabuleiro-claro`, `tabuleiro-escuro`, `exercito`) e um STL individual de cada
tipo de peça, pra imprimir reposição sem refazer o conjunto.

O [`xadrez-01.scad`](./xadrez-01.scad) é a fonte paramétrica; o cabeçalho dele
traz os comandos de export. Os `part`s de export são `board_light`,
`board_dark` e `army`; `preview` é só a vista dos três jobs lado a lado e
**não** é chapa de impressão. O helper [`make_3mf.py`](./make_3mf.py) monta os
três 3MF a partir dos STLs, centraliza cada montagem na cama de 220 e grava a
atribuição de filamento.

## Validação e pendências

- Export de 2026-08-28 conferido: sólidos batem (1 laje, 32 casas, 16 peças por
  exército), envelopes medidos com o `bbox.py` do `/bed-check` e **os três jobs
  cabem folgados** na AD5X.
- Alturas conferidas no bbox dos STLs, não no cálculo: dama 40,99 mm (alvo
  41,0), e peão/torre/cavalo/bispo/rei inalterados depois do chanfro de 45°.
- **Nenhum dos três jobs foi fatiado ainda** no Flash Studio. Os números de
  217,35 g / 11h30 / 230 trocas que circulavam antes são do fatiamento da
  **placa única antiga** e valem só como ordem de grandeza do material total.
- O modelo ainda **não foi impresso fisicamente**. Trate a primeira unidade
  como teste de planicidade do tabuleiro, adesão das 32 bases (agora com
  chanfro de 45°) e leitura visual das peças pequenas.

> **Histórico:** até 2026-08-26 este modelo era uma **placa única** de
> 168 × 248,2 mm, dimensionada para a Creality K2 (cama 260) — não cabia nos
> 220 mm da AD5X. Virou **dois jobs** naquele dia e os exports foram refeitos em
> 2026-08-28. Ainda em 28/08, depois do `print-review`, virou **três jobs** (o
> bicolor das peças foi partido por cor), a dama subiu para 41 mm e o chanfro de
> base foi para 45°. Os arquivos `xadrez-01-placa-bicolor.3mf`,
> `xadrez-01-cor-1-clara.stl`, `xadrez-01-cor-2-escura.stl`,
> `xadrez-01-pecas-bicolor.3mf`, `xadrez-01-pecas-claras.stl` e
> `xadrez-01-pecas-escuras.stl` saíram do repo: os `part`s que os geravam não
> existem mais.
