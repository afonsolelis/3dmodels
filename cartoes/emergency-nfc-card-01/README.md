# emergency-nfc-card-01

Cartão de emergência fino, no padrão de cartão bancário, com os dados médicos
essenciais gravados na frente e um rebaixo aberto no verso para uma **tag NFC
adesiva circular de Ø27mm**.

O CPF e o WhatsApp pessoal não foram gravados no plástico: ficam apenas no NFC,
evitando exposição permanente. Mesmo sem celular, a face visível informa tipo
sanguíneo, condição cardíaca, fabricante/modelo do marcapasso e contato da
esposa.

## Medidas

- Cartão: **85,60 × 53,98 × 1,20mm** — formato ISO ID-1
- Quinas: raio **3,18mm**
- Tag medida pelo usuário: **Ø27,00mm**, adesiva
- Rebaixo: **Ø27,40 × 0,30mm**, com 0,20mm de folga por lado
- Piso sob a tag: **0,90mm**
- Texto: baixo-relevo de **0,24mm**, sem aumentar a espessura
- Parede mínima localizada onde texto e rebaixo se cruzam: **0,66mm**
- Espessura final: **1,20mm mais eventual saliência da tag**; o adesivo entra
  no rebaixo depois da impressão

## Arquivos

- `emergency-nfc-card-01.scad` — fonte paramétrico
- `stl/emergency-nfc-card-01.stl` — peça individual
- `3mf/emergency-nfc-card-01.3mf` — job de impressão, uma unidade
- `emergency-nfc-card-01-front-render-v1.png` — render final da frente
- `emergency-nfc-card-01-back-render-v1.png` — render final do verso/rebaixo

## Como gerar

```sh
flatpak run org.openscad.OpenSCAD -o stl/emergency-nfc-card-01.stl emergency-nfc-card-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/emergency-nfc-card-01.3mf emergency-nfc-card-01.scad
```

## Impressão

- Orientação já correta no STL/3MF: **frente na placa**, cavidade NFC para cima.
- Sem suporte e sem brim.
- Preferir **placa lisa** limpa; uma peça tão fina precisa de primeira camada
  uniforme. Deixar a mesa esfriar antes de remover para evitar empeno.
- Perfil inicial: `0.20mm Standard @BBL A1M`, parede Arachne. Para deixar a
  gravação mais delicada, usar 0,12 ou 0,16mm de camada.
- A gravação frontal nasce contra a placa. Se quiser contraste, preencher o
  baixo-relevo depois com tinta acrílica/caneta e limpar a superfície.
- Colar a NFC somente depois de imprimir. O pequeno entalhe à direita permite
  alcançar a borda do adesivo para substituição.

## Ajustes úteis

- Se a tag ficar alta: aumentar `tag_recess_depth`, preservando pelo menos
  0,75mm de piso.
- Se ficar funda demais: reduzir `tag_recess_depth`.
- Se a impressora fechar o rebaixo menor que o nominal: aumentar
  `tag_clearance` de 0,20 para 0,30mm por lado.

## Validação

Geometria e exports verificados digitalmente. A medida de Ø27mm veio da peça
real, mas a espessura do adesivo não foi medida; por isso o rebaixo de 0,30mm é
um primeiro ajuste conservador. Ainda falta o teste físico na carteira e com a
tag colada.
