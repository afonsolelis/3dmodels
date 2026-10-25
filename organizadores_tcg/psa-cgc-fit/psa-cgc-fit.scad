// psa-cgc-fit.scad
// Caixa RETANGULAR de UMA fila só, pra 20 slabs CGC nuas (slab medida com
// paquímetro pelo usuário em 2026-10-17: 80.0 x 135.3 x 7.7; espessura de
// projeto 7.8 = 7.7 medido + 0.1 de margem, mesmo critério do psa-box-01 com
// a PSA, 6.2 -> 6.3). É a variante CGC do ../psa-box-fit: mesma caixa de uma
// fila, mesmo pente, mesmas folgas (vaga 0.4/lado, canaleta 0.5/lado, tampa
// 0.1/lado com entrada em raio r1.0 — igual ao psa-box-02, contraria a regra
// 6 do CLAUDE.md de propósito, NÃO corrigir de volta), mesma barreira de luz
// e ACABAMENTO LISO (sem colmeia em relevo e sem fenda nenhuma). Só muda a
// slab: a CGC é 1.5mm mais grossa que a PSA, então a vaga vai de 7.1 pra 8.6
// e o passo de 8.6 pra 10.1 — 20 vagas dão 207.3 em Y (cabe nos 210).
//
// COMO SE MANUSEIA: as slabs entram em pé, de cima, e sobram 30mm pra fora
// da base. Pra tirar uma, PINÇA pelas duas bordas X (as estreitas, de 7.7mm)
// nesses 30mm expostos — com uma fila só, as DUAS bordas ficam de frente pra
// parede externa, então o acesso é só por cima dela. A vaga é justa: a slab
// não inclina (no máximo ~1.5mm no topo com a slab real de 7.7). ATENÇÃO: a
// ponta do dedo (~16mm) é mais larga que a borda (7.7mm) e entre vizinhas
// sobram ~2.4mm, então o dedo ENCOSTA também nas bordas das duas vizinhas —
// pinçar firme na do meio e puxar reto. A tampa desce por cima até apoiar
// no ombro e fica lisa com a base; o encaixe é justo (0.1/lado) e segura sem
// trava. Abre puxando a tampa reto, pelos dois lados opostos ao mesmo tempo.
//
// POR QUE INCLUDE e não .scad próprio: é a mesma caixa do psa-box-01 com
// outra slab e outro nº de filas e vagas. Uma fonte só = qualquer correção de
// folga/encaixe no psa-box-01 vale aqui sem copiar código. Os *_override são
// atribuídos NESTE arquivo, antes do include, então funcionam por CLI (o que
// não funciona é passar -D slab_t_override=... na linha de comando). Conferir
// no ECHO "psa-box: 1 fila(s) x 20 vagas" e "vaga 8.6 passo 10.1 canaleta 81".
//
// Gabarito de teste: diferente do psa-box-fit, aqui a vaga NÃO é a do
// psa-box-01 (8.6 contra 7.1, canaleta 81.0 contra 81.3), então o gabarito é
// PRÓPRIO e é o PRIMEIRO print: 3 vagas, 45mm de altura, com uma slab CGC.
//
// DOIS jobs: o gabarito e a caixa. Na caixa, base e tampa cabem lado a lado
// na AD5X, as duas sem suporte (base com o chão na cama, tampa com o teto na
// cama). O 3MF da caixa é montado com a skill /plates a partir dos dois STLs,
// pra base e tampa serem OBJETOS SEPARADOS no Flash Studio:
//   openscad -o stl/psa-cgc-fit-base.stl -D 'part="base"'  psa-cgc-fit.scad
//   openscad -o stl/psa-cgc-fit-lid.stl  -D 'part="lid"'   psa-cgc-fit.scad
//   openscad -o stl/psa-cgc-fit-test.stl -D 'part="test"'  psa-cgc-fit.scad
//   openscad -o 3mf/psa-cgc-fit-test.3mf -D 'part="test"'  psa-cgc-fit.scad
//   python3 .claude/skills/plates/plates.py 3mf/psa-cgc-fit-plate.3mf --gap 6 --plate "base + tampa" stl/psa-cgc-fit-base.stl stl/psa-cgc-fit-lid.stl
// part="plate" (as duas numa malha só) / "demo" / "cut" / "both" são só
// preview (ver psa-box-01).

/* [Slab CGC - medida com paquímetro (2026-10-17)] */
slab_w_override = 80.0;  // mm, largura da slab (X, atravessa a canaleta)
slab_h_override = 135.3; // mm, altura da slab (Z, fica em pé)
slab_t_override = 7.8;   // mm, espessura de projeto: 7.7 medido + 0.1 de margem

/* [Variante] */
rows_override   = 1;    // filas lado a lado (o psa-box-01 tem 2)
slots_override  = 20;   // vagas na fila (20 slabs; Y = 207.3 <= 210)
smooth_override = true; // tudo liso: sem colmeia em relevo, sem fenda

include <../psa-box-01/psa-box-01.scad>

// Derivados (a geometria vem toda do psa-box-01; aqui só os números do
// manuseio com a slab CGC, pra conferência)
slab_t_real   = 7.7;                               // mm, espessura medida (só pros ecos)
between_slabs = pitch - slab_t;                    // 2.3 — entre vizinhas (projeto 7.8)
between_real  = pitch - slab_t_real;               // 2.4 — entre vizinhas com a slab real
tilt_top      = (slot_t - slab_t_real) * slab_h / rib_h; // ~1.5 — inclinação máx. no topo

echo(str("psa-cgc-fit: ", capacity, " slabs CGC | slab ", slab_w, " x ", slab_h, " x ", slab_t,
         " | caixa ", box_x, " x ", box_y, " x ", closed_h, " fechada",
         " | chapa base+tampa ", 2 * box_x + plate_gap, " x ", box_y,
         " | plate_both=", plate_both));
echo(str("MANUSEIO CGC: entre vizinhas ", between_slabs, " (", between_real, " com a slab real de ",
         slab_t_real, ") | inclinacao max no topo ~", round(tilt_top * 10) / 10,
         " | slab pra fora ", grip, " | ate ", max_slots_210, " vagas em <=210"));
