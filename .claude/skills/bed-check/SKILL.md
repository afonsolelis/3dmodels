---
name: bed-check
description: Confere se peças e chapas cabem na cama da Bambu A1 mini (180x180x180) medindo o bounding box dos STLs exportados. Usar após export de modelo novo ou qualquer mudança de dimensões.
---

# Checagem de cama (A1 mini)

1. Rode o medidor de bounding box nos STLs do modelo (pra uma chapa 3MF,
   exporte um STL temporário da mesma `part` dentro do home e meça esse):
   ```
   python3 /var/home/afonsolelis/Repos/3dmodels/.claude/skills/bed-check/bbox.py <arquivo.stl> [...]
   ```
2. Critérios:
   - **ok**: X e Y ≤ 170 (margem pra brim/skirt), Z ≤ 180
   - **justo**: X ou Y entre 170 e 180 — avisar; brim/skirt podem não caber
   - **REPROVADO**: qualquer eixo > 180 — redesenhar a chapa ou dividir em
     mais jobs de impressão
3. Reporte a tabela peça × dimensões × veredito. Se reprovou, proponha a
   divisão de jobs (o contrato do repo: `3mf/` = um arquivo por job).
