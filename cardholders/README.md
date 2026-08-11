# Cardholders

Porta-cartas **abertos** — pilha de cartas à vista, apoiada numa chapa e
presa por cantoneiras, em vez de fechada numa caixa. Pra bulk de energias,
cartas de troca e pilhas de mesa. Modelados em OpenSCAD e impressos na
Bambu Lab.

Pra deck guardado/fechado, ver [`deckboxes/`](../deckboxes/); pra
organização de sleeve/toploader, [`organizadores_tcg/`](../organizadores_tcg/).

## Modelos

| Modelo | Status | Descrição |
|---|---|---|
| [cardholder-01](./cardholder-01/) | 🚧 em andamento | 4 cantoneiras em L + **duas cintas de travamento** (meio e topo) e cinta de pé integrada; bolso 66×90 (carta nua), 70×94×62mm, peça única |

## Arquivos de terceiros nesta pasta

| Arquivo | Autor | Licença | Nota |
|---|---|---|---|
| `card_holder_with_feet.3mf` | Don Julio (MakerWorld) | Standard Digital File License | **Impresso e reprovado no teste físico: fraco.** É a referência de geometria do `cardholder-01`. Não redistribuir. |

## O que define um porta-cartas aberto

- **Bolso** (largura × comprimento livre): carta nua = 63×88; sleeve penny
  = 66×91; double sleeve ≈ 67×92. Folga padrão do repo ~1mm/lado.
- **Curso de pilha**: altura livre acima da chapa. Carta nua ≈ 0.25mm cada.
- **Rigidez**: é o ponto fraco do tipo. Cantoneira alta e fina é um balanço
  solto — precisa de anel de travamento e reforço na raiz, não de parede
  mais grossa (ver `cardholder-01`).
- **Apoio**: pé recuado pra dar pra enfiar o dedo por baixo e pra chapa fina
  não trabalhar como placa solta.
