# toolbox-snap-01

Caixa de ferramentas de bancada que ocupa a cama inteira da AD5X:
**206 × 208 × 60 mm** externos, layout interno fixo impresso junto com a
caixa e **tampa deslizante que dá um clique e trava** no fim do curso.

Duas peças, dois jobs — não cabem juntas na cama (206 + 206 > 210).

## Como se usa

A tampa entra pela **boca** (o lado direito, a única parede baixa da caixa) e
corre no eixo X dentro de dois trilhos escavados nas paredes da frente e de
trás. Nos últimos ~9 mm do fechamento a aresta de ataque sobe em duas
saliências de 1,0 mm que ficam no piso dos trilhos, a chapa flexiona 0,3 mm e
cai em dois bolsos: é o **clique**. A partir daí a tampa só sai vencendo a
mesma saliência.

Para abrir, pega-se a **saia** — o puxador de 11 mm que desce por fora da
parede da boca, com colmeia antiderrapante na face externa — e puxa: a rampa
de 45° do bolso converte o puxão em levantamento, a tampa estala e corre
livre pelos ~193 mm restantes sem encostar em saliência nenhuma. A saia
também tampa a fresta da boca contra poeira.

## Interior (medidas úteis)

| Região | Medida | Para quê |
|---|---|---|
| Canaleta | 200 × 50 × 47 mm | alicate de **180 mm** deitado (10 mm de folga em cada ponta) |
| Grade 3 × 2 | 6 × (65 × 70,5 × 47 mm) | ferramenta miúda |
| Porta-bits | **25 encaixes** hexagonais | bits de 1/4" (6,35 mm entre faces), passo 11,5 mm |

O porta-bits ocupa um dos 6 compartimentos (linha do meio, coluna da boca) e
é um bloco de 15 mm com furo cego de 12 mm de profundidade: um bit de 25 mm
**sobra 13 mm** para fora, o suficiente para pinçar com dois dedos. O furo
tem 6,95 mm entre faces — os 6,35 do bit mais **0,3 mm por lado**, a folga de
peça solta em cavidade do repo — e ganha funil de 45° na boca. Como o furo é
cego e **vertical**, não existe ponte reta a vencer; o hexágono fica com
vértice para +Y, na identidade ponta-pra-cima.

## O ponto crítico: a folga do trilho

Curso de **202,7 mm** — o encaixe deslizante mais longo já feito neste repo —
numa chapa de 206 × 202,6 × 3 mm que imprime deitada e **empena**. A regra 6
do `CLAUDE.md` nasceu do deckbox-02 impresso, que travou no meio do curso com
0,25/lado, virou 0,5/lado e ficou com o aviso *"quanto mais longo o encaixe,
mais folga"*. Aqui foram para **0,7 mm por lado**, na vertical e na
horizontal, mais quatro decisões que atacam o empeno em vez da tolerância
nominal:

1. **Teto do trilho a 45°**, não degrau reto. Se a tampa subir, encontra uma
   rampa que a empurra de volta para baixo em vez de cunhar numa quina viva —
   e é a mesma geometria que faz a caixa imprimir sem uma única ponte.
2. **Funil de entrada na boca**: o piso do trilho cai 0,6 mm nos últimos
   8 mm, e a tampa tem as duas quinas de ataque chanfradas em 45° e a face de
   baixo da aresta de ataque chanfrada 1,2 mm.
3. **Apoio central**: as duas travessas que separam canaleta/grade e as duas
   linhas da grade correm em X de parede a parede e param 0,4 mm abaixo da
   tampa. O maior vão sem apoio da tampa cai de **196 para 70,5 mm** — é o que
   impede a barriga do meio de raspar ou cair.
4. **Engate de 3,3 mm por lado**, com 4 mm de rasgo: sobra retenção mesmo com
   a chapa encolhendo.

Não há alívio de pé de elefante no trilho porque o trilho **não nasce na
cama**: fica em z = 50 na caixa e, na tampa impressa de cabeça para baixo, no
topo do objeto.

## O que foi verificado na geometria (não deduzido)

- **Curso completo**, interseção booleana caixa × tampa em 11 posições:
  vazia em 0, 20, 60, 120, 190 e 200 mm — os ~193 mm de corrida são livres,
  sem raspar em divisória nenhuma. Não-vazia só em 2, 4, 6, 8 e 10 mm
  (1,8 a 21 mm³, sempre em x 9–15 e z 50–51, ou seja, exatamente as duas
  saliências): é a zona do snap.
- **Retenção**: tentar abrir 2 mm sem levantar dá 9,25 mm³ de interferência —
  a tampa fechada não sai sozinha.
- **Captura no trilho**: levantar 0,6 e 0,7 mm é livre (folga nominal);
  0,8 mm já bate no teto a 45° (1,4 mm³) e 4,0 mm dá 1.522 mm³. A tampa não
  sai por cima.
- `Volumes: 2` em cada peça (sólido único) e bed-check aprovado nas duas.

## Jobs de impressão

| Arquivo | Conteúdo | Footprint |
|---|---|---|
| `3mf/toolbox-snap-01-caixa.3mf` | caixa na orientação de uso, boca dos compartimentos para cima | 206 × 208 × 60 mm |
| `3mf/toolbox-snap-01-tampa.3mf` | tampa **de cabeça para baixo** (face de cima na cama), saia apontando para cima | 206 × 202,6 × 11 mm |

Sem suporte nas duas. Na **tampa, usar brim**: é a peça com risco real de
empeno, e a face de cima dela vai lisa de propósito (exceção consciente à
regra 5 do `CLAUDE.md`) justamente para dar uma primeira camada maciça de
~41.000 mm² de adesão. A colmeia fica nas quatro paredes da caixa e na saia,
sempre em **baixo-relevo de 1 mm** — não são furos passantes, a caixa
continua fechada e a parede que segura o trilho mantém 5 dos 6 mm de seção.

Volume sólido: caixa 444,6 cm³, tampa 129,2 cm³ (é o volume da geometria; o
que sai de filamento depende do preenchimento do fatiador — estimativa de
ordem de grandeza com 15% de preenchimento: ~200 cm³ / ~250 g / ~16 h a caixa
e ~85 cm³ / ~105 g / ~7 h a tampa. O número real quem dá é o Flash Studio).

## Pendências

- **Nada foi impresso ainda.** O veredito é o teste físico.
- O alicate foi parametrizado só pelo **comprimento (180 mm)** informado. A
  largura e a espessura dele não foram medidas com régua: 50 × 47 mm de vão
  deve sobrar de folga, mas confirmar.
- A força do snap é o ponto a calibrar na mão: se ficar duro demais, baixar
  `bump_h` (1,0 mm hoje); se ficar frouxo, subir. Cada 0,1 mm muda a flexão
  exigida da chapa, que hoje é de 0,3 mm.
- O que vai nos outros 5 compartimentos não foi definido — se aparecer
  ferramenta com medida certa, dá para mudar `cell_w`/`cell_d`/`grid_cols`.
