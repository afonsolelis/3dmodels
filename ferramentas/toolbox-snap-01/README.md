# toolbox-snap-01

Caixa de ferramentas de bancada que ocupa a cama inteira da AD5X:
**206 × 208 × 60 mm** externos, layout interno fixo impresso junto com a
caixa e **tampa deslizante que dá um clique e trava** no fim do curso.

Duas peças, três jobs — e o primeiro deles é um **cupom de teste**.

## Imprima ISTO primeiro

`3mf/toolbox-snap-01-cupom.3mf` (126 × 60 × 20 mm, ~1 h, ~25 g). É a caixa
inteira encolhida para 60 × 60 mm com **a mesma seção de trilho, o mesmo
funil de boca, a mesma saliência de snap, o mesmo escalopo de dedo e a mesma
tampa com as duas linguetas flexíveis**. Ele valida folga do trilho, pé de
elefante, força do snap e pega **antes** de queimar 16–20 h na caixa grande,
que é a peça mais cara do repo para falhar na hora 14.

Provado na geometria que o cupom se comporta igual: interseção cupom ×
tampa-do-cupom **vazia** em 0, 15, 40 e 56 mm de curso e **12,934 mm³** em
6 mm — exatamente o mesmo número da caixa grande na mesma posição.

Se o cupom fechar com clique e abrir puxando pela saia, imprima a caixa e a
tampa. Se ficar duro, baixe `bump_h`; se ficar frouxo, suba.

## Como se usa

A tampa entra pela **boca** (o lado direito, a única parede baixa da caixa) e
corre no eixo X dentro de dois trilhos escavados nas paredes da frente e de
trás.

**Fechando**: corre livre até faltarem ~11 mm. Aí a ponta de cada uma das
duas **linguetas flexíveis** (cantilever de 8 × 24,5 mm recortado em U na
própria chapa, com o bolso na ponta) sobe na saliência de 1,0 mm do piso do
trilho. A tampa inteira sobe os 0,7 mm de folga e as linguetas **fletem os
0,3 mm que faltam** — para isso existe um alívio local de teto de 1,2 mm
sobre a saliência, senão a lingueta não teria para onde subir. No fim do
curso o bolso engole a saliência e as linguetas voltam: **clique**.

**Abrindo**: pega-se a **saia** (o puxador de 11 mm que desce por fora da
parede da boca, com colmeia antiderrapante). A ponta da saia é afunilada
(recua 2,2 mm) e a parede da boca tem **três escalopos de 45 × 9 mm** logo
abaixo dela — juntos abrem ~4 mm para o dedo entrar *atrás* da saia, não só
encostar nela. Puxando, a rampa de 45° do bolso converte o puxão em flexão
das linguetas e a tampa estala.

**Força estimada do snap**: lingueta de 8 × 3 mm com 20 mm de braço →
k ≈ 16,9 N/mm; 0,3 mm de flexão = **~5 N por lado, ~10 N no total** antes de
atrito e do fator da rampa. É estimativa de viga; quem decide é a mão.

## Interior (medidas úteis)

| Região | Medida | Para quê |
|---|---|---|
| Canaleta | 200 × 50 × 47 mm | alicate de **180 mm** deitado (10 mm de folga em cada ponta) |
| Grade 3 × 2 | 6 × (65 × 70,5 × 47 mm) | ferramenta miúda |
| Porta-bits | **25 encaixes** hexagonais | bits de 1/4" (6,35 entre faces), passo 12,5 mm |
| Canaleta que sobra na célula dos bits | 6,5 × 65 × 47 mm | haste fina (chave de fenda, broca) |

O porta-bits fica na **linha colada na canaleta, coluna do FUNDO do curso**
(`bit_row = 0`, `bit_col = 0`) — de propósito: a tampa sai em +X, então o
fundo é a **primeira** coisa que aparece. **65 mm de abertura já descobrem a
matriz inteira de bits.**

Bloco de 15 mm com furo cego de 12 mm: um bit de 25 mm **sobra 13 mm** para
fora, o suficiente para pinçar com dois dedos, e ficam **4,47 mm de ar entre
bits vizinhos**. O furo tem 6,95 mm entre faces — os 6,35 do bit mais
**0,3 mm por lado**, a folga de peça solta em cavidade do repo — e um funil
de 1,2 mm na boca. Como o furo é cego e **vertical**, não existe ponte reta a
vencer; o hexágono fica com vértice para +Y, na identidade ponta-pra-cima. O
bloco tem só o tamanho da matriz mais a margem, não enche a célula.

> **Tirar o alicate exige a tampa praticamente toda fora.** A canaleta tem
> 200 dos 206 mm de comprimento da caixa; isso é inerente ao layout pedido,
> não é defeito. Quem se usa com a tampa entreaberta é o porta-bits e a
> coluna do fundo.

## O ponto crítico: a folga do trilho

Curso de **202,7 mm** — o encaixe deslizante mais longo já feito neste repo —
numa chapa de 206 × 202,6 × 3 mm que imprime deitada e **empena**. A regra 6
do `CLAUDE.md` nasceu do deckbox-02 impresso, que travou no meio do curso com
0,25/lado, virou 0,5/lado e ficou com o aviso *"quanto mais longo o encaixe,
mais folga"*. Aqui foram para **0,7 mm por lado**, mais quatro decisões que
atacam o empeno em vez da tolerância nominal:

1. **Teto do trilho a 45°**, não degrau reto. Se a tampa subir, encontra uma
   rampa que a empurra de volta para baixo em vez de cunhar numa quina viva —
   e é a mesma geometria que faz a caixa imprimir sem uma única ponte.
2. **Funil de entrada na boca**: o piso do trilho cai 0,6 mm nos últimos
   8 mm; a tampa tem as duas quinas de ataque chanfradas em 45° e a face de
   baixo da aresta de ataque chanfrada 1,2 mm; e o **topo de cada divisória
   leva chanfro de 45° × 1 mm na aresta virada para a boca** (sem ele o
   nariz da tampa engancha na aresta viva — o piso do funil passa a 67 µm
   dela).
3. **Apoio central**: as duas travessas que separam canaleta/grade e as duas
   linhas da grade correm em X de parede a parede e param 0,4 mm abaixo da
   tampa. O maior vão sem apoio da tampa cai de **196 para 70,5 mm**.
4. **Engate de 3,3 mm por lado**, com 4 mm de rasgo.

### Pé de elefante: onde entra e onde não entra

Na **caixa** o trilho nasce em z = 50, longe da cama — ali não há pé de
elefante. Na **tampa é o contrário**: ela imprime de cabeça para baixo, então
as duas arestas longas da primeira camada (y = 2,7 e y = 205,3) **são as
pontas das linguetas do trilho**. Com 0,2–0,3 mm de pé de elefante a folga em
Y cairia de 0,70 para ~0,40 por lado. Por isso o perímetro inteiro da face de
cima da tampa leva um **chanfro modelado de 0,4 × 45°** — não se depende da
compensação do fatiador.

### Pega para carregar

Carregada a caixa passa de 1 kg e não tinha onde segurar. As duas paredes Y
(que têm 6 mm) ganharam um **rebaixo de 70 × 12 × 2,5 mm** em z 32–44,
centrado — sobram **3,5 mm** de parede, acima do mínimo de 3 mm do repo, e o
rebaixo fica 6 mm abaixo do piso do trilho, sem tocar a parede que o segura.
O teto do rebaixo é uma **rampa de 45°**, então imprime sem balanço. Nas
paredes X, de 3 mm, **não** há rebaixo: ali qualquer corte comeria a parede
inteira.

## O que foi verificado na geometria (não deduzido)

Todos os números abaixo saíram de interseção booleana entre as malhas e de
medição do volume do resultado.

- **Curso completo**: interseção caixa × tampa **vazia** em 0, 0,25, 0,28,
  0,30, 11, 12, 20, 60, 120, 190 e 200 mm. Ou seja: **191,7 dos 202,7 mm de
  curso são livres**, sem raspar em divisória nenhuma.
- **Zona do snap**: não-vazia continuamente de 0,32 até 10,5 mm — ~10,2 mm de
  engajamento, com pico de **12,934 mm³** em 6 mm. Não é evento pontual: é o
  trecho em que as linguetas estão fletidas. Toda a interferência mora em
  x 9–15 e z 50–51, exatamente sobre as duas saliências.
- **A lingueta tem para onde fletir**: levantando a tampa a altura INTEIRA da
  saliência (1,0 mm) dentro da janela de alívio (x 1–23), a interseção é
  **vazia**. O curso existe.
- **Folga longitudinal REAL do bolso**: livre em 0,30 mm de deslocamento,
  colide em 0,32 (0,1 mm³) → **0,30 mm por lado medidos na malha**, não os
  0,11 nominais-mas-falsos da primeira versão.
- **Retenção**: abrir 2 mm sem levantar dá 7,875 mm³ de interferência.
- **Captura no trilho**: levantar 0,7 mm é livre (folga nominal); 0,8 mm bate
  no teto a 45° (1,392 mm³); 4,0 mm dá 1.504 mm³. A tampa não sai por cima.
- `Volumes: 2` em cada peça (sólido único), e `Volumes: 2` também nas chapas
  com mouse ears — prova de que os discos estão **fundidos** na peça, não
  boiando.
- Bed-check aprovado nas três chapas.

## Jobs de impressão

| Arquivo | Conteúdo | Footprint |
|---|---|---|
| `3mf/toolbox-snap-01-cupom.3mf` | **imprima primeiro**: mini-caixa 60 × 60 + mini-tampa, mesma seção | 126 × 60 × 20 mm |
| `3mf/toolbox-snap-01-caixa.3mf` | caixa na orientação de uso, boca dos compartimentos para cima | 211 × 213 × 60 mm (206 × 208 + mouse ears) |
| `3mf/toolbox-snap-01-tampa.3mf` | tampa **de cabeça para baixo** (face de cima na cama), saia para cima | 211 × 207,6 × 11 mm (206 × 202,6 + mouse ears) |

**Sem suporte nas três. Sem brim — e isso é proposital**: brim de 5 mm daria
216 × 218 na caixa, fora do alvo de 210 do repo. No lugar dele as duas chapas
grandes trazem **mouse ears modelados** (4 discos de Ø10 × 0,4 mm nos cantos,
recuados 2,5 mm), que cabem nos 220 físicos da AD5X e não dependem de
configuração do fatiador. Quebram com a unha depois. Os footprints de 211 e
213 mm passam do limite de conforto de 210 do repo **de propósito**: é a
escolha entre cama cheia (o que o usuário pediu) e margem de brim.

A face de cima da tampa vai lisa de propósito — **exceção consciente à regra
5** do `CLAUDE.md` — justamente para dar uma primeira camada maciça de
~41.000 mm² de adesão. A colmeia fica nas quatro paredes da caixa e na saia,
sempre em **baixo-relevo de 1 mm**: não são furos passantes, a caixa continua
fechada e a parede que segura o trilho mantém 5 dos 6 mm de seção.

Volume sólido: caixa 433,4 cm³, tampa 128,0 cm³, cupom 34,1 cm³ (é o volume
da geometria; o que sai de filamento depende do preenchimento. Estimativa de
ordem de grandeza a 15%: ~200 cm³ / ~250 g / ~16 h a caixa, ~85 cm³ /
~105 g / ~7 h a tampa e ~20 cm³ / ~25 g / ~1 h o cupom. O número real quem dá
é o Flash Studio).

## Pendências

- **Nada foi impresso ainda.** O veredito é o teste físico — comece pelo
  cupom.
- O alicate foi parametrizado só pelo **comprimento (180 mm)** informado.
  **Largura e espessura seguem sem medida de régua**; 50 × 47 mm de vão deve
  sobrar, mas confirmar. A canaleta está parametrizada em `chan_w`.
- A força do snap é o ponto a calibrar na mão, via `bump_h` (1,0 mm hoje):
  cada 0,1 mm muda a flexão exigida da lingueta, que hoje é de 0,3 mm.
- Os rasgos em U de 1,6 mm deixam duas frestas na tampa junto à quina do
  fundo; peça miúda pode cair por ali para dentro da canaleta. É o preço do
  membro elástico.
- O que vai nos outros 5 compartimentos não foi definido — se aparecer
  ferramenta com medida certa, dá para mudar `cell_w`/`cell_d`/`grid_cols`.
