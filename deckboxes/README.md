# Deckboxes

Caixas para guardar decks de cartas (TCG/LCG/board games), modeladas em
OpenSCAD e impressas na FlashForge.

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [deckbox-01](./deckbox-01/) | 🚧 em andamento | estilo caixa de fósforo, fechamento por ímã, 2 decks + dados |
| [deckbox-02](./deckbox-02/) | 🧪 aguardando teste físico | 1 deck + dados 64mm, sem ímãs; trava v3 por ressaltos (saliência 1,5 pega 1,0mm em pocket de 1,2; capa reforçada a 2,2mm na boca, aba de clique + canal 0,9) — v2 de 1,0 aprovada, v3 a testar, **bandeja e capa mudam juntas**; seta rebaixada na face de cima da capa (abrir com as cartas pra cima); cestinha só de pilares em L nos cantos (0,5mm/lado, deck justo 0,4/lado) |
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
