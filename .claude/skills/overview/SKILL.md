---
name: overview
description: Monta um 3MF de visualização com todas as peças de um projeto numa grade, cada peça um objeto separado. Usar quando o usuário quiser "ver tudo de uma vez" ou quando um projeto tiver muitas peças espalhadas por vários jobs.
---

# 3MF de visualização

Um projeto com muitos jobs (as placas do pokemon-game são 8) fica difícil de
enxergar como conjunto. Este 3MF põe tudo numa grade em que cada célula tem o
tamanho da cama, uma peça por célula.

```
python3 .claude/skills/overview/overview.py <saida.3mf> <peça1.stl> <peça2.stl> ... [--cell 180] [--cols 4]
```

1. Passe os STLs de `stl/` na ordem em que fazem sentido ser lidos (por
   exemplo, a ordem de montagem), não em ordem alfabética.
2. Cada STL vira um **objeto separado** no 3MF: o Flash Studio abre já
   dividido e o "Organizar tudo" distribui pelas plates sozinho.
3. Salve como `<modelo>-overview.3mf` na RAIZ da pasta do modelo, nunca em
   `3mf/` — aquela pasta é só pra jobs de impressão de verdade (contrato do
   CLAUDE.md). Documente no README do modelo que ele é só pra ver.
4. Confira depois de gerar: abra o zip e compare o bbox de cada objeto com o
   bbox do STL de origem (o `bbox.py` do /bed-check dá o segundo).

**Por que não fazer isso em OpenSCAD:** reimportar STL e unir as malhas passa
pelo CGAL, que estoura com `CGAL ERROR: assertion violation` em peça complexa
— a precisão perdida no round-trip do STL gera triângulos quase degenerados.
Aconteceu de verdade com o case do pokemon-game, cujo `.scad` é limpo. O
script não faz booleano nenhum: só copia e translada malha, então não tem o
que dar errado. (Este build do OpenSCAD também não importa 3MF, então trocar
a extensão não resolve.)
