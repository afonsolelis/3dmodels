# Ferragens

**Ferragem impressa**: parafuso, porca, arruela, bucha, espaçador — as peças
de fixação que normalmente se compra em loja e que aqui saem da AD5X quando o
tamanho não existe no comércio, quando não pode ser metal (peso, isolamento
elétrico, não riscar a peça) ou quando é só pra prender de leve e o metal
seria exagero.

Pra caixa e organizador de ferramenta de bancada, ver
[`ferramentas/`](../ferramentas/).

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [parafuso-porca-01](./parafuso-porca-01/) | 🚧 em andamento | Jogo de **4 parafusos + 4 porcas**. Rosca métrica ISO (V de 60°) Ø3,7 × 14mm de **rosca total**, passo **1,25** (baixado dos 1,5 pedidos pra devolver 44% de núcleo: Ø2,35 em vez de Ø2,08). Cabeça **chata** Ø7,4×2,0 com serrilha de 12 canais e **sem fenda de chave de fenda** — o núcleo rompe em 25–55 N·mm e uma chave entrega 300–1000, então o aperto é **só de dedo** (20–30 N·mm). Porca sextavada **9,0 entre faces × 5,0** de altura (engrossada pra FDM), **3,04 voltas úteis** de engate. Folga de rosca **0,4 no diâmetro** (0,2/lado), mas **testar o cupom em 0,5**. Aperta até **9,0mm** de espessura, furo Ø4,4 na peça. **1 chapa dos 8 (100,4×38,1) + cupom de folga** |

## O que decide uma ferragem impressa

- **Passo × núcleo**: a rosca come o núcleo pelos dois lados
  (`d_núcleo = d − 1,0825 × passo` no perfil ISO). Em diâmetro pequeno, passo
  de catálogo grosso deixa o parafuso sem miolo — e o miolo é o elo fraco.
- **Camadas por passo**: abaixo de ~5 camadas por passo (1,0mm na camada de
  0,2) o flanco de 60° vira escada e a crista arredonda.
- **Folga de rosca ≠ folga de deslize**: a regra de 0,5/lado do CLAUDE.md é
  pra encaixe deslizante longo, onde o inimigo é o empeno. Rosca é encaixe
  curto e helicoidal: folga demais vira folga angular, a porca chacoalha e o
  dente perde área. 0,15–0,25/lado é a faixa útil.
- **Orientação**: rosca em pé imprime como contorno fechado por camada (sem
  suporte, crista redonda) mas põe o torque em cima da adesão intercamadas.
  Não existe orientação que resolva as duas coisas.
- **Torque de mão é limite físico**, não recomendação: sempre calcular o
  módulo de torção do núcleo e ecoar o torque de ruptura no `.scad` — e nos
  três patamares (torção pura, com pré-carga de aperto, com o entalhe da raiz
  do filete), porque só a torção pura é otimista por um fator de 2 a 3.
- **Não desenhar convite pra ferramenta.** Se a peça rompe em dezenas de
  N·mm, qualquer encaixe de chave (fenda, sextavado interno, quadrado) entrega
  centenas e destrói a peça. Ferragem impressa se aciona com o dedo, e a
  geometria tem que dizer isso: serrilha sim, fenda não.
- **Roscado útil ≠ altura da porca**: os funis de entrada das duas bocas comem
  rosca. Descontar `2 × lead_in` antes de contar voltas de engate, senão a
  área de cisalhamento sai inflada.
- **Erro de contorno soma nas duas peças**: com o perfil da rosca em XY, o
  macho é contorno convexo (sai grande) e a fêmea côncavo (sai pequeno). Os
  dois fecham a folga no mesmo sentido — sempre esperar que a primeira
  tentativa entre dura, e imprimir o cupom com a folga MAIOR da faixa.
- **Cupom antes do jogo**: rosca em FDM é o encaixe mais sensível do repo.
  Imprimir um par curto (~10 min) e medir na mão antes de gastar o jogo todo.

## Arquivos de terceiros nesta pasta

Nenhum — a categoria nasceu com o `parafuso-porca-01`, 100% paramétrico
e próprio.
