# penny-holder-01

Caixa aberta para cartas com **penny sleeve**, guardadas **deitadas na aresta
longa, em duas camadas**. É uma gaveta de fichário em pé: 74,2 × 102,7 ×
150mm, boca aberta em cima e uma **janela de vão contínuo na frente**, do piso
até o alto, **sem travessa nenhuma no meio**. Empilhável, com colmeia
hexagonal no piso e nas duas laterais e no fundo.

Capacidade estimada: **~300 cartas** (2 camadas de ~153 nos 69mm de pilha).

## De onde veio

Derivado do `../PennySleeveHolder_Stackable_Colmeia_80mm.3mf` — *Stackable
Penny Sleeve Holder*, de **Sazabi** (MakerWorld), **MakerWorld Exclusive
License**, que por sua vez já é o derivado de alguém com o piso em colmeia.

> **Não republicar o 3MF de origem.** É por causa dessa família de licenças que
> o repositório virou privado em 2026-08-09. Este `.scad` é **reconstrução
> paramétrica própria**: nada da malha foi copiado, só medidas de engenharia
> reversa (envelope 74,2 × 102,7 × 80,0; parede 2,6; vão 69,0 × 97,5; ressalto
> de empilhamento z 0..3; topo do piso em z=10; célula de piso de 24mm com
> nervura de 1,6 e moldura de 3,0).

## ⚠️ A medida da carta é catálogo, não régua

`card_w` × `card_h` = **66 × 91mm** (carta 63 × 88 + penny sleeve) vem de
catálogo. O usuário foi perguntado e optou por seguir assim — mesmo risco
assumido dos slabs PSA deste repo (ver [o bloco de alerta da
categoria](../README.md)).

A caixa **inteira** é derivada desses dois números:

```
altura       = piso 10 + camadas × card_w + ar 8      = 10 + 132 + 8 = 150
profundidade = card_h + 2 × folga 3,25 + 2 × parede   = 91 + 6,5 + 5,2 = 102,7
```

Então **medir com régua e re-exportar conserta o modelo todo**. Em Z o efeito é
alavancado: cada 1mm a mais de largura de carta cresce **2mm** na altura da
caixa, e o teto de 180 da A1 mini só é atingido com `card_w = 81`.

## ⚠️ A camada de baixo é arquivo, não é a camada de giro

Foi a conta pedida, e o resultado é este: com **duas camadas e sem
prateleira**, tirar uma carta da camada de baixo puxando pela janela deixa uma
fenda de ~0,5mm embaixo da carta que estava por cima — e essa carta cai dentro
da fenda (66mm de queda) ou emperra torta.

**Não existe conserto dentro dos 150mm.** Uma prateleira no meio seria uma
ponte de 69 × 93mm no ar, que é exatamente o defeito removido do original (a
travessa traseira, com ponte plana de 53 × 2,6mm), e ainda comeria os 8mm de
folga que sobraram. Os caminhos honestos são:

- **(a)** usar a camada de baixo como estoque e a de cima como giro; ou
- **(b)** imprimir **duas caixas de uma camada** e empilhar — o ressalto e a
  chaveta existem exatamente pra isso, e aí cada camada tem boca própria:

  ```scad
  // penny-holder-01-1camada.scad
  layers_override = 1;
  include <penny-holder-01.scad>   // caixa de 84mm
  ```

A camada de **cima** não tem esse problema: a boca é aberta, a carta sai reta
pro ar livre.

## Jobs de impressão

| Job | Conteúdo | Footprint (medido com `bbox.py`) | Material |
|---|---|---|---|
| `3mf/penny-holder-01-plate.3mf` | 1 caixa | 74,2 × 102,7 × 150,0mm → **ok** | 78,0cm³ (~97g) |
| `3mf/penny-holder-01-par.3mf` | 2 caixas, vão de 6mm | 154,4 × 102,7 × 150,0mm → **ok** | 156,1cm³ (~194g) |

Nos dois casos a caixa vai com os **102,7 no eixo Y**, que é o eixo que a cama
da A1 mini balança: base maior contra a inércia de uma torre de 150mm.

`stl/penny-holder-01-box.stl` é a peça avulsa, de referência.

## Como se manuseia

1. A caixa fica de pé com a **janela grande virada pra você**. As cartas entram
   deitadas: os 91mm no sentido frente-fundo, os 66mm de pé, e a pilha cresce
   da esquerda pra direita, atravessando os 69mm de vão.
2. **Guardar**: pela boca, que é aberta e livre (69,0 × 97,5, sem nenhum
   estrangulamento — a cinta é rente à parede, não avança pra dentro). Enche a
   camada de baixo, empurra o bloco pro fundo, e a segunda camada senta em cima
   da primeira, apoiada na aresta de 91mm.
3. **Tirar da camada de cima**: mão pela boca, abre a pilha com o polegar, puxa
   a carta pra cima. Não existe teto pra bater.
4. **Tirar da camada de baixo**: pela janela da frente — é por isso que ela vai
   do piso ao alto sem travessa. O peitoril está **rente ao piso** (z=10), sem
   degrau pra carta enroscar. Ler o aviso acima antes de contar com isso.
5. **Empilhar**: a caixa de cima desce na boca da de baixo, e **só entra numa
   orientação** (janela com janela). Virada, ela para 3mm alta e óbvia.

## O que mudou em relação ao original

| # | Mudança | Por quê |
|---|---|---|
| 1 | Altura 80 → **150** | decisão do usuário: duas camadas dentro de uma caixa só |
| 2 | Frente **sem travessa no meio** | decisão do usuário; vão único de 58,2 × 132 |
| 3 | Travessa traseira **deletada** | no original é uma ponte plana de 53 × 2,6mm (90° de balanço), o pior ponto da peça |
| 4 | Colmeia **também nas paredes** | 150mm de arco ogival exigiria mais uma travessa (mais uma ponte); colmeia empilha fileiras sem nenhum plano horizontal |
| 5 | Chaveta **redesenhada** | a do original deixa 0,3–0,6mm de parede atrás do rasgo; aqui a parede fica com os 2,6mm inteiros |
| 6 | Folga do ressalto 0,20 → **0,25**/lado, + chanfros | padrão de deslize do repo, e 1,0mm de erro lateral aceito ao empilhar |

O que amarra os lados, no lugar da travessa: a **cinta de 8mm** que fecha a
volta no alto (o segmento da frente trabalha em tração, 2,6 × 8 = 20,8mm², ~620N
em PLA), o **piso em colmeia de 10mm** de profundidade, que é um diafragma
rígido embaixo, e os dois **montantes de 8mm** ao lado da janela, que dão a cada
lateral uma seção em L de 8 × 8mm correndo os 150mm de altura.

## Colmeia: bico de 45° nas paredes, regular no piso

A auditoria da malha exportada pegou que no **hexágono regular** os dois
flancos do bico ficam a **30° da horizontal** — ou seja 60° de balanço, *pior*
que os 45° que o resto da peça respeita (3094mm² de teto de furo ruim na
primeira versão). Dois motivos pra consertar, e o segundo decide:

- 30° faz cada camada avançar 0,35mm sobre a anterior (camada de 0,2mm), ~17%
  de linha apoiada contra ~52% num teto de 45°;
- **30° é exatamente o limiar de suporte padrão do Bambu Studio**, e o usuário
  fatia com suporte ligado. Teto no limiar é sorteio, e o prêmio é suporte
  dentro dos 47 furos, num rasgo de 2,6mm de profundidade de onde não se tira.

A célula das paredes virou **24 × 32mm** (lateral reta de 8 + bico de 45° de
12mm), com o passo entre fileiras recalculado para manter a nervura de 2,6mm
**também na costura diagonal**. No **piso** a célula segue o **hexágono
regular de 24mm** medido no original: piso é horizontal, os furos são prismas
verticais, não há teto pra pender.

## Impressão

**Em pé, boca pra cima, sem suporte, com brim.** Inventário de balanço medido
na malha exportada (área de face virada pra baixo, por ângulo da horizontal):

| Faixa | Área | O que é |
|---|---|---|
| 0–15° | 1029mm² | **só** a aba do corpo em z=3 — o assento do empilhamento |
| 15–44° | **zero** | — |
| 45° exatos | 4230mm² | tetos de furo, águas da janela, rampa da chaveta, chanfro do pé |

Ou seja **100% das faces inclinadas estão em 45°**, o mesmo padrão que o
original cumpre. Primeira camada colada na cama: **1739mm²** (moldura de 2,6mm
em toda a volta do ressalto + as nervuras da colmeia do piso) — daí o brim, numa
torre de 150mm.

A aba de z=3 é o único plano horizontal sem apoio e está lá **de propósito**: é
ela, contra o aro da caixa de baixo, que faz o assento do empilhamento. Um
chanfro de 45° no lugar dela imprimiria mais bonito e deixaria a caixa de cima
sem apoio nenhum, afundando até bater nas cartas.

> **Suporte:** o modelo não precisa de nenhum, e pode ser fatiado com suporte
> desligado. Com suporte ligado, o único lugar em que o fatiador pode querer pôr
> algo é embaixo dessa aba, a 3mm da cama — anel fino que sai com a unha, **mas
> ele encosta justo na superfície de assento**. Se as caixas ficarem bambas
> empilhadas, o primeiro suspeito é resto de suporte, não a geometria.

## Empilhamento, conferido na geometria

Curso completo, simulado com número antes do export:

```
separação 1,00mm   chanfro de 0,4 do pé encontra o funil de 0,6 da boca
                   (1,0mm de erro lateral de mão aceito)
separação 0,60mm   entra o reto: ressalto 68,5 × 97,0 em boca 69,0 × 97,5,
                   0,25/lado — e a chaveta decide a orientação
separação 0,00mm   assenta. 2,0mm de engate reto; o batente é a ABA contra o
                   ARO, nunca o fundo do ressalto contra carta
```

Com a caixa cheia, o topo da carta fica em z=142 e o ressalto da caixa de cima
desce até z=147 → **5mm de ar**.

Duas provas na geometria, e não no desenho:

| `part=` | Resultado exigido | Medido |
|---|---|---|
| `fit` | as duas caixas empilhadas certo: **vazio** | 0,00mm³ — sobra só a face plana do assento em z=150 |
| `fit180` | a de cima virada: **não-vazio** | 93,24mm³ em z 147..150 (a chaveta batendo na moldura cheia do piso) |

Sem o `fit180`, o `fit` vazio passaria por vacuidade: chaveta de altura zero não
colide com nada e o `fit` sai vazio igual.

## Medidas-chave

| | |
|---|---|
| Externo | 74,2 × 102,7 × 150,0mm |
| Vão interno | 69,0 × 97,5 × 140mm |
| Parede | 2,6mm (do piso ao aro) |
| Piso em colmeia | 10mm de profundidade, célula 24mm, nervura 1,6mm, moldura 3,0mm |
| Camadas | 2 × 66mm = 132mm; topo da carta em z=142 |
| Janela da frente | 58,2 × 132mm; ombro em z=112,9, bico em z=142, águas de 45° |
| Cinta | 8mm, rente à parede |
| Montante da janela | 8mm (flange de 5,4mm na lateral) |
| Colmeia das paredes | célula 24 × 32mm, bico 45°, nervura 2,6mm, 47 furos (17+17+13) |
| Ressalto de empilhamento | 68,5 × 97,0 × 3,0mm, folga 0,25/lado, engate reto 2,0mm |
| Chaveta | 36 × 1,2mm em rasgo de 36,6 × 1,5mm; mordida de 0,95mm se empilhar virado |

Folga da carta no comprimento: **3,25mm/lado**, e não o 1,0 de conteúdo do
repo. É de propósito — mantém o footprint 74,2 × 102,7 do original (logo, a
caixa empilha com uma cópia do modelo de origem) e deixa a pilha abrir em
leque. Com 1,0 a caixa ficaria 98,2mm em Y.

## Variantes

Por **include**, nunca por `-D` (os `*_override` só existem via `-D` e o
ternário `is_undef()` é avaliado antes):

```scad
layers_override = 1;    include <penny-holder-01.scad>   // caixa de 84mm
card_w_override = 68;   include <penny-holder-01.scad>   // carta mais larga -> caixa de 154mm
stack_x_override = 45;  include <penny-holder-01.scad>   // pilha mais rasa
```

Os `assert` do `.scad` travam o export se a variante estourar a A1 mini, se a
carta não couber no comprimento, se a boca ficar com menos ar que o ressalto,
se a janela ficar estreita demais pra entrar dedo ou se a chaveta perder mordida.

## Pendências

1. **Medida da carta é catálogo, não régua** (ver acima).
2. **Não foi impresso nem testado na mão.**
3. Com a caixa pela metade, as cartas tombam no eixo da pilha — não há
   seguidor/divisória, mesma limitação do original.
