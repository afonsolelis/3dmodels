/*
  switch-case-organizer-01

  Organizador aberto para 12 caixas fisicas de jogos Nintendo Switch / Switch 2.
  O usuario apoia o organizador na prateleira, introduz cada caixa por cima em
  um dos 12 canais e retira pela lombada. Guias altas nas duas pontas seguram
  cada caixa contra inclinacao; o vao central deixa os dedos alcancarem as faces.

  Duas unidades identicas acoplam lado a lado: alinhe os dois pares de rabos-
  de-andorinha, mantenha as bases paralelas e baixe a unidade da direita por
  todo o curso vertical. Para separar, segure ambas as bases e levante uma
  unidade 28.0 mm; nao e necessario retirar as caixas dos canais.

  Interface reconstruida da malha diversos/switch_game_tray_12.3mf, que traz
  inequivocamente 12 canais de 11.25 mm, passo de 13 mm e apoio de 110.1 mm.
  Nenhuma dimensao de catalogo da caixa foi presumida.

  Export canonico (caminhos absolutos):
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/diversos/switch-case-organizer-01/stl/switch-case-organizer-01.stl -D 'part="organizer"' /home/afonsolelis/Repos/3dmodels/diversos/switch-case-organizer-01/switch-case-organizer-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/diversos/switch-case-organizer-01/3mf/switch-case-organizer-01.3mf -D 'part="plate"' /home/afonsolelis/Repos/3dmodels/diversos/switch-case-organizer-01/switch-case-organizer-01.scad
*/

/* [Exportacao] */
part = "organizer"; // [organizer,plate,assembly,collision,retention_test] Parte, job ou verificacao.
collision_z = is_undef(collision_z_override) ? 0 : collision_z_override; // mm; amostra do curso para teste booleano.
assembly_lift = is_undef(assembly_lift_override) ? 0 : assembly_lift_override; // mm; visualizacao do curso vertical.
$fn = 48;           // segmentos; acabamento dos recortes hexagonais.

/* [Caixas e capacidade] */
case_count = is_undef(case_count_override) ? 12 : case_count_override; // unidades; caixas por organizador.
case_slot_w = is_undef(case_slot_w_override) ? 11.25 : case_slot_w_override; // mm; vao real reconstruido da referencia.
slot_pitch = is_undef(slot_pitch_override) ? 13.0 : slot_pitch_override; // mm; distancia entre centros na referencia.
support_depth = is_undef(support_depth_override) ? 110.1 : support_depth_override; // mm; profundidade apoiada pela referencia.

/* [Estrutura] */
floor_t = 2.4;        // mm; piso das duas sapatas.
guide_h = 30.0;       // mm acima do piso; 15.6 mm a mais que as guias de 14.4 mm da referencia.
guide_depth = 28.0;   // mm em cada ponta; quatro pontos de apoio por caixa.
end_wall_t = 2.0;     // mm; paredes externas que fecham a primeira/ultima canaleta.
side_wall_t = 3.0;    // mm; longarinas laterais que unem as duas sapatas.
side_wall_h = 30.0;   // mm acima do piso; trava as extremidades laterais.
hex_r = 7.0;          // mm; raio dos hexagonos ponta-pra-cima nas longarinas.
hex_pitch = 19.0;     // mm; passo dos hexagonos ao longo da profundidade.
tie_t = 1.2;          // mm; tres linhas de bico 0.4, espessura externa da cinta.
tie_h = 4.0;          // mm; altura da viga de amarracao perto do topo das guias.

/* [Acoplamento modular] */
modular_connectors = is_undef(modular_connectors_override) ? true : modular_connectors_override; // liga/desliga; macho direito e femea esquerda.
slide_clearance = 0.5; // mm por lado; folga atual do repo para deslizamento longo.
connector_depth = 5.0; // mm; projecao lateral util do rabo-de-andorinha.
connector_neck_w = 8.0; // mm; largura do pescoco no eixo Y.
connector_head_w = 12.0; // mm; largura da cabeca no eixo Y.
connector_h = 24.0; // mm; comprimento vertical engatado.
connector_bottom = 4.4; // mm; afasta macho do pe de elefante e preserva o piso.
connector_receiver_wall = 1.5; // mm; parede minima ao redor da femea.
elephant_relief = 0.3; // mm por face; alivio adicional no primeiro 1.2 mm da femea.
connector_y = [20, support_depth-20]; // mm; centros dos dois conectores, acessiveis nas pontas.

// Derivados
divider_t = slot_pitch - case_slot_w;
inner_w = case_count * case_slot_w + (case_count - 1) * divider_t;
interface_w = inner_w + 2 * end_wall_t;
overall_w = interface_w + 2 * side_wall_t;
overall_d = support_depth;
overall_h = floor_t + max(guide_h, side_wall_h);
center_access = support_depth - 2 * guide_depth;
hex_count = floor((support_depth - 2 * 10) / hex_pitch) + 1;
receiver_depth = connector_depth + slide_clearance + connector_receiver_wall;
receiver_w = connector_head_w + 2*slide_clearance + 2*connector_receiver_wall;
connector_top = connector_bottom + connector_h;
assembly_vertical_course = overall_h - connector_bottom;
coupled_pitch = overall_w + receiver_depth + slide_clearance;
receiver_opening_w = connector_neck_w + 2*slide_clearance
                   + (connector_head_w-connector_neck_w)*(slide_clearance/connector_depth);
retention_per_side = (connector_head_w-receiver_opening_w)/2;
modular_min_x = modular_connectors ? -receiver_depth : 0;
modular_max_x = modular_connectors ? overall_w + connector_depth : overall_w;
print_w = modular_max_x - modular_min_x;
print_d = overall_d + 2*tie_t;

assert(case_count >= 1, "case_count precisa ser >= 1");
assert(divider_t >= 1.2, "divisorias finas demais para FDM");
assert(center_access >= 35, "vao central pequeno demais para alcance dos dedos");
assert(connector_head_w > connector_neck_w, "rabo-de-andorinha precisa de retencao positiva");
assert(connector_bottom >= floor_t+1.2, "macho baixo demais: risco de pe de elefante");
assert(connector_top <= overall_h-2, "falta material acima/abaixo do conector");
assert(retention_per_side >= 1.0, "retencao lateral insuficiente no receptor");
assert(tie_t >= 1.2 && tie_h >= 3*tie_t, "cinta fina demais para amarrar as divisorias");
assert(print_w <= 210 && print_d <= 210 && overall_h <= 220,
       "organizador excede o limite confortavel da AD5X");

echo("DERIVADOS switch-case-organizer-01");
echo(case_count=case_count, case_slot_w=case_slot_w, divider_t=divider_t, slot_pitch=slot_pitch);
echo(interface_w=interface_w, extreme_channels_mm=[case_slot_w,case_slot_w]);
echo(overall_mm=[overall_w, overall_d, overall_h], guide_mm=[guide_h, guide_depth], center_access=center_access);
echo(modular_bbox_mm=[print_w,print_d,overall_h], connector_clearance_per_side=slide_clearance,
     connector_engagement_h=connector_h, assembly_vertical_course=assembly_vertical_course,
     coupled_body_pitch=coupled_pitch, receiver_opening_w=receiver_opening_w,
     retention_per_side=retention_per_side);

module pointy_hex_2d(r) {
  polygon([for (a=[0:60:300]) [r*cos(a+30), r*sin(a+30)]]);
}

module side_hex_cuts(x0) {
  for (i=[0:hex_count-1]) {
    y = 10 + i * hex_pitch;
    translate([x0, y, floor_t + side_wall_h/2])
      rotate([0,90,0])
        linear_extrude(height=side_wall_t+1, center=true)
          pointy_hex_2d(hex_r);
  }
}

module front_tie() {
  tie_z = overall_h-tie_h;
  // Barra externa y=-1.2..0. Cada abertura triangular sobe ate deixar uma
  // faixa continua de 1.2 mm; as diagonais eliminam pontes retas de 11.25 mm.
  translate([0,0,tie_z])
    rotate([90,0,0])
      linear_extrude(height=tie_t)
        difference() {
          square([overall_w,tie_h]);
          for (i=[0:case_count-1]) {
            sx = side_wall_t+end_wall_t+i*slot_pitch;
            polygon([[sx,-0.1],
                     [sx+case_slot_w,-0.1],
                     [sx+case_slot_w/2,tie_h-tie_t]]);
          }
        }
}

module guide_ties() {
  front_tie();
  translate([0,overall_d,0]) mirror([0,1,0]) front_tie();
}

// Perfil XY do macho. A cabeca mais larga impede separacao lateral; a extrusao
// em Z permite montar por cima sem flexionar paredes e sem suporte.
module male_profile(extra=0) {
  polygon([[0,-connector_neck_w/2-extra],
           [connector_depth+extra,-connector_head_w/2-extra],
           [connector_depth+extra, connector_head_w/2+extra],
           [0, connector_neck_w/2+extra]]);
}

module male_connector(yc) {
  // Chanfro vertical de entrada de 1.2 mm: a ponta inferior menor centraliza
  // antes de os 24 mm de engate entrarem na femea.
  translate([overall_w, yc, connector_bottom])
    hull() {
      linear_extrude(height=0.01) scale([0.70,0.70]) male_profile();
      translate([0,0,1.2]) linear_extrude(height=0.01) male_profile();
    }
  translate([overall_w, yc, connector_bottom+1.2])
    linear_extrude(height=connector_h-1.2) male_profile();
}

module female_connector(yc) {
  difference() {
    // As duas paredes do receptor nascem na cama: nao ha anel suspenso nem
    // cantilever a 2.4 mm. A uniao com piso/longarina ocorre desde z=0.
    translate([-receiver_depth, yc-receiver_w/2, 0])
      cube([receiver_depth, receiver_w, overall_h]);
    // Canal aberto em cima e embaixo: a prateleira alinha as bases e a abertura
    // inferior elimina colisao/pe de elefante no curso completo.
    // A transformacao usa o passo real entre corpos: quando a copia vizinha
    // esta em coupled_pitch, este negativo coincide exatamente com seu macho,
    // acrescido de 0.5 mm em cada face Y e 0.5 mm alem da cabeca em X.
    translate([-receiver_depth-slide_clearance, yc, -0.1]) {
      // Funil curto contra pe de elefante: +0.3 mm por face na cama,
      // convergindo para a folga nominal de 0.5 mm em z=1.2.
      hull() {
        linear_extrude(height=0.01)
          male_profile(slide_clearance+elephant_relief);
        translate([0,0,1.3]) linear_extrude(height=0.01)
          male_profile(slide_clearance);
      }
      translate([0,0,1.3])
        linear_extrude(height=overall_h)
          male_profile(slide_clearance);
    }
  }
}

module organizer_core() {
  difference() {
    union() {
      // Duas sapatas largas sustentam as caixas perto das duas extremidades.
      cube([overall_w, guide_depth, floor_t]);
      translate([0, overall_d-guide_depth, 0]) cube([overall_w, guide_depth, floor_t]);

      // Longarinas unem as sapatas e impedem a peca de abrir/torcer.
      cube([side_wall_t, overall_d, overall_h]);
      translate([overall_w-side_wall_t, 0, 0]) cube([side_wall_t, overall_d, overall_h]);

      // Paredes externas e divisorias em ambas as pontas: a caixa recebe
      // quatro superficies-guia, duas na frente e duas atras.
      for (y0=[0, overall_d-guide_depth]) {
        // Toda a interface com as caixas comeca depois da longarina esquerda.
        // As longarinas ficam integralmente FORA dos canais extremos.
        translate([side_wall_t, y0, 0]) cube([end_wall_t, guide_depth, floor_t+guide_h]);
        translate([side_wall_t+interface_w-end_wall_t, y0, 0]) cube([end_wall_t, guide_depth, floor_t+guide_h]);
        for (i=[1:case_count-1]) {
          x = side_wall_t + end_wall_t + i*case_slot_w + (i-1)*divider_t;
          translate([x, y0, floor_t]) cube([divider_t, guide_depth, guide_h]);
        }
      }
      guide_ties();
    }

    // Identidade visual do repo; faixa solida de 3 mm no piso e >=7 mm
    // nas pontas evita lascas junto das bordas.
    side_hex_cuts(side_wall_t/2);
    side_hex_cuts(overall_w-side_wall_t/2);
  }
}

module organizer() {
  union() {
    organizer_core();
    if (modular_connectors)
      for (yc=connector_y) {
        male_connector(yc);
        female_connector(yc);
      }
  }
}

module assembly() {
  organizer();
  translate([coupled_pitch,0,assembly_lift]) organizer();
}

module collision_at(zlift=0) {
  intersection() {
    organizer();
    translate([coupled_pitch,0,zlift]) organizer();
  }
}

module retention_test() {
  // Ao tentar afastar lateralmente a copia 1 mm, a cabeca deve interceptar
  // os ombros do receptor; intersecao nao vazia comprova a retencao positiva.
  intersection() {
    organizer();
    translate([coupled_pitch+1,0,0]) organizer();
  }
}

if (part == "organizer" || part == "plate") organizer();
else if (part == "assembly") assembly();
else if (part == "collision") collision_at(collision_z);
else if (part == "retention_test") retention_test();
else assert(false, str("part desconhecida: ", part));
