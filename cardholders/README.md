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
| [sleeve-tower-01](./sleeve-tower-01/) | 🚧 em andamento | Torre de **penny sleeves deitados**, 75×102.5×**150**mm: três paredes **maciças** de 3mm, **sulco de 50mm** do piso ao topo entre duas abas em L de 9.5 de retorno, piso-lastro de 10mm e ressalto de empilhamento (passo 147). Cavidade 69×99.5, curso de pilha 140mm |

## Arquivos de terceiros nesta pasta

| Arquivo | Autor | Licença | Nota |
|---|---|---|---|
| `card_holder_with_feet.3mf` | Don Julio (MakerWorld) | Standard Digital File License | **Impresso e reprovado no teste físico: fraco.** É a referência de geometria do `cardholder-01`. Não redistribuir. |

A referência de geometria do `sleeve-tower-01` é o
[`PennySleeveHolderStacking_V2.3mf`](./PennySleeveHolderStacking_V2.3mf)
(Sazabi, MakerWorld Exclusive License — **não redistribuir**); as medidas ficaram
registradas no [`index.json`](../index.json) e no README do modelo.

## O que define um porta-cartas aberto

- **Bolso** (largura × comprimento livre): carta nua = 63×88; sleeve penny
  = 66×91; double sleeve ≈ 67×92. Folga padrão do repo ~1mm/lado.
  **Nenhuma dessas medidas é de régua do usuário** — são catálogo ou engenharia
  reversa de peça de terceiro. Quando a régua chegar, todo modelo daqui é
  paramétrico o bastante pra se refazer sozinho.
- **Curso de pilha**: altura livre acima da chapa. Carta nua ≈ 0.25mm cada.
- **Rigidez**: é o ponto fraco do tipo. Cantoneira alta e fina é um balanço
  solto — precisa de anel de travamento e reforço na raiz, não de parede
  mais grossa (ver `cardholder-01`).
- **Apoio**: pé recuado pra dar pra enfiar o dedo por baixo e pra chapa fina
  não trabalhar como placa solta.
