# pokemon-coin-binder-01

Insert em formato de carta para guardar **uma moeda Pokemon grande** em um
bolso de pagina plastica 3x3 de fichario. O modelo usa a medida real fornecida
em 2026-08-23: **Ø51,4 x 2,7mm**.

## Como funciona

O insert mede **63 x 88 x 2mm**, o mesmo envelope de uma carta Pokemon. A
abertura central tem **Ø51,8mm**: 0,2mm de folga por lado para a moeda de
Ø51,4mm. Insert e moeda ficam juntos, no mesmo plano, dentro do bolso; a folha
plastica segura as duas faces.

Este holder **nao e snap-fit e nao segura a moeda sozinho fora da folha**. Isso
e intencional: evita marcar a borda da moeda e dispensa linguetas finas que
quebrariam com o uso. A moeda de 2,7mm sobressai 0,35mm de cada face do insert
de 2mm, mas a espessura maxima do conjunto continua sendo a da propria moeda,
2,7mm.

## Medidas

| Item | Medida |
|---|---:|
| Moeda real | Ø51,4 x 2,7mm |
| Abertura cilindrica | Ø51,8mm |
| Folga diametral / radial | 0,4 / 0,2mm |
| Chanfro da abertura | 0,5mm a 45 graus em cada face |
| Insert | 63 x 88 x 2mm |
| Quinas | raio 4mm |
| Menor largura do aro | 5,1mm |
| Chapa de 3 | 153 x 128 x 2mm |

## Arquivos

- `pokemon-coin-binder-01.scad` — fonte parametrico
- `stl/pokemon-coin-binder-01.stl` — um insert
- `3mf/pokemon-coin-binder-01.3mf` — job de teste com um insert
- `3mf/pokemon-coin-binder-01-x3.3mf` — job principal com tres inserts

A chapa de 3 usa um insert em retrato e dois em paisagem. Assim ocupa apenas
153 x 128mm e fica dentro do limite confortavel de 170 x 170mm da Bambu A1
mini. Para preencher uma pagina 3x3, imprimir o job `x3` tres vezes.

## Impressao

- Orientacao: deitado, exatamente como exportado
- Perfil inicial: 0.20mm Standard @BBL A1M
- Material: PLA
- Suporte: desligado
- Brim: desligado; a area de contato e grande
- Compensacao de pe de elefante: deixar o padrao do perfil; o chanfro inferior
  da abertura ja ajuda a entrada da moeda

Antes de produzir nove unidades, imprimir o job de uma unidade e testar dentro
do bolso real. Paginas muito justas podem precisar de `card_w`/`card_h` 0,3 a
0,5mm menores; moeda que nao passa livre pede mais `radial_clear`.

## Como gerar

```sh
flatpak run org.openscad.OpenSCAD -o stl/pokemon-coin-binder-01.stl \
  -D 'part="holder"' pokemon-coin-binder-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/pokemon-coin-binder-01.3mf \
  -D 'part="holder"' pokemon-coin-binder-01.scad
flatpak run org.openscad.OpenSCAD -o 3mf/pokemon-coin-binder-01-x3.3mf \
  -D 'part="plate3"' pokemon-coin-binder-01.scad
```
