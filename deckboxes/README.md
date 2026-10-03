# Deckboxes

Caixas para guardar decks de cartas (TCG/LCG/board games), modeladas em
OpenSCAD e impressas na FlashForge.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [deckbox-01](./deckbox-01/) | 🚧 em andamento | estilo caixa de fósforo, fechamento por ímã, 2 decks + dados |
| [deckbox-02](./deckbox-02/) | 🧪 aguardando teste físico | 1 deck + dados 64mm, sem ímãs; trava v2 por ressaltos (capa reforçada a 2,2mm na boca, aba de clique + canal de alívio) **aprovada**; cestinha v2 com 0,5mm/lado, parede 1,6 (deck justo, 0,4/lado), chanfro de entrada, cantos r=2, hex 6mm com faixas sólidas e U de 32mm; variante de cestinha só de pilares em L nos cantos; **reimprimir só a cestinha** |
| [deckbox-03](./deckbox-03/) | 🚧 em andamento | cilíndrica de tampa roscada (Ø114×102), deck em pé no meio e 4 poços de dados nos cantos do círculo (420cm³); **lisa por fora e por dentro, sem colmeia, a pedido do usuário**; imprimir o cupom de rosca antes |
| [card-mailer-01](./card-mailer-01/) | 🧪 aguardando teste físico | estojos internos de envio: 3 e 10 sleeves, 1 graduado BGS; tampa lacrada com fita, três jobs AD5X, medidas reutilizadas do repo |

## Parâmetros que costumam definir uma deckbox

Ao começar um modelo novo, vale decidir:

- **Dimensões da carta** (ex: standard 63×88mm, sleeved ou não)
- **Capacidade** (quantas cartas o deck tem, com/sem sleeve)
- **Tolerância de encaixe** (folga pra tampa/gaveta deslizar sem travar)
- **Estilo de abertura** (tampa solta, encaixe por atrito, dobradiça, gaveta)
- **Espessura de parede** (resistência x consumo de filamento)
- **Extras** (compartimento pra dados, divisórias, texto/logo em relevo)

Essas decisões ficam registradas no README de cada modelo específico.

## Downloads de terceiros

Veja o [catálogo visual dos 2 arquivos](terceiros/README.md). Cada item registra origem, licença, nome anterior e prévia quando disponível.
