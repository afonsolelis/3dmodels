/*
  toolbox-snap-01

  Caixa de ferramentas de bancada que ocupa a cama inteira da AD5X, com
  layout interno fixo (impresso junto com a caixa) e TAMPA DESLIZANTE que
  da um CLIQUE e trava no fim do curso.

  COMO O USUARIO MANUSEIA (mundo fisico):
  - A caixa fica deitada na bancada, 206 x 208 x 60 mm, e e uma peca so.
  - A tampa entra pela BOCA (o lado direito, x = box_w), que e a unica parede
    baixa da caixa. Ela corre em dois trilhos escavados nas paredes da frente
    e de tras e desliza no eixo X, no sentido do comprimento da canaleta.
  - Fechando: a tampa corre livre ate faltarem ~10 mm. Ai a ponta de cada uma
    das duas LINGUETAS FLEXIVEIS da tampa (cantilever de 8 x 24.5 mm recortado
    em U na propria chapa) sobe na saliencia de 1.0 mm do piso do trilho. A
    tampa inteira sobe 0.7 mm de folga e as duas linguetas FLETEM os 0.3 mm
    que faltam - e para isso que existe o alivio local de teto de 1.2 mm sobre
    a saliencia, senao a lingueta nao teria para onde subir. No fim do curso o
    bolso engole a saliencia e as linguetas voltam: CLIQUE.
  - Abrindo: pega-se a SAIA (o puxador de 11 mm que desce por fora da parede
    da boca, com colmeia antiderrapante). A ponta da saia e afunilada e a
    parede da boca tem tres escalopos de 45 x 9 mm logo abaixo dela: o dedo
    entra por tras da saia de verdade, nao so encosta nela. Puxando, a rampa
    de 45 graus do bolso converte o puxao em flexao das linguetas
    (~5 N por lado, ~10-15 N no total) e a tampa estala e corre livre.
  - A tampa sai por inteiro (curso 202.7 mm). ATENCAO: tirar o ALICATE exige
    a tampa praticamente toda fora, porque a canaleta tem 200 dos 206 mm de
    comprimento da caixa. Isso e inerente ao layout pedido, nao e defeito. Ja
    o PORTA-BITS fica na coluna do FUNDO (x = 3..68), que e a primeira coisa
    que aparece: ~68 mm de abertura descobrem a matriz inteira de bits.

  POR QUE A FOLGA DO TRILHO E 0.7/LADO, E NAO OS 0.5 PADRAO DO REPO:
  A regra 6 do CLAUDE.md nasceu do deckbox-02 IMPRESSO, que travou no meio do
  curso com 0.25/lado e virou 0.5/lado, com o aviso explicito "quanto mais
  longo o encaixe, mais folga". Aqui o encaixe e o mais longo ja feito no
  repo: 202.7 mm de curso, com uma chapa plana de 206 x 202.6 x 3 mm que
  imprime deitada e EMPENA. Por isso:
    - folga de 0.7 mm POR LADO, na vertical e na horizontal (rail_clear);
    - o TETO do trilho e um plano a 45 graus (nao um degrau reto): se a tampa
      subir, ela encontra uma rampa que a empurra de volta para baixo em vez
      de cunhar numa quina viva - e a mesma razao pela qual o teto imprime
      sem suporte;
    - chanfro/funil de entrada na boca do trilho: o piso do trilho cai
      0.6 mm nos ultimos 8 mm (flare), a tampa tem as duas quinas de ataque
      chanfradas em 45 graus e a face de baixo da aresta de ataque chanfrada,
      e o topo das divisorias internas e chanfrado a 45 graus na aresta
      voltada para a boca (senao o nariz da tampa engancha nela);
    - APOIO CENTRAL: as duas divisorias que separam a canaleta da grade e as
      duas linhas da grade correm em X de parede a parede e param 0.4 mm
      abaixo da tampa. O maior vao sem apoio da tampa cai de 196 mm para
      70.5 mm - e o que impede a barriga do meio de raspar ou cair.

  PE DE ELEFANTE - ONDE ELE ENTRA E ONDE NAO ENTRA (corrigido apos review):
  Na CAIXA o trilho nasce em z = 50, longe da cama: nao ha pe de elefante no
  trilho dela. Na TAMPA e o contrario: ela imprime de cabeca para baixo, entao
  as DUAS ARESTAS LONGAS DA PRIMEIRA CAMADA (y = 2.7 e y = 205.3) sao
  exatamente as pontas das linguetas do trilho. Com 0.2-0.3 mm de pe de
  elefante a folga em Y cairia de 0.70 para ~0.40 por lado. Por isso o
  perimetro inteiro da face de cima da tampa leva um CHANFRO MODELADO de
  0.4 x 45 graus - nao se depende da compensacao do fatiador.

  PORTA-BITS: um dos 6 compartimentos da grade (linha colada na canaleta,
  coluna do FUNDO - bit_row = 0, bit_col = 0) tem um bloco com matriz de furos
  hexagonais para bits de 1/4" (6.35 mm entre faces planas) com 0.3 mm de
  folga POR LADO sobre o entre-faces - a folga de "peca solta em cavidade" do
  repo. Furo cego VERTICAL: nao existe ponte reta a vencer (a "boca" do furo e
  o topo, aberto), e o hexagono fica com vertice para +Y, na identidade
  ponta-pra-cima do repo. Profundidade 12 mm para um bit de 25 mm: sobram
  13 mm de fora, o suficiente para pincar com dois dedos. O bloco NAO enche a
  celula: ele tem o tamanho da matriz mais a margem, e sobra uma canaleta de
  6.5 x 65 x 47 mm no fundo da celula para haste fina (chave de fenda, broca).

  IDENTIDADE VISUAL: colmeia de hexagonos ponta-pra-cima em BAIXO-RELEVO
  (celulas rebaixadas 1.0 mm, como no ring-01) nas quatro paredes externas e
  na saia da tampa. NAO sao furos passantes: a caixa continua fechada contra
  poeira e a parede que segura o trilho continua com 5.0 mm dos 6.0 mm de
  secao. Faixa solida de 4 mm em volta de cada painel e faixa solida de
  z = 44 para cima, ou seja, a colmeia NUNCA chega perto do trilho.

  EXCECAO CONSCIENTE A REGRA 5: a face de CIMA da tampa fica LISA, sem
  colmeia. Ela e a face que vai na cama e e a unica coisa que segura o empeno
  de uma chapa de 206 x 202.6 x 3 mm - uma primeira camada macica de ~41.000
  mm2. Rebaixar hexagono ali significaria comecar a peca de maior risco do
  projeto com a area de adesao recortada.

  TRES JOBS DE IMPRESSAO:
    0) plate_coupon - CUPOM DE TESTE, IMPRIMA ISTO PRIMEIRO (~1 h). E a caixa
       inteira encolhida em X e Y (60 x 60) com a mesma secao de trilho, o
       mesmo funil de boca, a mesma saliencia de snap, o mesmo escalopo de
       dedo e a tampa curta com as duas linguetas flexiveis. Valida folga de
       trilho, pe de elefante, forca do snap e pega ANTES de queimar 16-20 h
       na caixa grande.
    1) plate_box - a caixa na orientacao de uso, boca de compartimento para
       cima, sem suporte.
    2) plate_lid - a tampa DE CABECA PARA BAIXO (face de cima na cama): assim
       a saia do puxador aponta para cima, os bolsos do snap ficam em face
       voltada para cima e a primeira camada e uma chapa cheia de ~41.000 mm2.
  BRIM NAO CABE (206 + 2x5 = 216 contra o alvo de 210), entao as duas chapas
  grandes saem com MOUSE EARS MODELADOS: quatro discos de 10 mm x 0.4 mm nos
  cantos, envelope 211 x 213 na caixa e 211 x 207.6 na tampa - dentro dos 220
  fisicos da AD5X. Nao depende de configuracao do fatiador; quebra-se com a
  unha depois.

  Export canonico (caminhos absolutos):
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/stl/toolbox-snap-01-box.stl -D 'part="box"' /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/toolbox-snap-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/stl/toolbox-snap-01-lid.stl -D 'part="lid"' /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/toolbox-snap-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/3mf/toolbox-snap-01-cupom.3mf -D 'part="plate_coupon"' /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/toolbox-snap-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/3mf/toolbox-snap-01-caixa.3mf -D 'part="plate_box"' /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/toolbox-snap-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/3mf/toolbox-snap-01-tampa.3mf -D 'part="plate_lid"' /home/afonsolelis/Repos/3dmodels/ferramentas/toolbox-snap-01/toolbox-snap-01.scad

  ATENCAO (armadilha registrada no CLAUDE.md): pela linha de comando mire
  sempre a variavel FINAL (-D slide=50, -D part="collision"), nunca um
  *_override - no OpenSCAD 2021.01 o -D entra no fim do escopo de topo e o
  is_undef() ja foi avaliado, entao o valor seria ignorado EM SILENCIO.
*/

/* [Exportacao] */
part = "box"; // [box,lid,plate_box,plate_lid,plate_coupon,coupon_box,coupon_lid,assembly,collision,retention,lift,relief,section]
slide = is_undef(slide_override) ? 0 : slide_override;  // mm; quanto a tampa esta puxada para fora (0 = fechada e travada).
lift  = is_undef(lift_override)  ? 0 : lift_override;   // mm; quanto a tampa esta levantada (teste de captura no trilho).
$fn = 32;      // segmentos; hexagonos, chanfros e mouse ears.

/* [Envelope da caixa] */
box_h   = 60.0;  // mm; altura externa pedida.
floor_t = 3.0;   // mm; piso da caixa (chapa que leva o peso das ferramentas).
wall_x  = 3.0;   // mm; paredes das duas pontas (fundo do curso e boca).
wall_y  = 6.0;   // mm; paredes da frente/tras: sao as que levam o trilho escavado.

/* [Layout interno - canaleta do alicate] */
plier_len = 180.0; // mm; comprimento do alicate que deita na canaleta (medida do usuario).
plier_pad = 2.0;   // mm; folga minima exigida em CADA ponta do alicate.
chan_w    = 50.0;  // mm; largura da canaleta em Y, pedida pelo usuario.

/* [Layout interno - grade 3x2] */
grid_cols = 3;     // colunas da grade.
grid_rows = 2;     // linhas da grade.
cell_w    = 65.0;  // mm; largura util de cada compartimento (X).
cell_d    = 70.5;  // mm; profundidade util de cada compartimento (Y).
div_t     = 2.5;   // mm; espessura de toda divisoria interna.
lid_gap   = 0.4;   // mm; folga entre o topo das divisorias e a face de baixo da tampa.
div_cham  = 1.0;   // mm; chanfro de 45 graus no topo das divisorias, na aresta virada para a boca.

/* [Porta-bits] */
bit_af     = 6.35; // mm; entre faces planas do bit de 1/4".
bit_len    = 25.0; // mm; comprimento do bit.
bit_clear  = 0.3;  // mm POR LADO sobre o entre-faces; folga de peca solta em cavidade (regra 6).
bit_depth  = 12.0; // mm; profundidade do furo hexagonal.
bit_pitch  = 12.5; // mm; passo da matriz; o maior que ainda da 5x5 na celula, com ~4.5 mm de ar entre bits.
bit_margin = 3.0;  // mm; borda solida do bloco em volta da matriz.
bit_base   = 3.0;  // mm; material solido embaixo do fundo do furo.
bit_lead   = 1.2;  // mm; funil de entrada a 45 graus na boca de cada furo (ergonomia, nao imprimibilidade).
bit_col    = 0;    // 0..grid_cols-1; coluna do porta-bits. 0 = FUNDO do curso, a primeira que a tampa descobre.
bit_row    = 0;    // 0..grid_rows-1; linha do porta-bits. 0 = a linha colada na canaleta.

/* [Trilho da tampa] */
lid_t      = 3.0;  // mm; espessura da chapa da tampa.
rail_depth = 4.0;  // mm; profundidade do rasgo escavado em cada parede Y.
rail_h     = 7.0;  // mm; altura do rasgo na face interna; TEM que ser > rail_depth para o teto sair a 45 graus.
lip_t      = 3.0;  // mm; material solido acima do rasgo, ate o topo da caixa.
rail_clear = 0.7;  // mm POR LADO; folga do deslizamento (ver justificativa no cabecalho).
flare_len  = 8.0;  // mm; comprimento do funil de entrada na boca do trilho.
flare_drop = 0.6;  // mm; quanto o piso do trilho cai na boca.
ef_cham    = 0.4;  // mm; chanfro a 45 graus no perimetro da face de cima da tampa (anti pe de elefante).

/* [Snap de fim de curso - saliencia na caixa + lingueta flexivel na tampa] */
bump_h     = 1.0;  // mm; altura da saliencia no piso do trilho.
bump_len   = 6.0;  // mm; comprimento da saliencia em X (rampas de 45 graus nas duas pontas).
bump_x     = 12.0; // mm; distancia do fundo da caixa ate o centro da saliencia.
bump_y0    = 0.8;  // mm; inicio da saliencia medido da face interna da parede para fora.
bump_y1    = 3.6;  // mm; fim da saliencia, idem.
snap_clear = 0.3;  // mm; folga do bolso da tampa sobre a saliencia, em X e em Y.
beam_w     = 8.0;  // mm; largura da lingueta flexivel (em Y).
beam_len   = 20.0; // mm; braco util: da raiz ate o centro do bolso.
beam_tip   = 4.5;  // mm; quanto a lingueta avanca alem do bolso.
slot_w     = 1.6;  // mm; largura do rasgo em U que libera a lingueta.
relief_h   = 1.2;  // mm; alivio LOCAL do teto do trilho sobre a saliencia; e o curso da lingueta.
relief_pad = 8.0;  // mm; quanto o alivio se estende alem da saliencia em cada lado.
pla_E      = 2500; // MPa; modulo de flexao do PLA usado so para ESTIMAR a forca do snap.

/* [Puxador / saia da tampa] */
skirt_t    = 3.0; // mm; espessura da saia que desce por fora da parede da boca.
skirt_drop = 8.0; // mm; quanto a saia desce abaixo da face de baixo da tampa.
skirt_gap  = 0.3; // mm; ar entre a face interna da saia e a face externa da parede da boca.
skirt_taper= 2.2; // mm; quanto a face INTERNA da saia recua na ponta, abrindo cunha para o dedo.
skirt_tap_h= 4.0; // mm; altura em que esse recuo acontece.
lead_gap   = 0.3; // mm; ar entre a aresta de ataque da tampa e a parede do fundo, com a tampa travada.
lead_cham  = 2.0; // mm; chanfro de 45 graus nas duas quinas de ataque da tampa.

/* [Escalopo de dedo na parede da boca] */
sc_n      = 3;    // quantos escalopos ao longo da boca.
sc_w      = 45.0; // mm; largura de cada escalopo (em Y).
sc_depth  = 1.5;  // mm; profundidade escavada na face externa; a parede NAO e furada.
sc_z0     = 32.0; // mm; base do escalopo.
sc_z1     = 41.0; // mm; topo do escalopo, logo abaixo da ponta da saia (z = 42).

/* [Colmeia - baixo relevo, identidade do repo] */
hex_r      = 5.0;  // mm; raio das celulas hexagonais ponta-pra-cima.
hex_web    = 2.6;  // mm; nervura entre celulas vizinhas.
hex_relief = 1.0;  // mm; profundidade do rebaixo (NAO e furo passante).
hex_z0     = 5.0;  // mm; base da faixa texturizada nas paredes.
hex_z1     = 44.0; // mm; topo da faixa; deixa 6 mm solidos ate o piso do trilho em z=50.
hex_margin = 4.0;  // mm; faixa solida em volta de cada painel (regra 4: sem lascas).

/* [Mouse ears - substituem o brim, que nao cabe] */
ear_d     = 10.0; // mm; diametro do disco.
ear_h     = 0.4;  // mm; altura (2 camadas de 0.2).
ear_inset = 2.5;  // mm; quanto o centro do disco recua para dentro do canto.

/* [Cupom de teste] */
coupon_w  = 60.0; // mm; comprimento do cupom em X (boca + saliencia do snap).
coupon_d  = 60.0; // mm; profundidade do cupom em Y (os DOIS trilhos, de verdade).
coupon_z0 = 40.0; // mm; piso virtual: o cupom e a fatia z=40..60 da caixa, para imprimir em ~1 h.
coupon_gap= 6.0;  // mm; vao entre as duas pecas do cupom na chapa.

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
inner_w   = grid_cols*cell_w + (grid_cols-1)*div_t;                 // 200.0 - largura util interna (X)
inner_d   = chan_w + div_t + grid_rows*cell_d + (grid_rows-1)*div_t;// 196.0 - profundidade util interna (Y)
box_w     = inner_w + 2*wall_x;                                     // 206.0 - externo X
box_d     = inner_d + 2*wall_y;                                     // 208.0 - externo Y

rail_z    = box_h - lip_t - rail_h;   // 50.0 - piso do trilho = face de baixo da tampa
inner_h   = rail_z - floor_t;         // 47.0 - profundidade util dos compartimentos
div_h     = inner_h - lid_gap;        // 46.6 - altura das divisorias acima do piso
div_top   = floor_t + div_h;          // 49.6 - cota do topo das divisorias

chan_x0   = wall_x;                   // 3.0
chan_len  = inner_w;                  // 200.0 - comprimento util da canaleta
chan_y0   = wall_y;                   // 6.0
chan_y1   = chan_y0 + chan_w;         // 56.0

tongue_d  = rail_depth - rail_clear;  // 3.3 - quanto a lingueta da tampa entra em cada parede
lid_y0    = wall_y - tongue_d;        // 2.7
lid_w     = box_d - 2*lid_y0;         // 202.6 - largura da tampa (Y)
lid_x0    = wall_x + lead_gap;        // 3.3 - aresta de ataque com a tampa fechada
skirt_x0  = box_w + skirt_gap;        // 206.3
lid_x1    = skirt_x0 + skirt_t;       // 209.3 - ponta externa da saia
lid_len   = lid_x1 - lid_x0;          // 206.0 - bbox da tampa em X
travel    = box_w - lid_x0;           // 202.7 - curso ate a lingueta deixar a boca
mouth_top = rail_z - lid_gap;         // 49.6 - topo da parede da boca
skirt_z0  = rail_z - skirt_drop;      // 42.0 - base da saia
rail_skin = wall_y - rail_depth;      // 2.0 - pele que sobra atras do rasgo

// Snap: a folga vertical livre da tampa e rail_clear; o que passa disso a
// lingueta tem que FLETIR. E por isso que existe a lingueta e o alivio local.
snap_flex   = bump_h - rail_clear;                 // 0.3 - flexao exigida da lingueta
beam_root_x = bump_x + beam_len;                   // 32.0 - raiz da lingueta
beam_tip_x  = bump_x - beam_tip;                   // 7.5  - ponta livre
beam_y1     = lid_y0 + beam_w;                     // 10.7 - lado interno da lingueta
slot_x0     = beam_tip_x - slot_w;                 // 5.9  - onde comeca o rasgo em U
lead_strip  = slot_x0 - lid_x0;                    // 2.6  - faixa de chapa na frente do rasgo
beam_I      = beam_w*pow(lid_t,3)/12;              // mm4
beam_k      = 3*pla_E*beam_I/pow(beam_len,3);      // N/mm - rigidez estimada da lingueta
snap_force  = beam_k*snap_flex;                    // N por lado
pocket_h    = bump_h + 0.1;                        // 1.1 - profundidade do bolso
pocket_len  = bump_len + 2*snap_clear;             // 6.6 - abertura do bolso no plano do piso
pocket_roof = lid_t - pocket_h;                    // 1.9 - chapa que sobra sobre o bolso
relief_x0   = bump_x - bump_len/2 - relief_pad;    // 1.0
relief_x1   = bump_x + bump_len/2 + relief_pad;    // 23.0
lip_at_relief = lip_t - relief_h;                  // 1.8 - lip que sobra na janela de alivio

bit_hole_af = bit_af + 2*bit_clear;             // 6.95 - entre faces do furo
bit_hole_d  = bit_hole_af / cos(30);            // 8.03 - diametro circunscrito do furo
bit_block_h = bit_base + bit_depth;             // 15.0 - altura do bloco acima do piso
bit_span_x  = cell_w - 2*bit_margin - bit_hole_d;
bit_span_y  = cell_d - 2*bit_margin - bit_hole_d;
bit_cols    = floor(bit_span_x/bit_pitch) + 1;
bit_rows    = floor(bit_span_y/bit_pitch) + 1;
bit_count   = bit_cols * bit_rows;
bit_air     = bit_pitch - bit_hole_d;           // ar entre dois bits vizinhos
bit_out     = bit_len - bit_depth;              // 13.0 - quanto o bit sobra para fora
bit_block_d = (bit_rows-1)*bit_pitch + bit_hole_d + 2*bit_margin;  // bloco so no tamanho da matriz
bit_rest_d  = cell_d - bit_block_d;             // canaleta que sobra na celula para haste fina

coupon_lid_w = coupon_d - 2*lid_y0;
plate_box_fp = [box_w + 2*(ear_d/2 - ear_inset), box_d + 2*(ear_d/2 - ear_inset), box_h];
plate_lid_fp = [lid_len + 2*(ear_d/2 - ear_inset), lid_w + 2*(ear_d/2 - ear_inset), lid_t + skirt_drop];
plate_coupon_fp = [2*coupon_w + coupon_gap, coupon_d, box_h - coupon_z0];

function row_y0(i) = chan_y1 + div_t + i*(cell_d + div_t);
function col_x0(j) = wall_x + j*(cell_w + div_t);

assert(chan_len >= plier_len + 2*plier_pad,
       "canaleta curta demais para o alicate de 180 mm");
assert(rail_h > rail_depth,
       "teto do trilho nao sai a 45 graus: rail_h precisa ser maior que rail_depth");
// O snap so e snap se existir MEMBRO FLEXIVEL com curso: a lingueta precisa
// fletir o que passa da folga do trilho, e o alivio local de teto precisa
// dar espaco para essa flexao. Sem as duas coisas a quina viva se aplaina na
// primeira montagem e a retencao vira o peso da tampa.
assert(snap_flex >= 0.15 && snap_flex <= 0.6,
       "curso da lingueta fora da faixa util (0.15 a 0.6 mm)");
assert(relief_h >= snap_flex + 0.5,
       "alivio local de teto nao da curso para a lingueta fletir");
assert(lip_at_relief >= 1.2, "janela de alivio deixa lip fino demais");
assert(pocket_roof >= 1.2, "chapa sobre o bolso do snap fina demais");
assert(lead_strip >= 1.2, "faixa de chapa na frente do rasgo em U fina demais");
assert(beam_w >= 6.0 && beam_len >= 12.0, "lingueta curta/estreita demais para fletir");
assert(beam_y1 + slot_w < lid_y0 + lid_w/2, "rasgo em U invadindo o meio da tampa");
assert(rail_skin >= 1.8, "pele fina demais atras do rasgo do trilho");
assert(hex_z1 + 4 <= rail_z, "colmeia perto demais do trilho");
assert(tongue_d >= 3.0, "engate lateral da tampa curto demais para uma chapa de 200 mm");
assert(div_top < rail_z, "divisoria interna encostando na tampa");
assert(wall_x - sc_depth >= 1.2, "escalopo de dedo fura a parede da boca");
assert(sc_z1 < skirt_z0, "escalopo de dedo alto demais: bate na saia");
assert(bit_air >= 4.0, "ar entre bits apertado para o dedo");
assert(bit_out >= 8.0, "bit afogado: sobra pouco para pegar com o dedo");
assert(bit_block_d <= cell_d, "bloco de bits maior que a celula");
assert(box_w <= 210 && box_d <= 210, "caixa estoura o limite confortavel de 210 da AD5X");
assert(lid_len <= 210 && lid_w <= 210, "tampa estoura o limite confortavel de 210 da AD5X");
assert(plate_box_fp[0] <= 220 && plate_box_fp[1] <= 220, "chapa com mouse ears estoura a cama fisica");

echo("DERIVADOS toolbox-snap-01");
echo(externo_caixa_mm=[box_w, box_d, box_h], interno_mm=[inner_w, inner_d, inner_h]);
echo(canaleta_util_mm=[chan_len, chan_w, inner_h], alicate_mm=plier_len,
     sobra_por_ponta_mm=(chan_len-plier_len)/2, exigido_min_mm=182);
echo(compartimentos=grid_cols*grid_rows, compartimento_mm=[cell_w, cell_d, inner_h], divisoria_mm=div_t);
echo(tampa_mm=[lid_len, lid_w, lid_t], saia_mm=[skirt_t, skirt_drop], curso_mm=travel);
echo(trilho_mm=[rail_depth, rail_h], piso_trilho_z=rail_z, engate_por_lado_mm=tongue_d,
     folga_por_lado_mm=rail_clear, funil_entrada_mm=[flare_len, flare_drop],
     chanfro_pe_de_elefante_da_tampa_mm=ef_cham);
echo(snap_saliencia_mm=[bump_len, bump_h], snap_x_mm=bump_x,
     lingueta_mm=[beam_w, beam_root_x-beam_tip_x, lid_t], braco_util_mm=beam_len,
     flexao_exigida_mm=snap_flex, alivio_de_teto_mm=relief_h,
     rigidez_N_por_mm=beam_k, forca_por_lado_N=snap_force, forca_total_N=2*snap_force);
echo(bolso_abertura_mm=pocket_len, saliencia_base_mm=bump_len,
     folga_longitudinal_por_lado_mm=(pocket_len-bump_len)/2,
     folga_em_Y_mm=snap_clear, chapa_sobre_o_bolso_mm=pocket_roof,
     faixa_na_frente_do_rasgo_mm=lead_strip);
echo(apoio_central="2 divisorias em X, de parede a parede, 0.4 mm sob a tampa",
     maior_vao_sem_apoio_mm=cell_d, vao_sem_apoio_central_mm=inner_d,
     chanfro_topo_divisoria_mm=div_cham);
echo(bits=bit_count, matriz=[bit_cols, bit_rows], furo_entre_faces_mm=bit_hole_af,
     furo_circunscrito_mm=bit_hole_d, profundidade_mm=bit_depth, sobra_do_bit_mm=bit_out,
     ar_entre_bits_mm=bit_air, passo_mm=bit_pitch, funil_mm=bit_lead,
     bloco_mm=[cell_w, bit_block_d, bit_block_h], canaleta_que_sobra_na_celula_mm=bit_rest_d,
     coluna=bit_col, abertura_para_descobrir_a_matriz_mm=col_x0(bit_col)+cell_w-wall_x);
echo(escalopo_de_dedo=[sc_n, sc_w, sc_z1-sc_z0, sc_depth], parede_restante_mm=wall_x-sc_depth,
     recuo_da_ponta_da_saia_mm=skirt_taper);
echo(chapa_caixa_mm=plate_box_fp, chapa_tampa_mm=plate_lid_fp, chapa_cupom_mm=plate_coupon_fp,
     mouse_ears=[ear_d, ear_h, ear_inset]);

// ---------------------------------------------------------------------
// Colmeia em baixo relevo (identidade do repo, hexagono ponta-pra-cima)
// ---------------------------------------------------------------------
module pointy_hex(r) {
  polygon([for (a=[0:60:300]) [r*cos(a+30), r*sin(a+30)]]);
}

// Campo 2D centrado no painel w x h, com faixa solida `m` em toda a volta.
// So emite a celula que couber INTEIRA dentro da faixa: nada de meia-celula
// na borda (regra 4 do CLAUDE.md - fragmento fino lasca na impressao).
module hex_field(w, h, m, r, web) {
  hx = sqrt(3)*r + web;
  hy = 1.5*r + web*sqrt(3)/2;
  halfw = sqrt(3)*r/2;
  uw = w - 2*m;
  uh = h - 2*m;
  nx = floor((uw - 2*halfw)/hx) + 1;
  ny = floor((uh - 2*r)/hy) + 1;
  ox = (uw - ((nx-1)*hx + 2*halfw))/2;
  oy = (uh - ((ny-1)*hy + 2*r))/2;
  if (nx >= 1 && ny >= 1)
    for (j=[0:ny-1], i=[0:nx-1]) {
      cx = m + ox + halfw + i*hx + (j%2 ? hx/2 : 0);
      cy = m + oy + r + j*hy;
      if (cx + halfw <= w - m && cy + r <= h - m)
        translate([cx, cy]) pointy_hex(r);
    }
}

// Painel na face y=0, escavando para +y.
module hex_panel_front(w, z0, z1, r, web, m) {
  translate([0, hex_relief+0.01, z0])
    rotate([90, 0, 0])
      linear_extrude(height = hex_relief + 0.02)
        hex_field(w, z1-z0, m, r, web);
}

// Painel na face x=0, escavando para +x.
module hex_panel_left(d, z0, z1, r, web, m) {
  translate([-0.01, 0, z0])
    rotate([90, 0, 90])
      linear_extrude(height = hex_relief + 0.02)
        hex_field(d, z1-z0, m, r, web);
}

module hex_walls() {
  hex_panel_front(box_w, hex_z0, hex_z1, hex_r, hex_web, hex_margin);
  translate([0, box_d, 0]) mirror([0,1,0])
    hex_panel_front(box_w, hex_z0, hex_z1, hex_r, hex_web, hex_margin);
  hex_panel_left(box_d, hex_z0, hex_z1, hex_r, hex_web, hex_margin);
  translate([box_w, 0, 0]) mirror([1,0,0])
    hex_panel_left(box_d, hex_z0, hex_z1, hex_r, hex_web, hex_margin);
}

// ---------------------------------------------------------------------
// Trilho: rasgo com teto a 45 graus, funil de entrada, alivio local e
// saliencia do snap
// ---------------------------------------------------------------------
// Perfil (y,z) do rasgo. O teto desce 1:1 para dentro da parede: nenhuma
// face voltada para baixo passa de 45 graus, entao a caixa imprime em pe
// sem uma unica ponte. `up` levanta o teto (alivio local sobre a saliencia).
module rail_profile_2d(up = 0) {
  polygon([[wall_y,              rail_z],
           [wall_y - rail_depth, rail_z],
           [wall_y - rail_depth, rail_z + rail_h - rail_depth + up],
           [wall_y,              rail_z + rail_h + up]]);
}

module rail_cut_front(xend) {
  translate([wall_x, 0, 0])
    rotate([90, 0, 90])
      linear_extrude(height = xend - wall_x + 1)
        rail_profile_2d();
  // Alivio LOCAL do teto sobre a saliencia: e o que da curso para a lingueta
  // fletir os 0.3 mm. Sem ele a lingueta bate no teto antes de vencer o snap.
  translate([relief_x0, 0, 0])
    rotate([90, 0, 90])
      linear_extrude(height = relief_x1 - relief_x0)
        rail_profile_2d(relief_h);
  // Funil de entrada na boca: o piso do trilho cai flare_drop nos ultimos
  // flare_len mm, para a lingueta empenada achar o rasgo sem raspar.
  translate([0, wall_y, 0])
    rotate([90, 0, 0])
      linear_extrude(height = rail_depth)
        polygon([[xend - flare_len, rail_z],
                 [xend + 1,         rail_z],
                 [xend + 1,         rail_z - flare_drop]]);
}

module rail_cuts(W, D) {
  rail_cut_front(W);
  translate([0, D, 0]) mirror([0,1,0]) rail_cut_front(W);
}

module bump_profile_2d() {
  polygon([[bump_x - bump_len/2,          rail_z],
           [bump_x + bump_len/2,          rail_z],
           [bump_x + bump_len/2 - bump_h, rail_z + bump_h],
           [bump_x - bump_len/2 + bump_h, rail_z + bump_h]]);
}

module bump_front() {
  translate([0, wall_y - bump_y0, 0])
    rotate([90, 0, 0])
      linear_extrude(height = bump_y1 - bump_y0)
        bump_profile_2d();
}

module detent_bumps(D) {
  bump_front();
  translate([0, D, 0]) mirror([0,1,0]) bump_front();
}

// ---------------------------------------------------------------------
// Escalopo de dedo na parede da boca: sem ele a saia fica colada na parede
// (0.3 mm) e nao entra dedo nenhum atras dela.
// ---------------------------------------------------------------------
module mouth_scallops(W, D) {
  span = D - 2*wall_y;
  for (i = [0:sc_n-1]) {
    yc = wall_y + span*(i+0.5)/sc_n;
    if (yc - sc_w/2 > wall_y + 1 && yc + sc_w/2 < D - wall_y - 1)
      translate([W - sc_depth, yc - sc_w/2, sc_z0])
        cube([sc_depth + 0.01, sc_w, sc_z1 - sc_z0]);
  }
}

// ---------------------------------------------------------------------
// Layout interno
// ---------------------------------------------------------------------
// Cunha de 45 graus no topo da divisoria, na face virada para a boca (+X):
// o nariz da tampa entrando inclinado escorrega em vez de enganchar na
// aresta viva (o piso do funil passa a 67 um dela).
module div_top_chamfer(x_face, y0, dy) {
  translate([0, y0, 0])
    rotate([90, 0, 0])
      mirror([0, 0, 1])
        linear_extrude(height = dy)
          polygon([[x_face - div_cham, div_top + 0.1],
                   [x_face + 0.1,      div_top + 0.1],
                   [x_face + 0.1,      div_top - div_cham]]);
}

module dividers() {
  difference() {
    union() {
      // Duas travessas em X, de parede a parede: separam canaleta/grade e as
      // duas linhas da grade E servem de APOIO CENTRAL da tampa (topo 0.4 mm
      // abaixo dela). Sem elas o vao livre da tampa seria de 196 mm.
      for (i = [0:grid_rows-1])
        translate([wall_x, row_y0(i) - div_t, floor_t])
          cube([inner_w, div_t, div_h]);
      // Divisorias de coluna dentro de cada linha.
      for (i = [0:grid_rows-1], j = [1:grid_cols-1])
        translate([col_x0(j) - div_t, row_y0(i), floor_t])
          cube([div_t, cell_d, div_h]);
    }
    // Chanfro em toda aresta de topo virada para a boca.
    for (i = [0:grid_rows-1])
      div_top_chamfer(wall_x + inner_w, row_y0(i) - div_t, div_t);
    for (i = [0:grid_rows-1], j = [1:grid_cols-1])
      div_top_chamfer(col_x0(j), row_y0(i), cell_d);
  }
}

// Furo cego VERTICAL: nao ha teto a vencer, nao existe ponte reta. O
// hexagono sai ponta-pra-cima em planta (vertice em +Y), na identidade
// do repo, e ganha funil de 45 graus na boca para o bit entrar torto.
module hex_socket() {
  translate([0, 0, -0.05])
    linear_extrude(height = bit_depth + 0.15)
      pointy_hex(bit_hole_d/2);
  translate([0, 0, bit_depth - bit_lead])
    linear_extrude(height = bit_lead + 0.1,
                   scale = (bit_hole_d/2 + bit_lead)/(bit_hole_d/2))
      pointy_hex(bit_hole_d/2);
}

// O bloco tem a largura da celula (para nao deixar fresta) mas so a
// profundidade da matriz: sobra uma canaleta util no fundo da celula.
module bit_block() {
  x0 = col_x0(bit_col);
  y0 = row_y0(bit_row);
  ox = (bit_span_x - (bit_cols-1)*bit_pitch)/2;
  difference() {
    translate([x0, y0, floor_t]) cube([cell_w, bit_block_d, bit_block_h]);
    for (i = [0:bit_cols-1], j = [0:bit_rows-1])
      translate([x0 + bit_margin + bit_hole_d/2 + ox + i*bit_pitch,
                 y0 + bit_margin + bit_hole_d/2 + j*bit_pitch,
                 floor_t + bit_base])
        hex_socket();
  }
}

// ---------------------------------------------------------------------
// Caixa
// ---------------------------------------------------------------------
module box_body(W, D, z0, with_hex) {
  union() {
    difference() {
      translate([0, 0, z0]) cube([W, D, box_h - z0]);
      // Cavidade interna, aberta em cima (e por onde a tampa corre).
      translate([wall_x, wall_y, z0 + floor_t]) cube([W - 2*wall_x, D - 2*wall_y, box_h]);
      // Parede da BOCA rebaixada: a tampa passa por cima dela, e ela continua
      // fechando os compartimentos ate 0.4 mm da face de baixo da tampa.
      translate([W - wall_x - 0.01, wall_y, mouth_top])
        cube([wall_x + 1.01, D - 2*wall_y, box_h]);
      rail_cuts(W, D);
      mouth_scallops(W, D);
      if (with_hex) hex_walls();
    }
    detent_bumps(D);
  }
}

module box() {
  union() {
    box_body(box_w, box_d, 0, true);
    dividers();
    bit_block();
  }
}

module coupon_box() { box_body(coupon_w, coupon_d, coupon_z0, false); }

// ---------------------------------------------------------------------
// Tampa
// ---------------------------------------------------------------------
// Bolso do snap. O poligono desce VERTICAL abaixo do plano da face de baixo
// (nada de offset em rampa): a abertura util no plano do piso e exatamente
// bump_len + 2*snap_clear, e nao 0.11 mm menor por lado como na v1.
module snap_pocket_front() {
  translate([0, wall_y - bump_y0 + snap_clear, 0])
    rotate([90, 0, 0])
      linear_extrude(height = (wall_y - bump_y0 + snap_clear) - (lid_y0 - 1))
        polygon([[bump_x - pocket_len/2,            rail_z - 0.6],
                 [bump_x + pocket_len/2,            rail_z - 0.6],
                 [bump_x + pocket_len/2,            rail_z],
                 [bump_x + pocket_len/2 - pocket_h, rail_z + pocket_h],
                 [bump_x - pocket_len/2 + pocket_h, rail_z + pocket_h],
                 [bump_x - pocket_len/2,            rail_z]]);
}

// Rasgo em U que transforma a beirada da tampa em LINGUETA FLEXIVEL de
// beam_w x (beam_root_x - beam_tip_x), com o bolso na ponta. E o membro
// elastico do snap: sem ele nao ha clique nem retencao, so uma quina viva
// que se aplaina na primeira montagem.
module snap_slot_front() {
  // rasgo longitudinal, do lado de dentro da lingueta
  translate([slot_x0, beam_y1, rail_z - 1])
    cube([beam_root_x - slot_x0, slot_w, lid_t + 2]);
  // rasgo transversal, liberando a ponta
  translate([slot_x0, lid_y0 - 1, rail_z - 1])
    cube([slot_w, beam_y1 + slot_w - (lid_y0 - 1), lid_t + 2]);
}

module snap_features(D) {
  snap_pocket_front();
  snap_slot_front();
  translate([0, D, 0]) mirror([0,1,0]) { snap_pocket_front(); snap_slot_front(); }
}

// Chanfro anti pe de elefante no perimetro da face de cima da tampa - que e
// a face que vai NA CAMA. As duas arestas longas sao as pontas das linguetas
// do trilho: sem este chanfro a folga em Y cai de 0.70 para ~0.40 por lado.
module lid_ef_chamfer(x0, x1, y0, y1) {
  zt = rail_z + lid_t;
  // arestas em Y (as criticas)
  for (s = [0, 1])
    translate([x0 - 1, s ? y1 : y0, 0])
      rotate([0, 90, 0])
        rotate([0, 0, s ? 90 : 0])
          linear_extrude(height = x1 - x0 + 2)
            polygon([[zt + 0.1, -0.1], [zt - ef_cham, -0.1], [zt + 0.1, ef_cham]]);
  // arestas em X
  for (s = [0, 1])
    translate([s ? x1 : x0, y0 - 1, 0])
      rotate([0, 90, 0])
        rotate([0, 0, s ? -90 : 180])
          rotate([90, 0, 0])
            linear_extrude(height = y1 - y0 + 2)
              polygon([[zt + 0.1, 0.1], [zt - ef_cham, 0.1], [zt + 0.1, -ef_cham]]);
}

module lid(W = undef, D = undef) {
  Wx = is_undef(W) ? box_w : W;
  Dy = is_undef(D) ? box_d : D;
  x0 = lid_x0;
  sx = Wx + skirt_gap;
  x1 = sx + skirt_t;
  y0 = lid_y0;
  yw = Dy - 2*lid_y0;
  difference() {
    union() {
      translate([x0, y0, rail_z]) cube([x1 - x0, yw, lid_t]);
      // Saia/puxador: desce por fora da parede da boca. A ponta dela recua
      // skirt_taper para dentro, abrindo cunha para o dedo entrar.
      translate([0, y0, 0])
        rotate([90, 0, 0])
          mirror([0, 0, 1])
            linear_extrude(height = yw)
              polygon([[sx,               rail_z],
                       [x1,               rail_z],
                       [x1,               skirt_z0],
                       [sx + skirt_taper, skirt_z0],
                       [sx,               skirt_z0 + skirt_tap_h]]);
    }
    snap_features(Dy);
    // Chanfro de 45 graus nas duas quinas de ataque (planta): a tampa acha
    // os dois rasgos mesmo entrando torta.
    translate([x0, y0, rail_z - 1])
      linear_extrude(height = lid_t + 2)
        polygon([[-0.1, -0.1], [lead_cham, -0.1], [-0.1, lead_cham]]);
    translate([x0, y0 + yw, rail_z - 1])
      linear_extrude(height = lid_t + 2)
        polygon([[-0.1, 0.1], [lead_cham, 0.1], [-0.1, -lead_cham]]);
    // Chanfro na face de BAIXO da aresta de ataque: e a rampa que sobe na
    // saliencia do snap sem bater de quina viva.
    translate([0, y0 - 1, 0])
      rotate([90, 0, 0])
        mirror([0, 0, 1])
          linear_extrude(height = yw + 2)
            polygon([[x0 - 0.1, rail_z - 0.1],
                     [x0 + 1.2, rail_z - 0.1],
                     [x0 - 0.1, rail_z + 1.2]]);
    lid_ef_chamfer(x0, x1, y0, y0 + yw);
    // Colmeia antiderrapante na face externa da saia.
    translate([x1, y0, 0]) mirror([1,0,0])
      translate([-0.01, 0, skirt_z0])
        rotate([90, 0, 90])
          linear_extrude(height = hex_relief + 0.02)
            hex_field(yw, rail_z + lid_t - skirt_z0, 1.5, 3.0, 2.0);
  }
}

module coupon_lid() { lid(coupon_w, coupon_d); }

// ---------------------------------------------------------------------
// Montagem, chapas e verificacoes
// ---------------------------------------------------------------------
module lid_at(s = 0, dz = 0) { translate([s, 0, dz]) lid(); }
module assembly() { box(); lid_at(slide, lift); }
module collision() { intersection() { box(); lid_at(slide, lift); } }
// Tentativa de abrir 2 mm sem levantar: tem que dar intersecao NAO vazia
// (a rampa do bolso batendo na saliencia) - e a prova de que o snap retem.
module retention_test() { intersection() { box(); lid_at(2.0, 0); } }
// Tentativa de levantar a tampa 0.8 mm dentro do trilho: tem que bater no
// teto a 45 graus - prova de que a tampa esta capturada.
module lift_test() { intersection() { box(); lid_at(0, 0.8); } }

// Prova de que a lingueta TEM PARA ONDE FLETIR: dentro da janela de alivio,
// levantar a tampa a altura inteira da saliencia (bump_h) nao pode encostar
// no teto. Intersecao vazia = o cantilever tem curso.
module relief_test() {
  intersection() {
    box();
    translate([0, 0, bump_h]) lid();
    translate([relief_x0, -1, -1])
      cube([relief_x1 - relief_x0, box_d + 2, box_h + 2]);
  }
}

// Corte de verificacao: fatia de 1 mm no plano do trilho da frente.
section_y = 4.0; // mm; y do corte de verificacao.
module section() {
  intersection() {
    union() { box(); lid_at(slide, lift); }
    translate([-2, section_y-0.5, -2]) cube([box_w+40, 1.0, box_h+4]);
  }
}

// Mouse ears: substituem o brim, que nao cabe nos 210 de alvo.
module mouse_ears(x0, x1, y0, y1) {
  for (px = [x0 + ear_inset, x1 - ear_inset], py = [y0 + ear_inset, y1 - ear_inset])
    translate([px, py, 0]) cylinder(h = ear_h, d = ear_d);
}

module plate_box() {
  box();
  mouse_ears(0, box_w, 0, box_d);
}

// Tampa DE CABECA PARA BAIXO: face de cima na cama (primeira camada cheia),
// saia apontando para cima, bolsos do snap em face voltada para cima.
module plate_lid() {
  translate([0, box_d, rail_z + lid_t]) rotate([180, 0, 0]) lid();
  mouse_ears(lid_x0, lid_x1, lid_y0, lid_y0 + lid_w);
}

// Cupom: mesma secao de trilho, funil, snap, escalopo e lingueta, em 60x60.
module plate_coupon() {
  translate([0, 0, -coupon_z0]) coupon_box();
  translate([coupon_w + coupon_gap - lid_x0, coupon_d, rail_z + lid_t])
    rotate([180, 0, 0]) coupon_lid();
}

if      (part == "box")          box();
else if (part == "lid")          lid();
else if (part == "plate_box")    plate_box();
else if (part == "plate_lid")    plate_lid();
else if (part == "plate_coupon") plate_coupon();
else if (part == "coupon_box")   coupon_box();
else if (part == "coupon_lid")   coupon_lid();
else if (part == "assembly")     assembly();
else if (part == "collision")    collision();
else if (part == "retention")    retention_test();
else if (part == "lift")         lift_test();
else if (part == "relief")       relief_test();
else if (part == "section")      section();
else assert(false, str("part desconhecida: ", part));
