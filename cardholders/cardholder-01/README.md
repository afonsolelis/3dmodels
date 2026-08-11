# cardholder-01

Porta-cartas aberto: chapa de fundo vazada em colmeia + **4 cantoneiras em L**
amarradas por **duas cintas fechadas** (meio e topo), sobre uma **cinta de pé**
integrada. Peça única, sem montagem, sem suporte.

## Por que este modelo existe

O `../card_holder_with_feet.3mf` (Don Julio, MakerWorld — arquivo de terceiro,
sem fonte) foi impresso e **reprovou no teste físico: ficou fraco**.

O diagnóstico saiu da medição do mesh dele: 4 cantoneiras de 2mm de parede com
**56mm de balanço**, soldadas numa chapa de 2mm por uma junta de só **2×10mm**
por braço. Cada poste é um balanço independente — não há nada amarrando um no
outro, então o quadro racka e os postes abrem sob o peso da pilha e da mão.
Os 4 pezinhos eram peça separada (pastilhas de ~5.7×5.7×4mm pressionadas nos
rebaixos Ø10 dos cantos) — funcionam, mas são 4 peças soltas pra montar.

Aqui a **geometria útil é a mesma** (bolso 66×90, parede 2mm, braços de 10mm,
56mm de curso de pilha), mas com três reforços que **não engrossam nenhuma
parede** — a rigidez vem da forma, não da espessura:

| Reforço | O que faz |
|---|---|
| **Cinta do meio** (z 26–32) | anel fechado 2×6mm que amarra as 4 cantoneiras nos dois eixos |
| **Cinta do topo** (z 52–58) | idem, onde o momento do balanço é máximo |
| **Cinta de baixo** (z 0–4) | anel recuado 4mm sob a chapa: vira o pé (substitui os 4 pezinhos soltos) **e** nervura da chapa, que deixa de ser placa solta |
| **Filetes de raiz** | gussets a 45° por baixo da chapa, na raiz de cada braço, espalhando o momento em vez de concentrar na junta de 2mm |

Resultado nos vãos livres de cantoneira: **20 / 20 / 4mm** em vez de um único
balanço de 56mm. É a mudança que importa — o comprimento livre entra ao cubo
na flecha, então cortar 56 pra 20 reduz a flexão de cada trecho em ~20×.

As cintas têm a abertura interna igual ao bolso (66×90), então a pilha continua
entrando e saindo por cima sem encostar em nada.

## Specs

- **Bolso**: 66 × 90mm — herdado do original, dimensionado pra **carta NUA**
  (63×88). **Sleeve penny (66×91) NÃO entra.** Pra sleeve, mudar
  `pocket_w`/`pocket_l` (68×93 penny, 69×94 double).
- **Externo**: 70 × 94 × 62mm
- **Curso de pilha**: 56mm acima da chapa ≈ **220 cartas nuas** (~0.25mm/carta)
- **Parede**: 2mm em tudo (cantoneiras, cintas, pé) — não engrossar
- **Chapa**: 2mm, colmeia hex Ø8 entre faces / teia 2mm / borda sólida 5mm,
  bloco centralizado (nenhum hexágono cortado)
- **Pé**: 4mm de altura, anel recuado 4mm da borda da chapa (footprint 58×82)
- **Área de 1ª camada**: 690mm² (4 cantoneiras + anel do pé)

## Verificação feita

- `Volumes: 2` no sumário CGAL → **um sólido único** (tudo conectado)
- Fatias do STL conferidas nos 7 níveis críticos: pé, chapa, vão 1, cinta do
  meio, vão 2, cinta do topo, ponta da cantoneira
- Níveis Z do sólido: `0, 4, 6, 26, 32, 52, 58, 62` — batem com o projeto
- Bed-check A1 mini: 70×94×62 (1 unidade) e 146×94×62 (chapa de 2) → **ok**

## Arquivos

- `cardholder-01.scad` — fonte paramétrico
- `stl/cardholder-01.stl` — peça individual
- `3mf/cardholder-01.3mf` — job: 1 unidade (70×94mm), pra testar
- `3mf/cardholder-01-x2.3mf` — job: 2 unidades lado a lado (146×94mm)

## Como gerar

```sh
flatpak run org.openscad.OpenSCAD -o stl/cardholder-01.stl    -D 'part="holder"' cardholder-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/cardholder-01.3mf    -D 'part="holder"' cardholder-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/cardholder-01-x2.3mf -D 'part="plate2"' cardholder-01.scad
```

## Impressão

- Chapa de fundo na mesa, cantoneiras pra cima. **Sem suporte.**
- Perfil de partida: `0.20mm Standard @BBL A1M`, 2 paredes, 15% grid — o mesmo
  do original. **Não precisa subir parede**; se subir, o ganho vai pro peso.
- **Ponte**: a face de baixo de cada cinta é uma ponte entre as cantoneiras
  (74mm no lado comprido, 50mm no curto). Como a seção da cinta tem 2mm, ela
  sai inteira em perímetro e as extrusões correm **ao longo** do vão,
  ancoradas nos dois postes — só a 1ª camada de cada cinta enruga, as de cima
  fecham normal. Não ligar suporte por causa disso.
- **Brim**: as cantoneiras têm pouca área na mesa. Brim auto costuma bastar;
  se descolar, brim manual de 5mm.

## Parâmetros que valem mexer

- `foot_inset = 0.25` (em vez de 4) → o pé vira espiga: uma unidade **vazia**
  encaixa dentro do bolso da de baixo e trava, em vez de só apoiar.
- `band_top_gap = 0` → cinta rente ao topo, mais rígido ainda; perde o
  respiro de 4mm que hoje deixa pinçar a pilha pelas pontas.
- `post_h` → curso de pilha. 56mm é o do original.

## Próximas iterações (ideias)

- Chanfro de entrada na aresta interna da cinta do topo, pra guiar a pilha
- Rebaixo pra etiqueta/divisória numa das laterais curtas
- Variante com bolso de sleeve (68×93), se o teste físico pedir
