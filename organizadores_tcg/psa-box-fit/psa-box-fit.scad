// psa-box-fit.scad
// Caixa RETANGULAR de UMA fila só, pra 20 slabs nuas (GRADD, GBA, PSA e
// CAPY — slab medida com paquímetro: 80.3 x 135.3 x 6.2, espessura
// dimensionada pela marca mais grossa, 6.3). É o psa-box-01 com uma fila:
// mesmo pente, mesmas folgas (vaga 0.4/lado, canaleta 0.5/lado, tampa
// 0.1/lado com entrada em raio r1.0 — igual ao psa-box-02, contraria a regra
// 6 do CLAUDE.md de propósito, NÃO corrigir de volta), mesma barreira de luz
// (colmeia em baixo relevo, nada passante; sem vão entre filas, então não
// sobra fenda nenhuma).
//
// COMO SE MANUSEIA: as slabs entram em pé, de cima, e sobram 30mm pra fora
// da base. Pra tirar uma, PINÇA pelas duas bordas X (as estreitas, de 6.3mm)
// nesses 30mm expostos — com uma fila só, as DUAS bordas ficam de frente pra
// parede externa, então o acesso é só por cima dela. A vaga é justa: a slab
// não inclina (no máximo ~1.3mm no topo). ATENÇÃO: a ponta
// do dedo (~16mm) é mais larga que a borda (6.3mm) e entre vizinhas sobram
// só 2.3mm, então o dedo ENCOSTA também nas bordas das duas vizinhas —
// pinçar firme na do meio e puxar reto. A tampa desce por cima até apoiar
// no ombro e fica lisa com a base; o encaixe é justo (0.1/lado) e segura sem
// trava. Abre puxando pela borda.
//
// POR QUE INCLUDE e não .scad próprio: é a mesma caixa com outro nº de filas
// e vagas. Uma fonte só = qualquer correção de folga/encaixe no psa-box-01
// vale aqui sem copiar código. Os *_override são atribuídos NESTE arquivo,
// antes do include, então funcionam por CLI (o que não funciona é passar
// -D slots_override=... na linha de comando). Conferir no ECHO
// "psa-box: 1 fila(s) x 20 vagas". O row_gap (vão de dedo) do psa-box-01 não
// entra com uma fila.
//
// Gabarito de teste: as vagas são IDÊNTICAS às do psa-box-01 (mesma
// canaleta, vaga, nervura e parede), então o job
// ../psa-box-01/3mf/psa-box-01-test.3mf serve pros dois — o part="test"
// daqui gera a mesma malha (conferido por hash) e não é exportado de novo.
//
// UM job só: com uma fila a base e a tampa cabem lado a lado na AD5X, as
// duas sem suporte (base com o chão na cama, tampa com o teto na cama). O
// 3MF é montado com a skill /plates a partir dos dois STLs, pra base e tampa
// serem OBJETOS SEPARADOS no Flash Studio (dá pra mexer em cada uma):
//   openscad -o stl/psa-box-fit-base.stl -D 'part="base"'  psa-box-fit.scad
//   openscad -o stl/psa-box-fit-lid.stl  -D 'part="lid"'   psa-box-fit.scad
//   python3 .claude/skills/plates/plates.py 3mf/psa-box-fit-plate.3mf --gap 6 --plate "base + tampa" stl/psa-box-fit-base.stl stl/psa-box-fit-lid.stl
// part="plate" (as duas numa malha só) / "demo" / "cut" / "both" são só
// preview (ver psa-box-01).

/* [Variante] */
rows_override  = 1;  // filas lado a lado (o psa-box-01 tem 2)
slots_override = 20; // vagas na fila (20 slabs)

include <../psa-box-01/psa-box-01.scad>

// Derivados (todos vêm do psa-box-01; só ecoados aqui pra conferência)
echo(str("psa-box-fit: ", capacity, " slabs | caixa ", box_x, " x ", box_y,
         " | chapa base+tampa ", 2 * box_x + plate_gap, " x ", box_y,
         " | plate_both=", plate_both));
