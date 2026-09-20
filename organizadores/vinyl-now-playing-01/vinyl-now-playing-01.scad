// vinyl-now-playing-01.scad
// Porta-vinis de mesa "NOW PLAYING": rack com 2 blocos de 4 aletas inclinadas
// (4 slots por bloco pra folhear LPs em pé), um canal central vazado e, na
// frente, uma barra baixa com a gravação "NOW PLAYING" + encosto mais alto
// formando o berço do disco que está tocando. Peça ÚNICA, sem montagem.
//
// DERIVED FROM: organizadores/organizador_vinis.3mf ("Vinyl_Holder_Remix
// v10", arquivo de terceiro) — TODAS as medidas por engenharia reversa da
// malha (bbox 160 x 127.02 x 44.45, raio-laser em cortes YZ/XZ); geometria
// refeita do zero em OpenSCAD, nenhum triângulo copiado.
//
// COMO O USUÁRIO MANUSEIA:
// - A peça fica parada na estante/mesa, base plana no móvel. Os LPs entram
//   EM PE nos slots entre aletas, um por slot, capa virada pra frente, e
//   inclinam ~9° pra trás apoiando na aleta de trás — dá pra folhear as
//   capas com a mão como numa caixa de discos de loja.
// - O disco QUE ESTÁ TOCANDO vai no berço da frente: a borda de baixo da
//   capa apoia no topo arredondado da barra "NOW PLAYING" (13 mm) e a capa
//   deita no encosto de 20 mm — a capa fica em pé, de frente pra quem olha.
// - Os dois pés de 18 mm que esticam 44 mm pra trás do último slot são
//   LASTRO ANTI-TOMBAMENTO: com 8 LPs de ~180 g inclinados pra trás, o
//   centro de massa anda pra trás e sem eles o rack capotava.
//
// ORIENTAÇÃO DE IMPRESSÃO: como está no modelo — base na mesa, aletas
// crescendo pra cima. Aletas de 8 mm deitadas a 9° imprimem em parede
// contínua, ZERO suporte, sem ponte (a janela da base é vazada pra baixo).
//
// SEM COLMEIA (exceção consciente à regra 5): as faces visíveis são as
// FACES DE 8 mm das aletas — não existe painel contínuo onde furar; um
// favo passante numa aleta de 8 mm deixaria parede de ~0.5 mm. Fiel à
// referência, que também é maciça.
//
// Peça / STL individual:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/organizadores/vinyl-now-playing-01/stl/vinyl-now-playing-01.stl -D 'part="stand"' /home/afonsolelis/repos/3dmodels/organizadores/vinyl-now-playing-01/vinyl-now-playing-01.scad
//
// Job de impressão (cama FlashForge AD5X 220x220, alvo 210x210), já na
// orientação de impressão, SEM suporte:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/organizadores/vinyl-now-playing-01/3mf/vinyl-now-playing-01.3mf -D 'part="plate"' /home/afonsolelis/repos/3dmodels/organizadores/vinyl-now-playing-01/vinyl-now-playing-01.scad
//
// ATENÇÃO CLI: nesta máquina `-D nome_override=...` NÃO funciona. Mirar só
// a variável final `part` e conferir os ECHO de derivados no fim.

/* [Peça a renderizar] */
// "stand" (a peça única) | "plate" (job de impressão = a peça, na orientação
// de imprimir) | "preview" (peça + 2 LPs fantasma pra visualizar o uso) |
// "none" (nada, pros scripts de corte)
part = "preview";

/* [Envelope — medidas da malha de referência] */
stand_w   = 160;   // mm, largura total (X)
base_d    = 83;    // mm, profundidade da chapa cheia da base (até atrás da última aleta)
base_t    = 5;     // mm, espessura da base (medido 4.94)
fin_h     = 44.45; // mm, altura total das aletas (topo, medido)

/* [Canal central e pés traseiros] */
channel_w = 34;    // mm, largura do vão central entre os blocos de aletas (x 63..97)
foot_w    = 18;    // mm, largura de cada pé traseiro (nas bordas externas)
foot_d    = 44;    // mm, quanto o pé estica pra trás da base (base 83 -> 127 total)

/* [Janela da base (alívio de material no canal)] */
win_inset_x = 1.5; // mm, recuo da janela em relação às paredes do canal
win_y0      = 20;  // mm, frente da janela
win_y1      = 72;  // mm, fundo da janela (o que sobra atrás, 72..83, é a ponte que amarra os blocos)

/* [Aletas] */
fin_count = 4;     // aletas por bloco -> 3 slots entre aletas + 1 slot contra o encosto
fin_pitch = 18;    // mm, passo entre frentes de aletas vizinhas
fin_t     = 8;     // mm, espessura HORIZONTAL da aleta (7.9 perpendicular ao plano)
fin_lean  = 9;     // graus, inclinação pra trás a partir da vertical
fin_y0    = 20.5;  // mm, frente da 1ª aleta na base (z=0)
fin_round = 1.5;   // mm, raio de arredondamento das quinas da aleta (topo rola)

/* [Berço NOW PLAYING - barra + encosto] */
bar_h      = 13;   // mm, altura da barra da frente (lábio que segura a borda da capa)
bar_lean   = 10;   // graus, inclinação da face frontal da barra
bar_front  = 1;    // mm, pé da face da barra em relação à borda da base
bar_back_y = 5.5;  // mm, plano vertical: fundo da barra = frente do encosto
rest_t     = 6;    // mm, espessura do encosto
rest_h     = 19.75;// mm, altura do encosto (a capa deita nele)

/* [Texto gravado na barra] */
label_text  = "NOW PLAYING";
label_size  = 8;    // mm, altura nominal da fonte
label_depth = 1.2;  // mm, profundidade da gravação na face inclinada
label_z     = 7;    // mm, altura do centro do texto

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
half_w   = (stand_w - channel_w) / 2;      // 63 mm, largura de cada bloco de aletas
half_x   = [0, stand_w - half_w];          // x inicial de cada bloco: 0 e 97
lean_dx  = fin_h * tan(fin_lean);          // 7.04 mm, deslocamento do topo da aleta
slot_w   = fin_pitch - fin_t;              // 10 mm, vão livre entre aletas na base
win_x0   = half_w + win_inset_x;           // 64.5
win_x1   = stand_w - half_w - win_inset_x; // 95.5
foot_y1  = base_d + foot_d;                // 127, fundo total da peça
bar_top_front = bar_front + bar_h * tan(bar_lean); // 3.29 mm, topo da face da barra

// ---------------------------------------------------------------------
// Blocos de apoio
// ---------------------------------------------------------------------

// Perfil YZ extrudado em X a partir de x0, comprimento len.
module profile_x(len, x0 = 0) {
    translate([x0, 0, 0])
        rotate([0, 90, 0])
            rotate([0, 0, 90])
                linear_extrude(height = len)
                    children();
}

// Uma aleta: paralelogramo deitado a fin_lean, quinas arredondadas
// (o raio no FUNDO fica enterrado na base; no TOPO vira o rolete que a
// capa do disco raspa sem lascar).
module fin(y0) {
    // delta negativo e depois r: as arestas voltam EXATAMENTE às cotas do
    // paralelogramo e só as quinas viram arco de raio fin_round. Com
    // offset(r) puro o fundo da aleta descia 1.5 mm ABAIXO da base (z=-1.5)
    // e a peça inteira sentava nas pontas das aletas — pego no bed-check.
    offset(r = fin_round)
        offset(delta = -fin_round)
            polygon([[y0, 0], [y0 + fin_t, 0],
                     [y0 + fin_t + lean_dx, fin_h],
                     [y0 + lean_dx, fin_h]]);
}

// Berço NOW PLAYING: barra em cunha na frente (face inclinada bar_lean,
// topo em z=bar_h) + encosto vertical de rest_t subindo até rest_h.
// O perfil é UM polígono só: a capa apoia a borda no topo arredondado da
// barra e deita no encosto.
module cradle_profile() {
    // mesmo truque delta/r da aleta: face da barra fica exatamente em
    // bar_front (não invade a borda da base) e fundo exatamente em z=0
    offset(r = 1.2)
        offset(delta = -1.2)
            polygon([[bar_front, 0], [bar_back_y + rest_t, 0],
                     [bar_back_y + rest_t, rest_h],
                     [bar_back_y, rest_h],
                     [bar_back_y, bar_h],
                     [bar_top_front, bar_h]]);
}

// ---------------------------------------------------------------------
// A peça
// ---------------------------------------------------------------------
module stand() {
    difference() {
        union() {
            // base: chapa cheia na frente + 2 pés traseiros
            cube([stand_w, base_d, base_t]);
            for (x = [0, stand_w - foot_w])
                translate([x, base_d, 0])
                    cube([foot_w, foot_d, base_t]);
            // berço NOW PLAYING, largura toda
            profile_x(stand_w) cradle_profile();
            // blocos de aletas
            for (hx = half_x, k = [0 : fin_count - 1])
                profile_x(half_w, hx) fin(fin_y0 + k * fin_pitch);
        }
        // janela da base no canal central
        translate([win_x0, win_y0, -0.5])
            cube([win_x1 - win_x0, win_y1 - win_y0, base_t + 1]);
        // gravação "NOW PLAYING" na face inclinada da barra
        translate([stand_w / 2,
                   bar_front + label_z * tan(bar_lean) - label_depth * cos(bar_lean),
                   label_z])
            rotate([90 - bar_lean, 0, 0])
                linear_extrude(height = 3 * label_depth)
                    text(label_text, size = label_size,
                         font = "Liberation Sans:style=Bold",
                         halign = "center", valign = "center");
    }
}

// LP fantasma pra preview: capa de 315 x 315, 6 mm de lombada, deitada
// fin_lean pra trás com a borda no fundo do slot.
module ghost_lp(y_slot) {
    color("SlateGray", 0.55)
        translate([stand_w / 2, y_slot, base_t])
            rotate([fin_lean, 0, 0])
                translate([-315 / 2, -3, 0])
                    cube([315, 6, 315]);
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "stand" || part == "plate") {
    stand();
} else if (part == "none") {
    // gancho pros scripts de verificação
} else { // preview
    stand();
    ghost_lp(fin_y0 + fin_pitch);        // LP no 2º slot do bloco
    ghost_lp(bar_back_y + rest_t + 1);   // LP "tocando", atrás do encosto
}

// ---------------------------------------------------------------------
// ECHO de derivados (conferir SEMPRE depois de exportar com -D)
// ---------------------------------------------------------------------
echo(str("part = ", part));
echo(str("envelope = ", stand_w, " x ", foot_y1, " x ", fin_h, " mm (base cheia ate y=", base_d, ")"));
echo(str("blocos de aletas: 2 x ", half_w, " mm (x 0-", half_w, " e ", stand_w - half_w,
         "-", stand_w, "), canal central de ", channel_w, " mm"));
echo(str("aletas: ", fin_count, "/bloco, passo ", fin_pitch, ", espessura ", fin_t,
         " mm horiz (", fin_t * cos(fin_lean), " perp), lean ", fin_lean, " deg, deslocamento do topo ", lean_dx));
echo(str("slots: ", fin_count, "/bloco (3 entre aletas + 1 contra o encosto), vao de ", slot_w,
         " mm na base | LP: capa ~315x315, lombada 3-8 mm entra folgada"));
echo(str("base: ", base_t, " mm | janela ", win_x1 - win_x0, " x ", win_y1 - win_y0,
         " mm (x ", win_x0, "-", win_x1, ", y ", win_y0, "-", win_y1, ") | ponte de ", base_d - win_y1, " mm"));
echo(str("pes traseiros: 2 x ", foot_w, " x ", foot_d, " mm (anti-tombamento)"));
echo(str("berco NOW PLAYING: barra ", bar_h, " mm (face a ", bar_lean, " deg, pe em y=", bar_front,
         ", topo em y=", bar_top_front, ") + encosto ", rest_t, " x ", rest_h, " mm em y=",
         bar_back_y, "-", bar_back_y + rest_t));
echo(str("texto: \"", label_text, "\" size ", label_size, ", gravado ", label_depth,
         " mm na face inclinada, centro em z=", label_z));
