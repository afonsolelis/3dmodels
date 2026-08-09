# deckbox-03

Deckbox **cilíndrica de tampa roscada**, **lisa por fora e por dentro**. O
deck de 60 cartas com sleeve fica **em pé** no bolso retangular do meio; os
quatro segmentos de círculo que sobram entre o retângulo e a parede redonda
são os compartimentos de dados, moedas e contadores.

Ø114 × 102mm fechada. Duas peças, sem ímã, sem parafuso, sem suporte.

## A ideia

Um cilindro em volta de um deck retangular sobra espaço nos quatro cantos.
Em vez de jogar esse espaço fora, ele **é** o porta-dados — é isso que faz o
formato redondo ter função em vez de ser capricho:

```
        ,-------------.        poço LARGO (+Y)  28,9 x 96,1 x 77,25 = 146,6 cm³
      ,'  ,---------.  `.
     /  ,'           `.  \     nervura de canto (2mm) separa os 4 poços
    |  |   bolso do   |  |     e amarra o tubo central na parede
    |  |     deck     |  |
    |  |   70 x 47    |  |     poço ESTREITO (±X) 17,4 x 79,8 x 77,25 = 63,6 cm³
     \  `.           ,'  /
      `.  `---------'  ,'
        `-------------'        poço LARGO (-Y)
```

- **Poços largos** (2): 28,9mm de profundidade — d6 de 16mm à vontade
  (~20 dados jogados dentro de cada um), ou um monte de contador de dano.
- **Poços estreitos** (2): 17,4mm — um d6 de 16mm entra (sobra 1,4mm), mas
  só um por profundidade. É o poço de moeda, contador e dado pequeno.
- **Total lateral**: 420 cm³ de tralha, com o deck ainda no meio.

## Como se manuseia

1. Gira a tampa **240° (2/3 de volta)** e tira — rosca de 3 entradas.
2. O topo do deck fica **rente à boca** da caixa e sobra **15,75mm acima das
   paredes do bolso**. Enfia polegar e indicador pelos lados do gargalo
   (sobram ~28mm de folga de cada lado, o furo é Ø101,3 e o deck tem 45 de
   espessura) e puxa o deck inteiro pinçando pelas faces grandes.
3. Pra guardar, o topo do bolso tem funil de 45° — o deck entra guiado.
4. Fechando, a saia da tampa bate num **batente** (o ressalto do corpo) e
   para sempre na mesma posição, com o lado de fora liso e contínuo entre
   corpo e tampa (os dois têm o MESMO Ø114).

## Liso de propósito — não botar colmeia aqui

A regra 5 do `CLAUDE.md` manda usar a colmeia hexagonal "quando couber".
**Aqui não cabe**: o usuário pediu explicitamente "todo liso por fora e por
dentro" (2026-08-08). Sem colmeia, sem textura, sem relevo. Por fora é
acabamento; por dentro é função — parede lisa deixa a carta com sleeve
deslizar e não enroscar na hora de tirar o deck. Se um dia alguém "consertar"
o modelo botando hexágono, está desfazendo um pedido, não corrigindo um
esquecimento.

## A rosca

Primeira rosca do repo — não tem biblioteca, o módulo é próprio
(`thread_profile_2d` + `thread_rod`).

| | |
|---|---|
| Técnica | `linear_extrude(twist=...)` de um perfil 2D: o corte HORIZONTAL de uma rosca de n entradas é um disco com n dentes; girando esse disco enquanto sobe sai a hélice de verdade |
| Perfil | **trapezoidal** (nunca V agudo — em FDM o V lasca e imprime mal) |
| Entradas | **3** — abre em 2/3 de volta em vez de 2 voltas |
| Passo / avanço | 6mm por entrada / **18mm por volta** |
| Dente | 1,2mm de altura radial; flanco de 50° com a horizontal |
| Perfil angular | fundo 40° + flanco 20° + crista 40° + flanco 20° = 120° (= um passo) |
| Balanço | 39,8° do flanco + 3,0° da hélice = **42,8°**, abaixo do teto de 45° |
| Macho | Ø108,5 na crista / Ø106,1 no fundo, no gargalo do corpo |
| Fêmea | mesmo perfil com os raios + folga, na tampa |
| Folga | **0,35mm radial** (`thread_clear`) — é o número que o cupom testa |
| Engate | 12mm de gargalo = 2 passos cheios |
| Batente | a saia da tampa encosta no ressalto em z=84; sobram 2 × 3mm de ar (boca do corpo → teto da tampa, topo do deck → teto da tampa) |
| Mão | **direita** (fecha girando no sentido horário) — verificado empiricamente na malha |

### Por que 0,35 e não os 0,25 do repo

O padrão de deslize do repo é 0,25/lado, mas rosca é outro bicho: em Ø108 a
circunferência acumula erro, e num flanco de 50° a folga radial só vale
0,77× dela na perpendicular ao flanco. Começamos em 0,35 — e é justamente
por isso que existe o cupom.

### Conferido na malha (não é chute)

`part="fit_check"` faz a interseção booleana entre corpo e tampa montados:

- **Tampa assentada**: interseção **zero** — sobra só a face plana do
  batente em z=84 (1 facet, volume 0,00 mm³). Ou seja, macho e fêmea não se
  tocam em lugar nenhum e o que segura a tampa é o batente.
- **Tampa levantada 1,0mm sem girar**: interseção de **320 mm³** espalhada
  pelos 12mm de rosca (z 85,8 a 95,66). Ou seja, a rosca **engata de
  verdade** — não é folga demais, a tampa não sai puxando pra cima.
- O par do cupom dá exatamente o mesmo resultado do par grande.

## Imprimir: o cupom PRIMEIRO

`3mf/deckbox-03-teste-rosca.3mf` — um arquivo, **2 plates** (o Bambu Studio
mostra as duas na barra de baixo). É um pedaço do gargalo de verdade + o
anel da tampa, no **diâmetro real** e na **mesma orientação de impressão**
das peças grandes. 15mm de altura cada, ~42g somados.

Rosca em FDM só o teste na mão valida, e o corpo é um print de 161,6cm³
(~200g). Se travar, aumentar a folga; se bambear, diminuir — por override,
sem editar o modelo:

```sh
flatpak run org.openscad.OpenSCAD -o anel.stl \
    -D 'thread_clear_override=0.45' -D 'part="test_ring"' deckbox-03.scad
```

No **anel** do cupom vale ligar brim: ele encosta na cama só por uma coroa
de ~2,4mm de largura. O gargalo não precisa (a base dele é uma coroa de
6,4mm) e as peças grandes menos ainda (disco cheio de Ø114).

## Peças e jobs

| Peça | `part` | Job | Footprint | Sólido |
|---|---|---|---|---|
| corpo | `box` | `3mf/deckbox-03-box.3mf` | 114 × 114 × 96 | 161,6 cm³ (~200g) |
| tampa | `lid` | `3mf/deckbox-03-lid.3mf` | 114 × 114 × 18 | 46,0 cm³ (~57g) |
| gargalo de teste | `test_neck` | `3mf/deckbox-03-teste-rosca.3mf` (plate 1) | 114 × 114 × 15 | 18,1 cm³ (~22g) |
| anel de teste | `test_ring` | `3mf/deckbox-03-teste-rosca.3mf` (plate 2) | 114 × 114 × 15 | 15,4 cm³ (~19g) |

**Por que não tem chapa com tudo junto**: duas circunferências de diâmetro D
só cabem juntas num quadrado de lado S se `D ≤ S·(2−√2) = 0,586·S` — 105,4mm
na cama de 180 e 99,6mm no alvo confortável de 170. Corpo e tampa têm 114mm
cada: **nunca** cabem na mesma chapa, nem o par do cupom. Cada peça é um job,
e é isso mesmo. Todos os 3MF já saem **centrados na cama**.

### Orientação (nenhuma peça pede suporte)

- **corpo**: chão na cama, boca pra cima. Primeira camada = disco cheio de
  Ø114. Rosca externa a 42,8° de balanço; a transição interna da câmara pro
  gargalo é um cone de 45°; o ressalto do batente é um degrau pra DENTRO
  (a camada de cima é menor, não é balanço).
- **tampa**: **topo na cama**, boca pra cima. Assim a rosca interna imprime
  com os mesmos 42,8° e a primeira camada é o disco cheio. O `part="lid"` já
  sai virado — **não girar no slicer**.
- **anel do cupom**: sai virado do mesmo jeito que a tampa, de propósito —
  se imprimir de boca pra baixo o teste não reproduz o balanço real.

## Cadeia de medidas

Deck REAL medido com régua em 2026-08-08: **93 × 68 × 45mm** (60 cartas com
sleeve). Aqui ele fica **em pé**.

```
bolso   = 68 + 2×1,0 = 70 (X)  |  45 + 2×1,0 = 47 (Y)   folga de conteúdo 1mm/lado
tubo    = 70 + 2×2,0 = 74      |  47 + 2×2,0 = 51       parede do tubo 2mm
câmara  = Ø108,8  (114 − 2×2,6)                          parede do corpo 2,6mm
furo do gargalo = Ø101,3  >  diagonal do bolso 84,3  ->  o deck passa
altura  = 3 (chão) + 93 (deck) + 3 (ar) + 3 (teto da tampa) = 102
```

Cada milímetro de altura é justificado: nada de ar sobrando. O corpo tem
96mm (a boca fica rente ao topo do deck) e a tampa 18mm, com 12mm de rosca
+ 3mm de ar + 3mm de teto.

## Parâmetros que valem mexer

| Parâmetro | Default | Efeito |
|---|---|---|
| `thread_clear` | 0,35 | folga da rosca — **o número do cupom** (tem override) |
| `outer_d` | 114 | cada +2mm dá +1mm de profundidade nos 4 poços |
| `neck_h` | 12 | engate da rosca; 9 abriria em meia volta exata, com 3mm a menos de pega no deck |
| `head_clear` / `rim_gap` | 3 / 3 | ar sobre o deck e sobre a boca; mexer nos dois muda quanto o deck sobra pra fora |
| `content_clear` | 1,0 | folga em volta do deck (padrão do repo pra conteúdo) |

O modelo tem `assert()` nas relações que não podem quebrar (o deck tem que
passar pelo gargalo, o bolso não pode ficar tapado pelo ressalto, o deck tem
que sobrar ≥12mm pra pegar com o dedo). Mexeu num parâmetro e quebrou a
função, o OpenSCAD para na hora em vez de exportar peça ruim.

## Pendências

- Rosca **não testada fisicamente** — o cupom existe pra isso. Nenhum
  `.3mf` grande deve ser impresso antes do cupom passar.
- Grip da tampa: a pedido do usuário ela é lisa. Ø114 dá muito braço de
  alavanca, então torque não é problema; se escorregar na mão, o próximo
  passo é canelura vertical rasa (e aí sai do "todo liso").
