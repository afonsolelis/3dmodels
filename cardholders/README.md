# Cardholders

Porta-cartas **abertos** — pilha de cartas à vista, apoiada numa chapa e
presa por cantoneiras, em vez de fechada numa caixa. Pra bulk de energias,
cartas de troca e pilhas de mesa. Modelados em OpenSCAD e impressos na
FlashForge.

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
| `PennySleeveHolderStacking_V2_kobra3.3mf` | Sazabi (MakerWorld) | MakerWorld Exclusive License | variante Kobra 3 do *Stackable Penny Sleeve Holder*. Não redistribuir. |
| `PennySleeveHolderStacking_V2_kobra3_15cm.3mf` | Sazabi (MakerWorld) | MakerWorld Exclusive License | mesma peça, versão de 15cm. Não redistribuir. |

**Os dois originais de referência saíram do repo em 2026-08-28** — o
`card_holder_with_feet.3mf` (Don Julio, MakerWorld; impresso e **reprovado no
teste físico: fraco**), que era a referência de geometria do `cardholder-01`,
e o `PennySleeveHolderStacking_V2.3mf` (Sazabi, MakerWorld Exclusive
License), referência do `sleeve-tower-01`. As medidas de engenharia reversa
dos dois continuam registradas no [`index.json`](../index.json) (campo
`derived_from` de cada projeto) e nos READMEs dos modelos, que é o que os
modelos paramétricos realmente usam.

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
