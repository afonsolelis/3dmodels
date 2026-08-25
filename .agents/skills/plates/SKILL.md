---
name: plates
description: Monta UM 3MF de projeto do Flash Studio com várias plates dentro, em vez de um arquivo por chapa. Usar quando um projeto tiver muitos jobs de impressão e o usuário quiser abrir uma vez só e imprimir plate por plate.
---

# 3MF multi-plate (projeto do Flash Studio)

O 3MF que o OpenSCAD exporta só sabe de UMA chapa: um projeto com 15 jobs
vira 15 arquivos pra abrir na mão. O Flash Studio tem um formato de PROJETO
que guarda várias plates no mesmo arquivo — é o que este script escreve.

```
python3 .Codex/skills/plates/plates.py <saida.3mf> \
    --plate "Nome da plate" peca.stl [peca2.stl ...] \
    --plate "Outra plate"   peca3.stl ... \
    [--bed 220] [--usable 210] [--gap 5]
```

1. As peças vêm de `stl/` (o script lê STL ASCII ou binário) e entram na
   ordem em que fazem sentido imprimir. **Uma plate pode ter mais de uma
   peça**: o script arruma em fileiras e centraliza o conjunto na cama.
2. `--usable` é a área útil (210 por padrão, a margem de brim do AGENTS.md).
   Peça que não couber **estoura o script** de propósito — melhor falhar aqui
   do que gerar plate com peça pra fora, que só aparece no slicer.
3. Salve em `3mf/` (é job de impressão de verdade, o contrato do AGENTS.md
   vale). Nome sugerido: `<modelo>-todas-as-plates.3mf`.
4. **Confirme no Flash Studio** depois de gerar: as plates têm que aparecer
   na barra de baixo, cada uma com a peça certa e centrada. Este passo não dá
   pra automatizar aqui — o slicer não roda headless nesta máquina.

## Como o formato funciona

Engenharia reversa de `diversos/Jabonera.3mf` (projeto do Bambu Studio
02.07.01 pra A1 mini — o formato é o mesmo que o Flash Studio lê, por ser
fork do OrcaSlicer). Duas peças:

- `3D/3dmodel.model` — os objetos e um `<item>` por peça, com a translação
  num espaço VIRTUAL onde cada plate ocupa uma célula de `cama * 1.2`
  (220 → 264mm). A peça fica centrada em `origem_da_plate + (110, 110)`.
- `Metadata/model_settings.config` — as tags `<plate>`, cada uma com
  `plater_name` e a lista de `object_id` que moram nela.

Plate `i` (0-based) com `cols = ceil(sqrt(n))`:
`origem = (i % cols * 216, -(i // cols) * 216)` — **Y cresce pra baixo**.

Os dois mecanismos são redundantes de propósito: mesmo que o Flash Studio ignore o
`model_settings.config`, a posição sozinha já joga cada peça na plate certa.

**Não escrevemos `Metadata/project_settings.config`.** Sem ele o Flash Studio
aplica o perfil de impressora/filamento que o usuário já tem selecionado, em
vez de arrastar junto o perfil de outra pessoa (o Jabonera, por exemplo, vem
com 4 filamentos e um perfil de 0.1mm que não é o nosso).

## Conferir o resultado sem abrir o slicer

Leia o 3MF de volta, some a translação do `<item>` ao bbox do objeto e veja
se cai dentro de `[origem, origem+220]` da plate que o config declara, com
`z0 == 0` (apoiado na cama). É essa checagem que pega peça deslocada.
