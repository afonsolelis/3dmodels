---
name: preview
description: Renderiza PNGs de um .scad (perspectiva + vista de topo) pra inspeção visual da geometria. Usar depois de qualquer mudança visual/estrutural num modelo e ANTES de exportar.
---

# Preview visual

1. Renderize pra um arquivo com NOME NOVO a cada render (nunca reutilizar —
   se o render falhar silenciosamente, você relê a imagem velha sem notar):
   ```
   flatpak run --env=DISPLAY=:0 --socket=x11 org.openscad.OpenSCAD \
     -o /var/home/afonsolelis/.cache/<nome-novo>.png --render \
     --imgsize=900,800 --camera=<cx>,<cy>,<cz>,60,0,25,<dist> /abs/.../<modelo>.scad
   ```
   (fora do sandbox; caminhos absolutos SEMPRE — relativo dá `Can't open
   input file`, que não contém "error" e escapa de grep)
2. Câmeras (`--camera=tx,ty,tz,rotx,roty,rotz,dist`; t = centro do objeto):
   - Perspectiva geral: rot `60,0,25`, dist ≈ 4–5x a maior dimensão
   - Topo, pra layout de chapa e sobreposição: `--projection=o` + rot `0,0,0`
3. Confira que o PNG foi escrito AGORA (`ls -la`; tamanho > 0).
4. LEIA a imagem e avalie de verdade: peças completas? lascas finas perto de
   recortes? furos onde deveriam estar? sobreposição na chapa? bandas/margens
   como planejado?
5. Achou problema → corrige e repete ANTES de exportar.
