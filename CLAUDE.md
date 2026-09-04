# 3dmodels — guia do agente

Modelos paramétricos em OpenSCAD pra impressão 3D. Impressora alvo (a ÚNICA
do usuário): **FlashForge AD5X** — cama 220x220x220, bico 0.4, PEI flex, e
**IFS de 4 cores** pra multicolor. Mirar footprint ≤210x210 pra sobrar margem
de brim. O usuário abre os `.3mf` direto no **Flash Studio Desktop**
(ex-Orca-Flashforge, fork do OrcaSlicer) e imprime; o feedback dele é do
TESTE FÍSICO da peça na mão.

## Estrutura e contrato de pastas

- `<categoria>/<modelo>/<modelo>.scad` — fonte paramétrico único do modelo
- `<categoria>/<modelo>/3mf/` — SÓ os jobs de impressão (chapas "plate" já em
  orientação de impressão; o que não couber na cama vira job separado)
- `<categoria>/<modelo>/stl/` — peças individuais, referência secundária
- `<categoria>/README.md` — tabela de modelos (adicionar linha a cada modelo)
- `index.json` (raiz) — catálogo machine-readable de TODOS os projetos
  (descrição, parts, jobs de impressão com footprints, medidas-chave).
  Consultar primeiro pra contexto rápido; atualizar SEMPRE junto com
  qualquer mudança de modelo — o agente devops recusa commit sem isso.
- O cabeçalho de cada `.scad` documenta os comandos de export canônicos

## Regras de qualidade (aprendidas em iterações reais)

1. **3MF sempre em dia**: qualquer mudança de geometria re-exporta os `.3mf`
   na hora, sem o usuário pedir.
2. **Medida real > catálogo**: parametrizar pelo objeto medido com régua pelo
   usuário (ex.: deck com sleeve = 93x68x45, não "63x88 + estimativa de
   sleeve"). Se faltar medida, PEDIR antes de modelar.
3. **Mecanismo tem que funcionar na mão**: simular o curso COMPLETO do
   movimento, alcance de dedo e se o conjunto montado ainda desliza/fecha.
   (Lição: o elevador com aba do deckbox-01 tinha 10mm de vão pra um curso de
   48mm e travava a capa — foi impresso e rejeitado.)
4. **Sem lascas**: cortes booleanos perto de bordas criam fragmentos finos;
   deixar faixa sólida (ex.: `skip_w` do `hex_panel` no deckbox-01).
5. **Identidade visual**: colmeia hexagonal, hexágonos de ponta pra cima
   (imprimem em parede vertical sem ponte reta).
6. **Folgas padrão do repo**: deslize bandeja/capa **0.5/lado**; peça solta em
   cavidade 0.3/lado; press-fit de ímã 0.15; conteúdo ~1mm/lado.
   (Era 0.25/lado até 2026-08-10, quando o deckbox-02 impresso TRAVOU NO MEIO
   DO CURSO e não saiu mais. Em deslize longo o inimigo não é a tolerância
   nominal e sim o EMPENO: tubo alto impresso em pé barriga pra dentro,
   cavidade em XY sai subdimensionada, sólido em XY sai superdimensionado e
   ainda tem pé de elefante. Quanto mais longo o encaixe, mais folga — e
   sempre com chanfro de entrada na boca.)
7. **Verificar de verdade**: renderizar PNG e OLHAR a imagem; ecoar dimensões
   derivadas; conferir que os exports existem (mtime/tamanho).
8. **index.json sempre em dia**: toda mudança de modelo atualiza a entrada
   no catálogo (jobs, footprints, medidas) no mesmo fluxo.

## OpenSCAD nesta máquina (armadilhas!)

- Usar SEMPRE `flatpak run org.openscad.OpenSCAD ...` — não existe `openscad`
  no PATH desta máquina.
- **Versão: 2021.01, branch `stable` do flathub**, reinstalado em 2026-08-28
  (o flatpak tinha SUMIDO da máquina e o erro era `app/org.openscad.OpenSCAD/
  x86_64/master não instalado`, que não parece falta de instalação). Se um
  `.scad` do repo usar recurso de versão nova (`textmetrics`, `roof`,
  `exact` em `offset`), é aqui que ele quebra. Reinstalar com
  `flatpak install -y flathub org.openscad.OpenSCAD`.
- A ordem das facetas no STL exportado NÃO é estável entre versões: dois
  exports da MESMA geometria podem diferir byte a byte. Pra saber se algo
  mudou de verdade, comparar nº de triângulos + bbox + hash do conjunto
  ORDENADO de vértices, nunca `cmp`/`diff` cru.
- PNG (render offscreen) exige `--env=DISPLAY=:0 --socket=x11`.
- O flatpak NÃO enxerga `/tmp` nem o scratchpad — entrada e saída no home.
- Caminhos SEMPRE absolutos: com relativo o erro é `Can't open input file`,
  que NÃO contém "error"/"warning" — `grep -i error` deixa a falha passar.
  Sempre conferir existência/mtime do arquivo de saída depois.
- No sumário CGAL, `Volumes: N` = nº de sólidos + 1 (o exterior conta).
- PNG de verificação: nome de arquivo NOVO a cada render (senão dá pra reler
  imagem velha sem perceber) e sempre LER a imagem depois.

## Fluxo multi-agente (orquestrado pelo loop principal)

Agentes não se chamam entre si — o loop principal aciona na ordem. O
modeler termina o relatório pedindo o devops; atenda esse pedido.

**Projeto novo:**
1. `modeler` — modela tudo: medidas reais → .scad → preview → STL →
   bed-check (AD5X) → 3MF com a melhor disposição → index.json → README
2. `print-review` — audita função física, imprimibilidade e dimensões
3. `devops` — gate de qualidade, commits nos padrões e push

**Mudança em modelo existente:** `modeler` (re-export incluso) →
`print-review` se a mudança for estrutural → `devops`.

Skills de apoio (usadas pelo modeler e disponíveis como /comando):
`/preview`, `/export`, `/bed-check`, `/new-model`, `/overview`, `/plates`.

## Commits

Sempre via agente `devops`, e só quando o usuário pedir pra versionar.
Convenção do log: `feat|fix|build|chore(<modelo>): descrição` em pt-BR.

**Tudo vai direto na `main`** — sem branch, sem Pull Request. O usuário é a
única pessoa que mexe neste repo, então PR só criava cerimônia sem ninguém
do outro lado pra revisar. O que segurava a qualidade não era o PR e sim o
gate do devops (index.json em dia, exports em dia, README) mais o
`print-review` — esses continuam valendo, e o veredito final é o TESTE
FÍSICO da peça na mão do usuário, que acontece depois do commit.
