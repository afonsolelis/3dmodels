---
name: export
description: Exporta STL e 3MF de um modelo OpenSCAD do repo com verificação anti-falha-silenciosa. Usar após QUALQUER mudança de geometria num .scad, ou quando o usuário pedir export/3mf/stl.
---

# Export de modelo

1. Leia o cabeçalho do `.scad` do modelo — ele documenta os comandos de
   export canônicos (quais `part`s existem e quais 3MF são jobs de impressão).
2. Monte os comandos com **caminhos absolutos** de entrada E saída:
   ```
   flatpak run org.openscad.OpenSCAD -o /abs/.../3mf/<job>.3mf -D 'part="..."' /abs/.../<modelo>.scad
   ```
   (rodar fora do sandbox; o flatpak não enxerga /tmp nem o scratchpad)
3. Filtre a saída com `grep -E "Volumes|ERROR|WARNING|Can't"` — o erro
   `Can't open input file` NÃO contém "error" e passa batido em filtros
   comuns.
4. Verifique o resultado de verdade:
   - `ls -la` nos arquivos gerados: mtime de agora, tamanho > 0
   - `file *.3mf` deve acusar "Zip archive"
   - `Volumes: N` = sólidos esperados + 1 (ex.: chapa com 3 peças → 4)
5. Contrato do repo: `3mf/` contém SÓ jobs de impressão; STL individual vai
   em `stl/`. Se a geometria mudou e o modelo tem chapa (`part="plate"`),
   re-exportar a chapa também — o usuário abre o 3MF direto no Bambu Studio.
6. **Atualize o `index.json` (SEMPRE)**: a entrada do projeto precisa
   refletir o export — `print_jobs` (arquivo, conteúdo, footprint medido
   com o bbox.py do /bed-check), medidas-chave e notes. O agente devops
   recusa commit com index defasado.
7. Reporte o que foi exportado, com os footprints relevantes.
