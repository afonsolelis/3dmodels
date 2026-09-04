// toploader-holder-01.scad
//
// Dispenser 2-em-1 de TOP LOADER (em cima) e PENNY SLEEVE (embaixo), numa
// caixa unica de 84 x 109 x 150mm, aberta em cima e com JANELA de vao continuo
// na frente. O truque que faz o 2-em-1 e um DEGRAU (ledge) a 34mm do chao: o
// bolso de baixo e ESTREITO demais pra um top loader entrar, entao o top
// loader para em cima do degrau e o penny sleeve, que e menor, cai livre no
// bolso. Sem divisoria, sem ponte, sem peca movel — quem separa e a gravidade.
//
// DE ONDE VEIO
// O ponto de partida e o `../2-in-1_Top_Loader___Sleeve_Holder.3mf` ("2-in-1
// Top Loader & Sleeve Holder" / "Deck Daddy", HeyHalo, MakerWorld, 2025-06-23,
// licenca CC0 declarada no proprio 3mf). Este .scad e RECONSTRUCAO PARAMETRICA
// propria: nada da malha de origem foi copiado, so medidas de engenharia
// reversa. Medido na malha (1809 vertices / 3614 triangulos, 1 solido
// estanque, volume 121.1 cm3):
//   envelope 82.00 x 107.00 x 84.00 (bbox x +-41.0, y +-53.5, z +-42.0)
//   piso macico de 4.0 (z -42..-38), cobrindo o footprint inteiro
//   parede 2.5 na camara de CIMA  -> vao 77.0 x 102.0 (x +-38.5, y -51..+51)
//   parede 5.5 no bolso de BAIXO  -> vao 71.0 x  99.0 (x +-35.5, y -51..+48)
//   ou seja: DEGRAU de 3.0 nos dois lados e 3.0 no fundo, em z=-8 (30mm de
//   bolso), com filete de ~1mm. A frente NAO tem degrau: os dois vaos ficam
//   rentes em y=-51, e por isso da pra enfiar o dedo no bolso pela janela.
//   janela da frente 60.0 de largura (x +-30), do topo do piso ate a boca,
//   SEM travessa nenhuma; sobra montante de 11.0 de cada lado
//   aro do topo arredondado (so 153mm2 de face plana em z=42)
//   CONFERIDO por corte booleano renderizado: NAO existe prateleira nenhuma
//   dentro da caixa, e uma camara so com o degrau na parede.
//
// ATENCAO — NENHUMA MEDIDA AQUI SAIU DE REGUA
// tl_w/tl_h (76.2 x 101.6 = 3" x 4") e sleeve_w/sleeve_h (66.7 x 92.1) sao
// CATALOGO, e os vaos vieram da malha de origem, nao do objeto na mao do
// usuario. E a mesma ressalva do penny-holder-01 e do sleeve-tower-01 (ver
// ../README.md). O atenuante e que a caixa de origem foi impressa e aprovada
// por terceiros com esses vaos; o risco real esta no bolso de baixo, que so
// funciona enquanto pocket_w ficar ENTRE a largura do sleeve e a do top
// loader — a folga de cada lado esta ecoada nos derivados, confira antes de
// imprimir. Quando a regua chegar, um include com cav_w_override /
// pocket_w_override refaz a caixa inteira.
//
// COMO SE MANUSEIA
//   1. A caixa fica de pe na mesa, janela virada pra voce. Nada de tampa.
//   2. GUARDAR TOP LOADER: pela BOCA, em cima. O top loader entra DEITADO
//      (76.2 no X, 101.6 no Y) e a pilha cresce em Z. O chanfro de 1.2 na boca
//      guia a entrada. A pilha assenta no DEGRAU, 34mm acima da mesa.
//   3. TIRAR TOP LOADER: pela boca tambem, puxando o de cima. Sao 116mm de
//      curso util, ~92 top loaders; o de baixo esta a 34mm da mesa, altura
//      confortavel de pinca.
//   4. GUARDAR PENNY SLEEVE: pela JANELA da frente, na altura do piso. O
//      sleeve entra deitado e escorrega pra dentro do bolso. Se a caixa ainda
//      estiver vazia de top loader da pra guardar por cima tambem, deixando o
//      sleeve cair pelo vao do bolso — com a caixa cheia, so pela janela.
//   5. TIRAR PENNY SLEEVE: dois dedos pela janela na altura do piso, pinca e
//      puxa pra frente. O peitoril esta RENTE ao topo do piso (z=4), sem
//      degrau nenhum pra o sleeve enroscar, e a pilha de top loader nao desce
//      no lugar — ela esta apoiada no degrau, 30mm acima.
//   6. Nada cai pela janela: sao 60mm de vao contra 66.7 de sleeve
//      (3.35/lado de mordida) e 76.2 de top loader (8.1/lado).
//
// O QUE MUDOU EM RELACAO AO ORIGINAL, E POR QUE
//   1. ALTURA 84 -> 150 (pedido do usuario). Os 66mm extras vao INTEIROS pra
//      camara de top loader: 50 -> 116mm, de ~40 pra ~92 top loaders. O piso
//      (4) e o bolso de sleeve (30) ficam como estavam — mexer neles mudaria
//      a funcao, nao a capacidade que o usuario pediu.
//   2. PAREDE 2.5 -> 3.0, crescendo PRA FORA (82x107 -> 84x109), nunca comendo
//      o vao. E a licao ja paga do sleeve-tower-01: a 150mm de altura parede
//      de 2mm empena. Aqui ainda por cima a frente e um rasgo de 138mm, entao
//      a secao que resiste e so o U das outras tres paredes.
//   3. VAO DE CIMA 77.0 -> 78.0 (0.4 -> 0.9 de folga por lado no top loader).
//      Regra 6 do repo, na versao aprendida no deckbox-02: quanto mais alto o
//      tubo impresso em pe, mais a parede entra de barriga e mais subdimensionada
//      sai a cavidade em XY. A caixa quase dobrou de altura; 0.4/lado era
//      apertado pra uma parede de 84mm e vira sorteio numa de 150mm. O vao do
//      FUNDO (Y) sobe junto, 102 -> 103, pelo mesmo motivo.
//   4. CINTA DE 8mm fechando a volta no topo, com a janela morrendo em duas
//      aguas de 45 graus. O original nao tem: a janela dele vai ate a boca. A
//      84mm de altura isso passa; a 150mm o montante da frente vira uma coluna
//      esbelta e o unico jeito de o lado abrir e girando em torno da base. E o
//      MESMO remedio do penny-holder-01, e a conta e a mesma: a cinta trabalha
//      em TRACAO ao longo de X, secao 3.0 x 8.0 = 24mm2, ~720N em PLA a 30MPa,
//      contra um empurrao de pilha que nao chega a 1% disso.
//   5. COLMEIA passante nas duas laterais e no fundo (regra 5 do repo), com
//      BICO DE 45 graus — nao o hexagono regular, cujo bico fica a 30 graus da
//      horizontal, que e EXATAMENTE o limiar de suporte do Flash Studio (o
//      usuario fatia com suporte ligado). Celula de 18mm entre faces, e nao os
//      24 do penny-holder-01 — ver o parametro hex_d. A colmeia so existe
//      ACIMA do degrau: o bolso de
//      sleeve inteiro fica MACICO, e nao e estetica — penny sleeve e mole e
//      largo demais pra 71mm de bolso, e com furo passante ele faz barriga pra
//      fora e enrosca na hora de puxar. Bonus: os 34mm de baixo macicos sao o
//      lastro contra tombamento de uma torre de 150mm.
//   6. CHANFRO DE 1.2 NA BOCA (o original tem so o aro arredondado). Com
//      0.9/lado de folga o top loader ja entra, mas o chanfro perdoa a mao
//      torta — e material que RECUA subindo, entao nao custa balanco nenhum.
//
// IMPRIME EM PE, BOCA PRA CIMA, SEM SUPORTE — inventario de balanco:
//   degrau do bolso ...... material RECUA subindo (parede de 6.5 vira 3.0):
//                          o degrau e uma face virada pra CIMA, balanco ZERO.
//                          E o achado que faz o modelo inteiro se sustentar.
//   colmeia .............. teto de furo a 45 graus, em bico. Zero ponte reta.
//   janela da frente ..... duas aguas de 45 fecham os 60mm de vao em 30mm de
//                          subida (2mm de vao por mm de altura, o mesmo
//                          criterio do original e do penny-holder-01).
//   chanfro da boca ...... recua subindo, cada camada apoia na de baixo.
//   chanfro do aro ....... idem, 45 graus.
//   1a camada ............ o piso inteiro, 84 x 109 macico (~9.1 mil mm2).
//                          Adesao de sobra; BRIM NAO E NECESSARIO, mas 150mm
//                          de torre com a frente aberta agradece um skirt.
//
// EXPORT CANONICO (caminhos absolutos; o flatpak nao enxerga /tmp):
//   STL da peca
//     flatpak run org.openscad.OpenSCAD \
//       -o /home/afonsolelis/Repos/3dmodels/organizadores_tcg/toploader-holder-01/stl/toploader-holder-01-box.stl \
//       -D 'part="box"' \
//       /home/afonsolelis/Repos/3dmodels/organizadores_tcg/toploader-holder-01/toploader-holder-01.scad
//   JOBS DE IMPRESSAO (3mf/ so tem job; footprint medido com o bbox.py do /bed-check)
//     -D 'part="plate"' -> 3mf/toploader-holder-01-plate.3mf
//         1 caixa  ->  84.0 x 109.0 x 150.0  (ok)
//     -D 'part="par"'   -> 3mf/toploader-holder-01-par.3mf
//         2 caixas -> 174.0 x 109.0 x 150.0  (ok, dentro dos 210 do repo)
//   Nos dois casos os 109 vao no eixo Y, que e o que a cama da AD5X balanca:
//   base MAIOR contra a inercia de uma torre de 150mm.
//   DIAGNOSTICO (nao exportar pra 3mf/)
//     part="content" -> caixa + top loaders + sleeves, pra conferir no render
//     part="cut"     -> meia caixa, pra olhar o degrau por dentro
//
// VARIANTE: por INCLUDE, nunca por -D (o `-D` entra no FIM do escopo de topo,
// depois do is_undef(), e cai no default calado — armadilha registrada no
// CLAUDE.md). Ex.: um arquivo com
//   box_z_override = 110; include <toploader-holder-01.scad>
// da a caixa baixa. Por CLI, mirar sempre a variavel FINAL (-D box_z=110).

/* [Peca] */
// box | plate | par | content | cut
part = "box";

/* [Conteudo — CATALOGO, nao e regua] */
// mm — largura do TOP LOADER 3"x4" (o que decide se ele para no degrau)
tl_w = 76.2;
// mm — altura do TOP LOADER 3"x4"
tl_h = 101.6;
// mm — espessura de UM top loader; so serve pra estimar capacidade
tl_t = 1.25;
// mm — largura do PENNY SLEEVE (2.625")
sleeve_w = 66.7;
// mm — altura do PENNY SLEEVE (3.625")
sleeve_h = 92.1;
// mm — espessura de UM penny sleeve vazio; so serve pra estimar capacidade
sleeve_t = 0.08;

/* [Caixa] */
// mm — altura total. 150 = pedido do usuario (o original tem 84)
box_z = is_undef(box_z_override) ? 150.0 : box_z_override;
// mm — parede. 3.0 e nao os 2.5 do original: a 150mm de altura 2.5 empena
wall = 3.0;
// mm — vao da camara de CIMA em X. 78.0 = os 77.0 medidos + 1.0 de anti-empeno
cav_w = is_undef(cav_w_override) ? 78.0 : cav_w_override;
// mm — vao da camara de CIMA em Y. 103.0 = os 102.0 medidos + 1.0 de anti-empeno
cav_d = is_undef(cav_d_override) ? 103.0 : cav_d_override;
// mm — piso macico (medido no original)
floor_h = 4.0;
// mm — raio dos cantos verticais externos (so conforto de mao)
corner_r = 1.5;
// mm — chanfro de 45 no aro do topo
rim_ch = 0.6;
// mm — chanfro de 45 na boca, guia de entrada do top loader
mouth_lead = 1.2;

/* [Bolso de penny sleeve — o degrau e a peca toda] */
// mm — vao do bolso em X; TEM que ficar entre sleeve_w e tl_w (medido: 71.0)
pocket_w = is_undef(pocket_w_override) ? 71.0 : pocket_w_override;
// mm — vao do bolso em Y, contado a partir da FRENTE (medido: 99.0)
pocket_d = is_undef(pocket_d_override) ? 99.0 : pocket_d_override;
// mm — altura util do bolso, do topo do piso ao degrau (medido no original)
pocket_h = 30.0;

/* [Frente] */
// mm — vao da janela (medido no original)
win_w = 60.0;
// mm — CINTA: faixa macica que fecha a volta no alto, rente a parede
band = 8.0;

/* [Colmeia] */
// mm — celula entre faces. 18 e nao os 24 do penny-holder-01: aqui a celula
// tem que caber INTEIRA na faixa util (ver hex_field), e com 24 sobravam 3
// fileiras num painel de 98mm, com vazio morto em cima e embaixo. Com 18 sao 5
// fileiras x 5 colunas, o painel fecha, e a nervura extra e bem-vinda numa
// torre de 150mm cuja quarta parede e um rasgo
hex_d = is_undef(hex_d_override) ? 18.0 : hex_d_override;
// graus — inclinacao do BICO, medida da horizontal. 45 e nao os 30 do hexagono
// regular: 30 e o limiar de suporte do Flash Studio, e o usuario fatia com suporte ligado
hex_cap_ang = 45;
// mm — altura da lateral RETA da celula (proporcional aos 18 da celula)
hex_side = 6.0;
// mm — nervura da colmeia; 3.0 = espessura da parede, secao quadrada
hex_web = 3.0;
// mm — faixa macica entre o campo de colmeia e a borda da parede
border = 5.0;
// mm — faixa macica nas bordas verticais do fundo (canto traseiro)
back_border = 6.0;
// colmeia ligada? false deixa as tres paredes macicas
hex_walls = true;

/* [Chapa] */
// mm — vao entre pecas na chapa
plate_gap = 6.0;

/* [Oculto] */
$fn = 48;
eps = 0.01;

// ---------------------------------------------------------------- Derivados
box_x     = cav_w + 2 * wall;             // 84.0
box_y     = cav_d + 2 * wall;             // 109.0
ledge_s   = (cav_w - pocket_w) / 2;       // 3.5  — degrau de cada lateral
ledge_b   = cav_d - pocket_d;             // 4.0  — degrau do fundo (frente e rente)
ledge_z   = floor_h + pocket_h;           // 34.0 — altura do degrau
tl_room   = box_z - ledge_z;              // 116.0— curso util de top loader
pocket_wall = wall + ledge_s;             // 6.5  — parede do bolso, lateral

bite_tl_x = (tl_w - pocket_w) / 2;        // 2.6  — quanto o top loader pega de degrau
free_tl_x = (cav_w - tl_w) / 2;           // 0.9  — folga do top loader por lado, X
free_tl_y = (cav_d - tl_h) / 2;           // 0.7  — folga do top loader por lado, Y
free_sl_x = (pocket_w - sleeve_w) / 2;    // 2.15 — folga do sleeve por lado, X
free_sl_y = pocket_d - sleeve_h;          // 6.9  — folga do sleeve em Y (encosta na frente)

jamb      = (box_x - win_w) / 2;          // 12.0 — montante de cada lado da janela
win_top   = box_z - band;                 // 142  — bico da agua
win_sh    = win_top - win_w / 2;          // 112  — ombro (onde comecam as aguas de 45)
win_h     = win_top - floor_h;            // 138  — altura total do vao
flange    = jamb - wall;                  // 9.0  — quanto o montante avanca na lateral
bite_win_sl = (sleeve_w - win_w) / 2;     // 3.35 — mordida da janela sobre o sleeve
bite_win_tl = (tl_w - win_w) / 2;         // 8.1  — mordida da janela sobre o top loader

hex_cap   = hex_d / 2 * tan(hex_cap_ang); // 12.0 — altura do bico
hex_cell_h= hex_side + 2 * hex_cap;       // 32.0 — celula ponta a ponta
hex_z0    = ledge_z + border;             // 39   — colmeia so ACIMA do degrau
hex_z1    = box_z - band - border;        // 137

cap_tl    = floor(tl_room / tl_t);        // ~92  — top loaders
cap_sl    = floor(pocket_h / sleeve_t);   // ~375 — penny sleeves

assert(box_z <= 220, "ALTURA ESTOURA A AD5X");
assert(box_x <= 210 && box_y <= 210, "FOOTPRINT ESTOURA O ALVO DE 210 DO REPO");
assert(tl_room >= 20, "camara de top loader curta demais: suba box_z ou baixe pocket_h");
assert(bite_tl_x >= 2.0,
       "O 2-EM-1 MORREU: o top loader nao para no degrau. pocket_w perto demais de tl_w");
assert(free_sl_x >= 0.5,
       "o penny sleeve nao cabe no bolso: suba pocket_w (mas cuidado com bite_tl_x)");
assert(free_tl_x >= 0.5 && free_tl_y >= 0.5,
       "o top loader nao cabe na camara de cima: suba cav_w/cav_d");
assert(free_sl_y >= 0, "o penny sleeve nao cabe na profundidade do bolso: suba pocket_d");
assert(bite_win_sl >= 2.0, "sleeve escapa pela janela: baixe win_w");
assert(win_w >= 40, "janela estreita demais pra entrar dedo: suba win_w");
assert(flange > 4.0, "montante raso demais pra amarrar o canto: suba jamb baixando win_w");
assert(ledge_b > 0, "sem degrau no fundo: pocket_d nao pode ser >= cav_d");
assert(hex_z1 > hex_z0 + hex_cell_h, "sobra parede de menos pra uma fileira de colmeia");

echo(str("toploader-holder-01  externo ", box_x, " x ", box_y, " x ", box_z));
echo(str("  camara TOP LOADER ", cav_w, " x ", cav_d, " x ", tl_room,
         "  (folga ", free_tl_x, "/lado em X, ", free_tl_y, "/lado em Y)"));
echo(str("  bolso  SLEEVE     ", pocket_w, " x ", pocket_d, " x ", pocket_h,
         "  (folga ", free_sl_x, "/lado em X, ", free_sl_y, " no fundo em Y)"));
echo(str("  DEGRAU z=", ledge_z, "  lateral ", ledge_s, "  fundo ", ledge_b,
         "  frente 0 (rente)  — o top loader pega ", bite_tl_x, "/lado de apoio"));
echo(str("  janela ", win_w, " x ", win_h, "  ombro z=", win_sh, "  bico z=", win_top,
         "  cinta ", band, "  montante ", jamb, " (flange ", flange, ")"));
echo(str("  mordida da janela: sleeve ", bite_win_sl, "/lado   top loader ",
         bite_win_tl, "/lado"));
echo(str("  parede ", wall, " (bolso ", pocket_wall, ")  piso ", floor_h,
         "  chanfro boca ", mouth_lead, "  aro ", rim_ch));
echo(str("  colmeia ", hex_walls ? "LIGADA" : "DESLIGADA", "  celula ", hex_d,
         " x ", hex_cell_h, " (bico ", hex_cap_ang, " graus)  nervura ", hex_web,
         "  faixa z=", hex_z0, "..", hex_z1));
echo(str("  capacidade estimada ~", cap_tl, " top loaders (a ", tl_t,
         "mm) e ~", cap_sl, " penny sleeves (a ", sleeve_t, "mm) — ESTIMATIVA"));

// -------------------------------------------------------------------- Pecas
if      (part == "box")     box();
else if (part == "plate")   box();
else if (part == "par")     for (s = [-1, 1])
                                translate([s * (box_x + plate_gap) / 2, 0, 0]) box();
else if (part == "content") { box(); content(); }
else if (part == "cut")     difference() { box();
                                translate([0, -box_y, -1])
                                    cube([box_x, 2 * box_y, box_z + 2]); }
else                        assert(false, "part desconhecido");

// ------------------------------------------------------------------ Modulos

// A caixa inteira, apoiada em z=0 e centrada em XY. Frente em +Y.
module box() {
    difference() {
        linear_extrude(box_z) outer_2d();
        top_chamber();
        pocket();
        mouth_chamfer();
        rim_chamfer();
        front_window();
        if (hex_walls) { side_hexes(); back_hexes(); }
    }
}

// Contorno externo, com os cantos verticais arredondados.
module outer_2d() {
    offset(r = corner_r, $fn = 32)
        square([box_x - 2 * corner_r, box_y - 2 * corner_r], center = true);
}

// Camara de cima: do DEGRAU pra cima, no vao largo. E ela que define o degrau
// — o que sobra abaixo dela, em volta do bolso, e a parede grossa de 6.5.
module top_chamber() {
    translate([0, 0, ledge_z]) linear_extrude(box_z - ledge_z + 1)
        square([cav_w, cav_d], center = true);
}

// Bolso do sleeve: vao estreito, do topo do piso ao degrau. Rente a FRENTE
// (+Y), com degrau so no fundo — e a frente rente que deixa o dedo entrar.
module pocket() {
    translate([0, cav_d / 2 - pocket_d, floor_h])
        linear_extrude(pocket_h + eps)
            translate([0, pocket_d / 2]) square([pocket_w, pocket_d], center = true);
}

// Chanfro de 45 na boca: guia o top loader pra dentro. Material RECUA subindo.
module mouth_chamfer() {
    translate([0, 0, box_z - mouth_lead]) hull() {
        linear_extrude(eps) square([cav_w, cav_d], center = true);
        translate([0, 0, mouth_lead]) linear_extrude(eps)
            square([cav_w + 2 * mouth_lead, cav_d + 2 * mouth_lead], center = true);
    }
    translate([0, 0, box_z]) linear_extrude(1)
        square([cav_w + 2 * mouth_lead, cav_d + 2 * mouth_lead], center = true);
}

// Chanfro de 45 na aresta externa do aro (o original arredonda; chanfro
// imprime igual e nao inventa camada de meia-espessura no topo).
module rim_chamfer() {
    translate([0, 0, box_z - rim_ch]) difference() {
        linear_extrude(rim_ch + 1) offset(delta = 1) outer_2d();
        hull() {
            linear_extrude(eps) offset(delta = -rim_ch) outer_2d();
            translate([0, 0, rim_ch]) linear_extrude(eps) outer_2d();
        }
    }
}

// Janela da frente: vao unico do peitoril (rente ao topo do piso) ao bico, com
// as duas aguas de 45 fechando o topo. Acima dela, a cinta.
module front_window() {
    translate([0, box_y / 2 + 1, 0]) rotate([90, 0, 0]) linear_extrude(wall + 3)
        polygon([[-win_w / 2, floor_h], [win_w / 2, floor_h],
                 [ win_w / 2, win_sh ], [0, win_top], [-win_w / 2, win_sh]]);
}

// Colmeia das DUAS laterais (um so corte atravessando a caixa em X). So acima
// do degrau: o bolso de sleeve fica macico de proposito (sleeve mole faz
// barriga pra fora do furo).
module side_hexes() {
    translate([-box_x, 0, 0]) rotate([90, 0, 90]) linear_extrude(2 * box_x)
        hex_field(-box_y / 2 + border, box_y / 2 - jamb,
                  hex_z0, hex_z1,
                  hex_d, hex_side, hex_cap, hex_web);
}

// Colmeia do fundo (corte so na parede de tras, em -Y).
module back_hexes() {
    translate([0, -cav_d / 2 + 1, 0]) rotate([90, 0, 0]) linear_extrude(wall + 2)
        hex_field(-box_x / 2 + back_border, box_x / 2 - back_border,
                  hex_z0, hex_z1,
                  hex_d, hex_side, hex_cap, hex_web);
}

// Uma celula da colmeia: hexagono de PONTA PRA CIMA, `w` entre faces, lateral
// reta de `s` e bico de `c` de altura em cima e embaixo. Com c = w/2 o bico e
// de 45 graus; com c = w/(2*sqrt(3)) sai o hexagono REGULAR (bico de 30).
module hex_cell(w, s, c) {
    polygon([[ w / 2,  s / 2], [0,  s / 2 + c], [-w / 2,  s / 2],
             [-w / 2, -s / 2], [0, -(s / 2 + c)], [ w / 2, -s / 2]]);
}

// Colmeia cobrindo o retangulo [u0,u1] x [v0,v1] do plano local, furos
// atravessando a extrusao.
//
// O RECORTE E SO NA HORIZONTAL (em U), e isso NAO e detalhe de estilo:
//   - cortar a celula em U deixa uma aresta VERTICAL no furo, e o bico do topo
//     sobrevive (o apice fica no centro da celula, que por construcao esta
//     dentro do retangulo). Zero balanco novo.
//   - cortar a celula em V decapitaria o bico e deixaria o furo com TETO PLANO
//     de ate `w` de vao — uma ponte reta, exatamente o que a colmeia de ponta
//     pra cima existe pra nao ter. Foi o que apareceu no primeiro render deste
//     modelo, na fileira de cima dos dois campos.
// Entao em V a celula so entra se couber INTEIRA: `cv +- ch` dentro de
// [v0,v1]. O preco e uma faixa macica a mais em cima e embaixo do campo; o
// ganho e que nenhum furo tem teto horizontal.
// Em U continua valendo a regra 4 do repo ("sem lascas"): so entra celula cujo
// CENTRO cai dentro do retangulo, entao o menor furo e ~meia celula, nunca um
// furo-lasca, e o que sobra na borda e faixa macica, nunca uma aleta fina.
// O passo dy sai de exigir nervura `web` tambem na costura DIAGONAL (a fileira
// de cima entra deslocada dx/2): projetando a distancia entre centros na normal
// do flanco do bico. Confere no caso regular: da dy = 0.866*dx.
module hex_field(u0, u1, v0, v1, w, s, c, web) {
    dx = w + web;
    dy = 2 * c + s + 2 * web * sqrt(c * c + w * w / 4) / w - c * dx / w;
    ch = s / 2 + c;                      // meia altura da celula, ponta a centro
    nv = floor(((v1 - v0) - 2 * ch) / dy) + 1;   // fileiras que cabem INTEIRAS
    nu = floor((u1 - u0) / dx) + 1;              // colunas (centro dentro do vao)
    v0c = (v0 + v1) / 2 - (nv - 1) * dy / 2;     // campo CENTRADO no painel
    u0c = (u0 + u1) / 2 - (nu - 1) * dx / 2;
    intersection() {
        translate([u0, v0 - ch]) square([u1 - u0, (v1 - v0) + 2 * ch]);
        union() {
            for (j = [0 : nv - 1], i = [-1 : nu])
                let (cu = u0c + i * dx + (j % 2 == 0 ? 0 : dx / 2),
                     cv = v0c + j * dy)
                    if (cu >= u0 && cu <= u1)
                        translate([cu, cv]) hex_cell(w, s, c);
        }
    }
}

// O conteudo do jeito que fica guardado (diagnostico/render): a pilha de top
// loader assentada NO DEGRAU e a pilha de sleeve no fundo do bolso.
module content() {
    translate([0, 0, ledge_z]) linear_extrude(tl_room - 6)
        square([tl_w, tl_h], center = true);
    translate([0, cav_d / 2 - sleeve_h / 2 - 1, floor_h])
        linear_extrude(pocket_h - 4) square([sleeve_w, sleeve_h], center = true);
}
