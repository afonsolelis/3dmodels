# psa-box-02

Caixa de **10 slabs PSA** com **Pokébola gravada na tampa**. É a versão
**rígida e com tampa que desliza** do
[Porta carte PSA x10](../terceiros/no-ams-scatola-porta-10-carte-psa-pokemon-pokeball/)
(DAMA_Lab), refeita do zero em OpenSCAD a partir de medidas tiradas da malha
dele. Nenhum triângulo do original foi copiado.

## Por que existe

O original foi impresso e voltou com dois defeitos, os dois medidos na malha:

| | Original (DAMA_Lab) | psa-box-02 |
|---|---|---|
| Parede da tampa | 1.9mm | **3.0mm** (~3.9× mais rígida) |
| Teto da tampa / sob a Pokébola | 2.0 / **1.0mm** | 3.0 / **2.0mm** (8× sob o desenho) |
| Folga tampa ↔ gargalo | **0.1mm/lado** em 30mm de encaixe | **0.5/lado** (padrão de deslize do repo) |
| Chanfro de entrada | ~0.15mm | 1.0mm na boca da tampa e no topo do gargalo |
| Parede da base / chão | 5.0 / 3.5mm | 6.5 / 4.0mm |
| Externo | 95.0 × 98.5mm | 98.0 × 101.5mm |

Rigidez de parede cresce com o **cubo** da espessura, por isso 1mm a mais faz
tanta diferença. E 0.1mm/lado não é folga: com empeno e pé de elefante isso
vira interferência, e a tampa prende.

O **interior é idêntico** ao original, que já foi testado com slab: canaleta de
85.0 × 88.5, 10 vagas de 7.5 com divisória de 1.5 (passo 9.0), nervuras de 7mm
saindo das paredes laterais e 140mm do chão da vaga ao teto da tampa fechada.

## Peças e jobs

| Job | Conteúdo | Footprint (medido no STL) | Sólido |
|---|---|---|---|
| `3mf/psa-box-02-plate.3mf` | base + tampa lado a lado | 204.0 × 101.5 × 106.0mm | 263 + 105cm³ |
| `3mf/psa-box-02-lid.3mf` | só a tampa | 98.0 × 101.5 × 71.0mm | 105cm³ |

As duas peças imprimem **sem suporte** na orientação exportada: a base com o
chão na cama, a tampa com a Pokébola na cama (a gravação de 1mm fica nas
primeiras camadas e fecha em pontes curtas de 5–6mm).

**Só reimprimir a tampa:** o gargalo (91.0 × 94.5 × 30) e a altura do ombro
são iguais aos do original de propósito. Então o `psa-box-02-lid.3mf` também
fecha a **base original já impressa**, com a mesma folga de 0.5/lado. A única
diferença visual é 1.5mm de beiral por lado, porque a base original é menor.

## Fatiador

Sugestão: **4 perímetros, 20% gyroid**, PLA, camada de 0.2. Com paredes de
3.0 e 6.5, isso já deixa a caixa praticamente maciça onde importa. O perfil
que vinha no 3MF original usava 2 perímetros e 15% de grid.

## Encaixe conferido

Booleana na malha exportada: com a tampa fechada não há interferência;
deslocada 0.45mm em X continua livre e com 0.55mm já encosta, ou seja, a
folga é de 0.5mm/lado mesmo.
