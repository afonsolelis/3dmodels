# bgs-stand-01

Suporte de mesa pra **uma slab graduada Beckett (BGS)**, inclinada 12° pra trás.
**Duas peças**: o suporte e uma **tampa que encaixa por cima**. Nenhuma das duas
precisa de suporte de impressão.

## Como funciona

A slab fica presa nos quatro lados: **aba dos trilhos** na frente das bordas
laterais, **lábio da base** embaixo, **painel** atrás e **tampa** em cima. O
único caminho de saída é pra cima — e é a tampa que fecha esse caminho.

Pra colocar ou tirar: **puxa a tampa, a slab sai deslizando por cima.**

## Por que a tampa muda tudo

O modelo de terceiro que serviu de referência prende a slab com um **gancho fixo**
no topo. Gancho fixo obriga a slab a **bascular** pra entrar por baixo dele — e é
daí que vêm os dois problemas dele: o gancho vira um balanço de ~11 mm quase
horizontal (por isso o 3MF dele vem com **suporte ligado**), e ele cobre ~5,6 mm
da face da slab, bem em cima da etiqueta de nota da Beckett.

Com a tampa **removível**, a slab entra deslizando por cima, direto. Três coisas
saem de graça:

1. **Os trilhos podem ter aba.** Não precisa mais reservar espaço pra bascular,
   então os trilhos avançam 2 mm sobre cada borda lateral — captura de verdade,
   nos quatro lados.
2. **A etiqueta fica 100% livre.** A tampa fecha **acima** do topo da slab: ela
   encosta na aresta de cima, não na face. Verificado: a interseção entre tampa
   e slab é **vazia**.
3. **Tudo imprime sem suporte.** Trilho é parede vertical; a tampa, sendo peça
   separada, imprime deitada com o teto na mesa e a ranhura pra cima.

## O encaixe da tampa — dois apoios, não um

- uma **ranhura** desce sobre os 12 mm de painel que sobram acima da slab: é o
  que centra e segura a tampa;
- a **face de baixo** senta nos topos dos dois trilhos: é o batente que define a
  altura e fecha o vão por onde a slab sairia.

Ajuste deslizante de 0,25 mm/lado na ranhura (padrão do repo).

## Medidas

| | valor |
|---|---|
| **Slab (medida real, paquímetro 2026-08-11)** | **82,5 × 130,2 × 8,5 mm** |
| Vão interno | 83,3 × 130,7 × 9,3 mm |
| Folga | 0,4/lado na largura e na espessura, 0,5 no comprimento |
| Suporte | 44,1 × 87,3 × 142,6 mm |
| Tampa | 16,9 × 87,3 × 15,0 mm |
| Montado (com slab) | 46,8 × 87,3 × 148,0 mm |
| Chapa (as duas peças) | 56,8 × 87,3 × 142,6 mm |
| Base que apoia na mesa | 32,0 mm de profundidade × 87,3 |
| Inclinação | 12° da vertical |
| Face da slab à vista | 79,3 dos 82,5 mm de largura (96%) |
| Painel / parede do trilho / aba / parede da tampa | 3 / 2 / 2,5 / 1,8 mm |

Toda a peça é derivada de `slab_w`/`slab_h`/`slab_t`. Pra outra marca (PSA, CGC),
medir com paquímetro e trocar só esses três números.

## Verificação feita

- **Interferência, aos pares — as três combinações dão interseção VAZIA**:
  tampa × suporte, tampa × slab, suporte × slab. Nenhuma peça invade a outra, e
  a tampa não encosta na face da slab (logo, não cobre a etiqueta).
- **A tampa assenta de verdade**: com ela na posição de projeto a interseção com
  o suporte é vazia, mas **0,1 mm mais baixo já colide**. Ou seja, ela para
  exatamente onde deve — sem folga sobrando e sem forçar.
- **Balanço real: 0,0 mm² nas duas peças.** Varri as faces dos dois STL: no
  suporte, a única área virada pra baixo são os 2791 mm² de apoio na cama
  (= 31,97 × 87,3, confere com a base); na tampa, os 1471 mm² do teto na cama.
  Nenhuma face pendurada — daí não precisar de suporte, ao contrário do modelo
  de referência.
- **Tombamento** (medido na versão de peça única, geometria de base inalterada):
  centro de massa do conjunto em x=9,9, base apoiando de x=−11,5 a +20,4 →
  ~10,5 mm de margem pra trás.
- `Volumes: 2` em cada peça (sólido único) e `3` na chapa (as duas separadas).
- Bed-check A1 mini: suporte 44,1 × 87,3 × 142,6 e chapa 56,8 × 87,3 × 142,6 →
  **ok** nos dois.

> Nota sobre o `Volumes` do montado: dá 4 (suporte, tampa, slab e o exterior)
> mesmo com a tampa encostada no suporte — o CGAL conta sólidos que se tocam só
> por face como separados. Quem prova o assentamento é o teste do 0,1 mm acima.

## Por que trilho não é balanço

O trilho é um C que sobe junto com a inclinação. A cada camada a seção é a de
baixo deslocada 0,04 mm (tan 12° × 0,2 mm de camada) — sempre apoiada. A aba
parece um balanço olhando de lado, mas é contínua desde a base: cada fatia dela
apoia na anterior, igual às cantoneiras do `cardholder-01`.

## Arquivos

- `bgs-stand-01.scad` — fonte paramétrico
- `stl/bgs-stand-01-stand.stl`, `stl/bgs-stand-01-cap.stl`
- `3mf/bgs-stand-01.3mf` — job único com as **duas** peças já na orientação de
  impressão

## Como gerar

```sh
flatpak run org.openscad.OpenSCAD -o stl/bgs-stand-01-stand.stl -D 'part="stand"' bgs-stand-01.scad
flatpak run org.openscad.OpenSCAD -o stl/bgs-stand-01-cap.stl   -D 'part="cap"'   bgs-stand-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/bgs-stand-01.3mf       -D 'part="plate"' bgs-stand-01.scad
```

`part="check"` renderiza o conjunto montado com a slab fantasma, pra conferir
encaixe.

## Impressão

- **Sem suporte, sem brim.** Suporte: base na mesa, painel pra cima. Tampa:
  deitada, **teto na mesa e ranhura pra cima** — é como ela já sai na chapa,
  não girar no slicer.
- Perfil: `0.20mm Standard @BBL A1M`, 2 paredes.
- 143 mm de altura com base de 32 mm de profundidade: orientar os 87,3 mm ao
  longo do eixo que a cama movimenta (Y na A1 mini) — que é como o 3MF já sai.
- Se a tampa ficar dura demais ou frouxa, o ajuste é `cap_fit` (0,25 por lado
  hoje) — uma linha, re-exporta e pronto.

## Origem

Conceito medido na malha de `../display-box-graded/psa/my_psa_slab.3mf`
(Functional3D, MakerWorld, Standard Digital File License — arquivo de terceiro,
**não redistribuir**). De lá vieram só os números de referência: inclinação
11,9°, canal de 81,0 mm, painel de ~3 mm. A geometria daqui é toda nova.

## Próximas iterações (ideias)

- Colmeia hexagonal vazada no painel (identidade do repo; hoje é liso de
  propósito, pra servir de fundo pra slab)
- Chanfro nas arestas de baixo da tampa, pra disfarçar a linha de junta
- Versão de 2-3 slabs lado a lado, compartilhando base e tampa
- Rebaixo pra ímã na base, pra prender numa chapa metálica
