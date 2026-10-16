# psa-box-fit

Caixa **retangular de uma fila só, para 20 slabs nuas** (GRADD, GBA, PSA e
CAPY). É o [`psa-box-01`](../psa-box-01/) com uma fila: mesmo pente, mesma
tampa telescópica, mesmas folgas e a mesma barreira de luz. Como não tem
segunda fila, não tem vão de dedo nem paredes internas, então **não sobra
vazado nenhum**.

## Medidas e folgas

Slab medida com **paquímetro** pelo usuário: **80.3 × 135.3 × 6.2mm**,
com a espessura dimensionada pela marca mais grossa (**6.3**).

| | Valor |
|---|---|
| vaga (espessura) | **7.1** (0.4/lado), passo **8.6**; a slab inclina no máximo ~1.3mm no topo |
| canaleta (largura) | **81.3** (0.5/lado) |
| encaixe da tampa | **0.1/lado** (igual ao `psa-box-02`, ver abaixo): ressalto 1.8 + folga 0.1 + saia 1.5 = parede 3.4; entradas em **raio r1.0** no topo do ressalto e na boca da saia (2.1/lado); topo do ressalto com 0.8 plano |
| slab pra fora da base | 30mm; 3.0mm do topo da slab ao teto da tampa |
| nervuras | 80mm de altura, topo em telhado de 1.5 → 0.8mm |
| barreira de luz | relevo 0.9 na base (2.5 atrás), 0.6 na tampa (1.8 atrás), chão maciço 2.4 |

> **A folga de 0.1/lado contraria a regra 6 do CLAUDE.md de propósito.** No
> `psa-box-02` (mesmo tipo de encaixe), a 0.5/lado foi impressa e testada na
> mão em 2026-10-13 e ficou **solta**. A original da DAMA_Lab, com 0.1/lado e
> entrada em raio r1.0, estava muito boa. Não "corrigir" de volta.

## Por que é um include

`psa-box-fit.scad` define `rows_override = 1` e `slots_override = 20` e faz
`include <../psa-box-01/psa-box-01.scad>`. É a mesma caixa com outro número
de filas e vagas, então uma fonte só garante que qualquer correção de folga
ou encaixe no `psa-box-01` vale aqui sem copiar código. Os overrides são
atribuídos no próprio arquivo, antes do include, então **funcionam por CLI**.
O ECHO confirma: `psa-box: 1 fila(s) x 20 vagas`. O `row_gap` (vão de dedo
entre filas) do `psa-box-01` não entra com uma fila.

## Peças e job

| Nome | No código | Job | Footprint (bbox.py) | Material |
|---|---|---|---|---|
| **base + tampa** | 2 objetos | `3mf/psa-box-fit-plate.3mf` | **182.2 × 177.3 × 107.7mm** | 317.6cm³ (~394g) |
| base | `part="base"` | `stl/psa-box-fit-base.stl` | 88.1 × 177.3 × 107.7mm | 230.8cm³ (~286g) |
| tampa | `part="lid"` | `stl/psa-box-fit-lid.stl` | 88.1 × 177.3 × 55.4mm | 86.8cm³ (~108g) |

**Um job só**: com uma fila, base e tampa cabem lado a lado com 6mm de vão,
dentro do alvo de 210 da AD5X. No 3MF elas são **dois objetos separados**
(montado com a skill `/plates`), então dá pra mexer, girar ou tirar cada uma
no Flash Studio. Conjunto fechado: **88.1 × 177.3 × 143.1mm**.

**Gabarito:** as vagas são idênticas às do `psa-box-01`, então use
`../psa-box-01/3mf/psa-box-01-test.3mf` (o `part="test"` daqui gera a mesma
malha, conferida por hash). Imprima ele primeiro, com uma slab de cada marca.

## Como se manuseia

1. As slabs entram em pé, de cima, e sobram **30mm pra fora da base**.
2. Pra tirar uma, **pinça pelas duas bordas X** (as estreitas, de 6.3mm)
   nesses 30mm expostos e puxa reto pra cima. Com uma fila só, as duas bordas
   ficam de frente pras paredes externas, então o acesso é só por cima delas.
3. A vaga é justa: a slab fica em pé, não inclina e não abre espaço entre as
   vizinhas.

> **Atenção:** a ponta do dedo (~16mm) é mais larga que a borda da slab
> (6.3mm), e entre duas vizinhas sobram só 2.3mm. O dedo **encosta também nas
> bordas das duas vizinhas**. Pinçe firme na do meio e puxe reto; se as
> vizinhas subirem junto, empurre-as de volta com a outra mão. O
> `psa-box-01` tem um vão de 20mm entre as filas pra o indicador alcançar a
> borda de dentro mais embaixo. Aqui não tem.

4. A tampa desce por cima, guiada pelas entradas arredondadas, até apoiar no
   ombro, e fica lisa com a base. O encaixe é justo (0.1/lado) e segura sem
   trava. Pra abrir, puxe a tampa **reto, pelos dois lados opostos ao mesmo tempo** — puxada por uma borda só ela inclina e calça (efeito gaveta).

## Impressão

- Sem suporte: base com o chão na cama, boca pra cima; tampa com o **teto na
  cama**. O relevo do teto começa em z=0, então só a teia entre hexágonos e a
  borda encostam: 9.790mm², ~63% do footprint da tampa.
- Filamento **opaco** (escuro) pra barreira de luz valer.
- Barreira de luz conferida nas malhas exportadas desta versão, com a tampa
  no encaixe: nenhum raio reto atravessa nenhuma das 6 faces. O método é o
  mesmo do `psa-box-01`, com controle positivo.

## Como gerar

```sh
D=organizadores_tcg/psa-box-fit
openscad -o $D/stl/psa-box-fit-base.stl  -D 'part="base"'  $D/psa-box-fit.scad
openscad -o $D/stl/psa-box-fit-lid.stl   -D 'part="lid"'   $D/psa-box-fit.scad
python3 .claude/skills/plates/plates.py $D/3mf/psa-box-fit-plate.3mf --gap 6 \
    --plate "base + tampa" $D/stl/psa-box-fit-base.stl $D/stl/psa-box-fit-lid.stl
```

Caminhos absolutos no OpenSCAD. `part="plate"` (as duas numa malha só),
`"demo"`, `"cut"` e `"both"` são só preview.
