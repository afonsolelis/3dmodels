---
name: new-model
description: Cria a estrutura de um modelo novo (ou categoria nova) no padrão do repo — pasta, .scad com as convenções, stl/ e 3mf/, linha na tabela do README. Usar quando o usuário pedir um projeto ou modelo novo.
---

# Modelo novo

1. **Medidas primeiro**: garanta as medidas REAIS do objeto que a peça vai
   servir (regra do repo: medido com régua > catálogo). Se faltar, pergunte
   ao usuário antes de modelar — já erramos deck por estimar sleeve.
2. Caminho: `<categoria>/<modelo-NN>/` (categoria em inglês no plural, como
   `deckboxes`, `rings`; modelo numerado, ex. `ring-01`). Categoria nova
   ganha `README.md` com tabela de modelos (formato do `deckboxes/README.md`)
   e entra na árvore do `README.md` raiz.
3. Escreva `<modelo>.scad` nas convenções do repo (referência: deckbox-01):
   - Cabeçalho: o que é a peça, como o usuário MANUSEIA ela no mundo físico,
     e os comandos de export canônicos (STL e 3MF)
   - Grupos `/* [Nome] */` de parâmetros, cada um com unidade e propósito
   - Seção `// Derivados` calculando tudo a partir dos parâmetros
   - Folgas padrão: deslize 0.25/lado; peça solta 0.3/lado; ímã 0.15
   - Identidade visual: colmeia hexagonal de ponta pra cima, quando couber
   - Variantes por include: parâmetros de variante via
     `x = is_undef(x_override) ? padrao : x_override` (ver deck_lanes)
   - Se houver mais de uma peça: `part="plate"` com tudo em orientação de
     impressão, respeitando a cama de 180x180 (dividir em jobs se preciso)
4. Crie `stl/` e `3mf/`; depois rode, nesta ordem: `/preview` (olhar),
   `/export` (gerar), `/bed-check` (medir).
5. Rode o agente `print-review` antes de dar o modelo por pronto.
