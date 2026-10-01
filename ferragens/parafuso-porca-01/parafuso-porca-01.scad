/*
  parafuso-porca-01

  JOGO DE 4 PARAFUSOS COM PORCA, impressos em FDM (PLA/PETG) na AD5X.
  Rosca metrica ISO (perfil em V de 60 graus), Ø3.7 nominal x 14 mm de rosca
  TOTAL (a rosca nasce colada na cabeca e vai ate a ponta, sem haste lisa),
  cabeca CHATA cilindrica de Ø7.4 x 2.0 com serrilha de dedo, e porca
  sextavada engrossada para FDM.

  APERTO SO DE DEDO - NAO EXISTE FERRAMENTA NESTA PECA:
  O parafuso NAO tem fenda de chave de fenda, e a ausencia dela e uma decisao
  de projeto, nao um esquecimento. O nucleo deste parafuso rompe entre 25 e
  55 N.mm (ver LIMITE FISICO). Uma chave de fenda pequena entrega 300 a
  1000 N.mm com a mao de qualquer pessoa - ou seja, QUALQUER uso de chave de
  fenda aqui torce a haste fora, e uma fenda no topo seria um convite
  desenhado na peca para destruir a peca. O acionamento unico e a SERRILHA da
  borda: o dedo nela entrega 20 a 30 N.mm num aperto normal, que e o unico
  patamar dentro do envelope. (A fenda tambem partia a primeira camada em
  duas meias-luas de 13.5 mm2 que so se uniam 5 camadas acima; tirando ela, a
  primeira camada volta a ser um disco inteiro - o ECHO da a area exata.)

  COMO O USUARIO MANUSEIA (mundo fisico):
  - O parafuso e um THUMBSCREW: aperta-se com a ponta dos dedos na serrilha
    da borda da cabeca (12 canais de 0.45 mm de profundidade, com 0.63 mm de
    material solido entre eles - nao sao fios de faca que descascam na mao).
    Aperta-se ATE ENCOSTAR, e para; nao existe "dar mais uma".
  - A cabeca e CHATA: assenta EM CIMA da superficie, nao e escareada - o furo
    da peca a ser presa e um furo passante RETO de ~4.4 mm, nao um cone. (4.4
    e nao 4.2: a crista impressa sai em ~3.80-3.85 por droop de flanco e
    superextrusao, e com 4.2 sobrariam so 0.17 mm de cada lado.)
  - A porca sextavada de 9.0 mm entre faces gira com os dedos. A chave de
    boca 9 (a mesma de M5/M6 comercial) serve para SEGURAR a porca, NUNCA
    para dar torque - ela e alavanca suficiente para romper o parafuso.
    A porca tem chanfro nas duas faces e funil de entrada nas duas bocas do
    furo: entra por qualquer lado, nao tem "lado certo".
  - A ponta do parafuso tem chanfro de 45 graus que apaga a rosca ate o
    diametro do nucleo: a porca cata a rosca sozinha em vez de espanar a
    primeira volta (que e sempre a mais fragil numa peca impressa).
  - ESPESSURA MAXIMA DE APERTO = thread_len - nut_h = 9.0 mm. Acima disso a
    porca nao acha rosca sobrando para engatar inteira.

  LIMITE FISICO - LEIA ANTES DE APERTAR:
  Este e um parafuso IMPRESSO de Ø3.7. O elo fraco nao e a rosca, e o NUCLEO.
  Com passo 1.25 o nucleo tem Ø2.35 (area 4.33 mm2) e modulo de torcao polar
  2.54 mm3. A ~25 MPa de resistencia INTERCAMADAS do PLA:
    - torcao PURA, sem mais nada:                        ~63 N.mm
    - somando a tracao da pre-carga de aperto (von Mises
      com F ~ T/(K*d), K~0.25 -> equivalente 0.7266*T):  ~46 N.mm
    - somando o ENTALHE da raiz do filete (chato de p/4
      com canto vivo, Kt ~2-3):                          20-27 N.mm
  FAIXA DE TRABALHO: 25 a 55 N.mm - envelope arredondado para o passo default
  e para a incerteza do numero de 25 MPa; o ECHO recalcula os tres patamares
  para qualquer passo que se escolha. Compare com os 20-30 N.mm que o dedo na
  serrilha entrega e veja que o aperto de dedo FIRME ja flerta com o limite
  de baixo - por isso: aperte ate encostar e pare, sem alavanca de especie
  nenhuma. A area de cisalhamento da rosca ENGATADA na porca (3.04 voltas
  uteis, 16.4 mm2) e 3.8x a area do nucleo, entao o parafuso TORCE antes de a
  rosca espanar - o que e o modo de falha desejado (a porca sobrevive).
  Para servico estrutural de verdade: parafuso de metal.

  POR QUE PASSO 1.25 E NAO OS 1.5 PEDIDOS:
  A rosca come o nucleo pelos dois lados: d_nucleo = 3.7 - 1.0825 * passo.
    passo 1.5  -> nucleo Ø2.08 (torcao relativa 1.00) - 7.5 camadas/passo
    passo 1.25 -> nucleo Ø2.35 (torcao relativa 1.44) - 6.2 camadas/passo
    passo 1.00 -> nucleo Ø2.62 (torcao relativa 2.00) - 5.0 camadas/passo
  Em Ø3.7 o passo 1.5 e absurdamente grosso (e o passo de um M10 comercial) e
  sobra um nucleo de 2 mm que torce no dedo. Descer para 1.25 devolve 44% de
  torcao SEM cair abaixo de 6 camadas por passo na camada padrao de 0.2 mm da
  AD5X - abaixo disso o flanco de 60 graus vira escada e a crista arredonda.
  O dente ainda tem 0.68 mm de altura radial (~1.6 larguras de extrusao no
  bico 0.4), ou seja, e um dente que o fatiador consegue traçar de verdade.
  Passo e parametro: `thread_pitch = 1.5` reproduz o pedido original e
  `thread_pitch = 1.0` maximiza o nucleo - tudo o mais se recalcula sozinho.

  FOLGA DE ROSCA (thread_clearance = 0.4 mm NO DIAMETRO = 0.2/lado):
  Rosca nao segue a regra de deslize do CLAUDE.md (0.5/lado) nem a de peca
  solta (0.3/lado) - aquelas sao para um encaixe deslizante longo, onde o
  inimigo e o empeno. Aqui o encaixe e helicoidal e curto (5 mm de porca) e
  folga demais vira folga ANGULAR: a porca chacoalha e o dente perde area.
  0.2 mm por lado e o que sobra depois de somar o que o FDM tira de um furo
  vertical (~0.1 mm de subdimensionamento) com a ondulacao da parede (~0.05)
  e a resolucao em Z do flanco (0.2 de camada -> ~0.06 radial no flanco de
  30 graus). Sobra 0.48 mm de engate radial dos 0.68 mm de dente - 70% do
  dente ainda pega. A fêmea e cortada com o MESMO perfil do macho deslocado
  de +0.2 no raio, entao a folga aparece nos dois lugares certos: 0.2 radial
  na crista/raiz e 0.12 axial em cada flanco (0.2 * tan 30).

  POR QUE ESPERAR QUE A PORCA ENTRE DURA NA PRIMEIRA TENTATIVA:
  As DUAS pecas tem o perfil da rosca deitado em XY, e e isso que torna o
  caso ruim: o macho e um contorno CONVEXO (sai SUPERdimensionado - pe de
  elefante, superextrusao, droop de flanco) e a femea e um contorno CONCAVO
  (sai SUBdimensionado - o classico "furo impresso sai menor"). Os dois erros
  andam no MESMO sentido de fechar a folga: eles SOMAM, e juntos podem comer
  os 0.2 mm/lado inteiros. Previsao honesta: a porca entra dura no primeiro
  jogo. A cadeia perigosa que sai dai e "porca dura -> forcar -> torque ->
  nucleo quebrado", que e exatamente o modo de falha do paragrafo acima.
  Por isso: 0.4 e o default do modelo, mas o PRIMEIRO CUPOM deve ser rodado
  em thread_clearance = 0.5 (63% de dente, ainda passa todos os asserts). Se
  em 0.5 chacoalhar demais, descer para 0.4 e depois 0.3 - abaixo de 0.3
  emperra. E IMPRIMIR O CUPOM antes de gastar o jogo inteiro
  (3mf/parafuso-porca-01-cupom.3mf).

  ORIENTACAO DE IMPRESSAO (parafuso EM PE, CABECA NA CAMA, ponta pra cima):
  - Em pe a rosca sai como um contorno fechado por camada: crista redonda,
    flanco continuo, ZERO suporte. Deitado, a rosca vira uma sequencia de
    balancos que o fatiador esmaga e a cabeca fica com um lado achatado.
  - A cabeca vai NA CAMA porque a alternativa (ponta na cama) apoiaria uma
    torre de 16 mm num pe de Ø2.3 - tomba no primeiro contato do bico.
  - Consequencia aceita: o torque carrega as camadas ao cisalhamento (ver
    LIMITE FISICO). Nao existe orientacao que resolva isso num parafuso
    impresso; existe imprimir com mais perimetros e mais temperatura.
  - Com a fenda removida, a face que encosta na cama e um DISCO INTEIRO (a
    serrilha morde um pouco da borda; o ECHO da a area exata). Nao ha ponte,
    nao ha ilha, nao ha nada acontecendo na primeira camada.
  - A porca imprime DEITADA, furo em Z: as duas faces saem planas e a rosca
    interna nasce como furo redondo por camada. O flanco de baixo da rosca
    interna e um balanco de 60 graus DA VERTICAL, o que e muito alem dos 45
    de regra - e ele funciona, mas NAO por "cada camada apoiar na anterior
    deslocada de 0.2 mm". Isso esta errado: no MESMO angulo, de uma camada
    para a de baixo o raio anda dr/dz * 0.2 = 1.732 * 0.2 = 0.347 mm contra
    0.42 mm de largura de cordao, ou seja o cordao novo pousa com 17% de
    sobreposicao no de baixo - quase em falso. O que salva e o VAO SER
    CURTO: o flanco tem 5p/16 = 0.39 mm de percurso axial, isto e DUAS
    camadas de balanco antes de a geometria virar para a raiz e reencostar.
    Dois cordaos meio pendurados nao caem; vinte cairiam. Por isso porca
    impressa sai sem suporte e porca com passo grosso demais nao sairia.
  - Chanfro de 0.7 nas duas faces da porca e de 0.3 na aresta da cabeca que
    fica na cama: matam o pe de elefante nas arestas que o dedo pega. Na
    porca o funil de 0.6 nas duas bocas apaga justamente as voltas que o pe
    de elefante ataca; a rosca do macho nasce em z = 2.0, ja fora da zona.

  SEM SUPORTE em nenhuma peca. Fatiamento: 0.2 mm de camada, 3+ perimetros,
  100% de preenchimento (as pecas sao pequenas, o solido sai de graca),
  BRIM OBRIGATORIO (nao "se descolar": a cabeca apoia ~35 mm2 para 16 mm de
  altura, e quando se descobre que descolou a peca ja foi) e - o ajuste que
  mais importa para a rosca - MIN LAYER TIME >= 8-10 s com VENTOINHA 100%.
  Acima de z = 5 sobram so as 4 hastes, ~11 mm2 de secao somada, o que da
  ~2.6 s por camada a 40 mm/s: sem freio de camada a crista sai quente,
  incha, e a folga de 0.2/lado desaparece.

  EXPORT CANONICO (caminhos absolutos - o flatpak nao enxerga /tmp):
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/stl/parafuso-porca-01-parafuso.stl -D 'part="screw"' /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/parafuso-porca-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/stl/parafuso-porca-01-porca.stl    -D 'part="nut"'   /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/parafuso-porca-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/3mf/parafuso-porca-01-plate.3mf    -D 'part="plate"'  /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/parafuso-porca-01.scad
    flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/3mf/parafuso-porca-01-cupom.3mf    -D 'part="plate_coupon"' /home/afonsolelis/repos/3dmodels/ferragens/parafuso-porca-01/parafuso-porca-01.scad

  ATENCAO CLI: `-D nome_override=...` NAO funciona nesta versao (2021.01) -
  o -D entra no FIM do escopo e o is_undef() ja foi avaliado. Por linha de
  comando mirar sempre a variavel FINAL: -D thread_clearance=0.5,
  -D thread_pitch=1.0, -D part="screw". Os *_override existem so para o
  customizer da GUI e para include<>. Depois de exportar com -D, CONFERIR nos
  ECHO se o valor pegou.
*/

part = "screw"; // [screw,nut,plate,plate_coupon,assembly,section,coupon_screw,head_section]

/* [Rosca] */
thread_d       = 3.7;  // mm, diametro MAIOR (crista do macho) = diametro nominal
thread_pitch   = 1.25; // mm, passo axial de uma volta (1.5 = pedido original, 1.0 = nucleo maximo)
thread_len     = 14;   // mm, comprimento roscado do parafuso (rosca total, sem haste lisa)
thread_angle   = 60;   // graus, angulo incluso do V (ISO metrico = 60)
// folga NO DIAMETRO entre macho e femea (metade dela por lado). Ver o bloco
// FOLGA DE ROSCA do cabecalho: 0.4 = 0.2/lado, deixa 70% do dente engatado.
thread_clearance = is_undef(thread_clearance_override) ? 0.4 : thread_clearance_override; // mm
// tip_chamfer NAO e parametro: e derivado de thread_dep (ver Derivados). Era
// 0.68 fixo, uma constante magica casada com o passo 1.25 - com passo 1.0 o
// dente tem 0.54 e o assert do chanfro estourava, ou seja o header anunciava
// um passo que nao compilava.

/* [Cabeca chata] */
head_d        = 7.4;  // mm, diametro da cabeca
head_h        = 2.0;  // mm, altura da cabeca (assenta EM CIMA da peca, nao escareada)
head_chamfer  = 0.3;  // mm, chanfro 45 na aresta de topo (a que fica na cama)
// NAO EXISTE FENDA DE CHAVE DE FENDA - e deliberado. Ver o bloco APERTO SO DE
// DEDO do cabecalho: o nucleo rompe em 25-55 N.mm e uma chave de fenda entrega
// 300-1000 N.mm. Se alguem for reintroduzir a fenda, leia aquele bloco antes.

/* [Serrilha da cabeca] */
knurl_n       = 12;   // canais em volta da cabeca (12 deixa 0.63 mm de material entre eles)
knurl_d       = 1.4;  // mm, diametro do cilindro que escava cada canal
knurl_depth   = 0.45; // mm, profundidade radial do canal

/* [Porca sextavada] */
nut_af        = 9.0;  // mm, entre faces (chave 9; M4 de catalogo tem 7 - fino demais impresso)
nut_h         = 5.0   ;// mm, altura (M4 de catalogo tem 3.2; 5.0 = 4 voltas de engate)
nut_chamfer   = 0.7;  // mm, chanfro 45 nas duas faces (corta os 6 cantos ate ~o entre-faces)
nut_lead_in   = 0.6;  // mm, funil de 45 nas duas bocas do furo

/* [Chapa de impressao] */
plate_pitch_x = 30;   // mm, distancia entre centros na fileira (folgado: ajuda o resfriamento)
plate_pitch_y = 30;   // mm, distancia entre a fileira de parafusos e a de porcas
plate_n       = 4;    // pecas de cada tipo

/* [Cupom de teste de rosca] */
// rosca curta pra testar o encaixe antes do jogo todo. 10 e nao 6: com a
// porca de 5 mm, 6 de rosca davam 1 mm de curso - testava a ENTRADA, nao o
// CORRIMENTO, que e onde o empeno morde. 10 da 5 mm de curso e continua
// custando ~10 min de impressao.
coupon_thread_len = 10; // mm

/* [Qualidade] */
$fn          = 72;
thread_astep = 10; // graus entre pontos do perfil 2D (36 pontos por volta)
thread_slice = 10; // graus de torcao por fatia do linear_extrude (36 fatias por volta)
// astep x slice sao o custo no CGAL, e ele explode rapido: com 6/6 o parafuso
// sai com 81.5k triangulos e a chapa dos 8 com 438k, que faz o Flash Studio
// se arrastar para NADA - 10/10 custa 0.007 mm de erro de faceta no raio de
// 1.85 mm e amostra o perfil axial a cada 0.035 mm (a camada e 0.2), ou seja,
// esta 6x abaixo do que a impressora consegue enxergar, e derruba a chapa
// para ~165k triangulos. Nao vale descer de 10 achando que melhora a rosca.

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
H          = thread_pitch * sqrt(3) / 2;      // altura do triangulo teorico do V de 60
thread_dep = 5 * H / 8;                       // altura radial do dente do MACHO (ISO: 5H/8)
d_maj      = thread_d;                        // macho: crista
d_min      = thread_d - 2 * thread_dep;       // macho: nucleo (fundo do filete)
d_eff      = thread_d - 3 * H / 4;            // macho: diametro efetivo (de passo), ISO d2

D_maj      = d_maj + thread_clearance;        // femea: fundo do filete (o corte e o macho + folga)
D_min      = d_min + thread_clearance;        // femea: crista = MENOR furo da porca
D_eff      = d_eff + thread_clearance;        // femea: diametro efetivo
engage_r   = (d_maj - D_min) / 2;             // engate radial real do dente
clear_r    = thread_clearance / 2;            // folga radial
clear_ax   = clear_r * tan(thread_angle / 2); // folga axial em cada flanco

// chanfro de 45 da ponta = exatamente a altura do dente, entao a ponta acaba
// no diametro do nucleo qualquer que seja o passo (com 0.68 fixo, passo 1.0
// nao compilava). Derivado, nao parametro.
tip_chamfer = thread_dep;

R_maj      = d_maj / 2;
R_min      = d_min / 2;
lead       = thread_pitch;                    // 1 entrada: avanco por volta = passo
turns      = thread_len / thread_pitch;       // voltas de rosca do parafuso
core_area  = PI * pow(d_min / 2, 2);          // mm2, secao resistente do nucleo
core_wt    = PI * pow(d_min / 2, 3) / 2;      // mm3, modulo de torcao polar do nucleo
// TORQUE: tres patamares, do otimista ao honesto (ver LIMITE FISICO). O bruto
// e torcao pura; o com pre-carga soma a tracao do aperto por von Mises; o com
// entalhe divide pelo Kt do canto vivo da raiz do filete. A faixa de trabalho
// a citar e a do entalhe ao da pre-carga: ~25 a ~55 N.mm.
torque_pura = 25 * core_wt;                   // N.mm, torcao pura a 25 MPa intercamadas
torque_prec = 0.7266 * torque_pura;           // N.mm, com a pre-carga de aperto
torque_kt2  = torque_pura / 2;                // N.mm, com entalhe da raiz Kt=2
torque_kt3  = torque_pura / 3;                // N.mm, com entalhe da raiz Kt=3

screw_h    = head_h + thread_len;             // altura total do parafuso em pe
grip_max   = thread_len - nut_h;              // mm, ESPESSURA MAXIMA que da pra apertar
hole_rec   = 4.4;                             // mm, furo passante recomendado na peca a prender
nut_ac     = nut_af / cos(30);                // porca: entre cantos
knurl_r    = head_d / 2 + knurl_d / 2 - knurl_depth; // centro dos cilindros da serrilha
// material solido entre dois canais vizinhos, medido na superficie da cabeca
knurl_chord = 2 * sqrt(pow(knurl_d / 2, 2) - pow(knurl_r - head_d / 2, 2));
knurl_land  = PI * head_d / knurl_n - knurl_chord;
// ROSCADO UTIL DA PORCA: os dois funis de nut_lead_in comem rosca nas duas
// bocas, entao nut_h/passo MENTE (dava 4 voltas e 21.6 mm2, 24% inflado).
nut_thread_h = nut_h - 2 * nut_lead_in;
nut_turns    = nut_thread_h / thread_pitch;
// area de cisalhamento da rosca engatada (cilindro no diametro menor da
// femea, metade do passo de largura por volta)
shear_area  = PI * D_min * (thread_pitch / 2) * nut_turns;
// FOLGA ANGULAR: o backlash axial dos dois flancos convertido em giro livre,
// e a inclinacao que a porca aceita no parafuso. E geometria, nao defeito.
backlash_ax  = 2 * clear_ax;                  // mm de vai-e-vem axial
backlash_deg = 360 * backlash_ax / lead;      // graus de giro livre
nut_tilt_deg = atan(2 * clear_r / nut_h);     // graus de inclinacao da porca

// AREA DA PRIMEIRA CAMADA da cabeca (a face que encosta na cama). Sem a fenda
// ela voltou a ser um disco INTEIRO de raio head_d/2 - head_chamfer, mordido
// pelos knurl_n canais da serrilha (os cilindros da serrilha alcancam
// knurl_r - knurl_d/2 = 3.25 < 3.4, ou seja mordem de verdade). Integral
// numerica de 1/2 r(a)^2 da em 1 grau: honesto e barato.
function knurl_bound(a) =
    let (per = 360 / knurl_n,
         dd  = a - per * round(a / per),
         s   = knurl_r * sin(dd),
         rc  = knurl_d / 2)
    abs(s) >= rc ? 1e9 : knurl_r * cos(dd) - sqrt(rc * rc - s * s);
fl_r0   = head_d / 2 - head_chamfer;
fl_rs   = [for (i = [0 : 359]) min(fl_r0, knurl_bound(i))];
fl_area = 0.5 * (1 * PI / 180)
          * ([for (r = fl_rs) r * r] * [for (r = fl_rs) 1]);

// Envelope da chapa. Dois detalhes que fazem a conta errar se ignorados:
// (a) cylinder($fn=6) nasce com VERTICE em x=0, entao a porca mede
//     entre-CANTOS em X e entre-FACES em Y - o envelope nao e simetrico;
// (b) o meio-alcance da cabeca em Y NAO e head_d/2: a serrilha tem um canal
//     exatamente em 90 graus, entao o ponto mais alto da cabeca e a borda do
//     canal vizinho. Varrendo o contorno de 0.1 em 0.1 grau sai 3.6455 em vez
//     de 3.7, e e por isso que o bbox real do 3MF da 38.145 e nao 38.2.
head_y_half = max([for (i = [0 : 3599])
                   let (a = i * 0.1)
                   min(head_d / 2, knurl_bound(a)) * abs(sin(a))]);
plate_w    = (plate_n - 1) * plate_pitch_x + max(head_d, nut_ac);
plate_d    = plate_pitch_y + head_y_half + nut_af / 2;

// ---------------------------------------------------------------------
// Conferencia
// ---------------------------------------------------------------------
assert(thread_dep * 2 < thread_d * 0.8, "passo grosso demais: a rosca comeu o nucleo");
assert(D_min > 0, "folga de rosca invalida");
assert(knurl_land > 0.4, "serrilha sem material entre os canais (vira fio de faca)");
assert((nut_af - D_maj) / 2 >= 1.5, "parede da porca fina demais");
assert(tip_chamfer <= thread_dep + 0.05, "chanfro da ponta corta o nucleo");
assert(nut_thread_h > 2 * thread_pitch, "funis comeram a rosca da porca: menos de 2 voltas uteis");
assert(coupon_thread_len - nut_h >= 3, "cupom sem curso: a porca nao corre o suficiente pra testar");
assert(plate_w <= 210 && plate_d <= 210, "chapa estourou os 210 mm de conforto da AD5X");

echo(str("== ROSCA: passo ", thread_pitch, " mm, ", turns, " voltas em ",
         thread_len, " mm, 1 entrada, mao direita, V de ", thread_angle, " graus"));
echo(str("MACHO   maior(crista) ", d_maj, "  efetivo ", d_eff, "  menor(nucleo) ", d_min));
echo(str("FEMEA   maior(raiz)   ", D_maj, "  efetivo ", D_eff, "  menor(crista) ", D_min));
echo(str("altura do dente ", thread_dep, " mm; engate radial real ", engage_r,
         " mm (", 100 * engage_r / thread_dep, "% do dente)"));
echo(str("folga: ", thread_clearance, " no diametro = ", clear_r,
         " radial e ", clear_ax, " axial por flanco"));
echo(str("folga angular: backlash axial ", backlash_ax, " mm = ", backlash_deg,
         " graus de giro livre; a porca inclina ", nut_tilt_deg,
         " graus no parafuso (esperado, nao defeito)"));
echo(str("NUCLEO Ø", d_min, " -> area ", core_area, " mm2, Wt ", core_wt, " mm3"));
echo(str("TORQUE DE RUPTURA: torcao pura ", torque_pura,
         " N.mm | com pre-carga ", torque_prec,
         " | com entalhe Kt2-Kt3 ", torque_kt2, "-", torque_kt3,
         " -> patamar honesto entre ", torque_kt3, " e ", torque_prec,
         " N.mm (no passo default, arredondando a incerteza do material: 25 a 55)."));
echo("APERTO: dedo na serrilha entrega 20-30 N.mm, ou seja ja encosta no limite de baixo. SO DEDO, ate encostar e para. Chave de fenda (300-1000 N.mm) destroi - e por isso que nao ha fenda.");
echo(str("PORCA ", nut_af, " entre faces / ", nut_ac, " entre cantos x ", nut_h,
         " mm; roscado UTIL ", nut_thread_h, " mm (descontados 2 x ", nut_lead_in,
         " de funil) = ", nut_turns, " voltas, cisalhamento ", shear_area,
         " mm2 (", shear_area / core_area, "x a area do nucleo)"));
echo(str("PARAFUSO em pe ", screw_h, " mm; cabeca Ø", head_d, " x ", head_h,
         " SEM FENDA; serrilha ", knurl_n, " canais, material entre canais ",
         knurl_land, " mm; 1a camada ", fl_area, " mm2 (disco inteiro)"));
echo(str("APERTA no maximo ", grip_max, " mm de espessura (thread_len - nut_h); ",
         "furo passante recomendado na peca a prender Ø", hole_rec));
echo(str("CHAPA ", plate_n, " parafusos + ", plate_n, " porcas = ",
         plate_w, " x ", plate_d, " x ", screw_h, " mm"));
echo(str("camadas por passo a 0.2 mm: ", thread_pitch / 0.2));

// ---------------------------------------------------------------------
// Rosca: o corte HORIZONTAL de uma rosca de 1 entrada e um disco cujo raio
// varia com o angulo seguindo o perfil axial; girando esse disco enquanto
// sobe (linear_extrude twist) sai a helice de verdade. Uma volta de 360 no
// perfil 2D vale um passo axial, e o perfil ISO truncado se distribui assim
// (fracoes do passo): crista p/8, flanco 5p/16, raiz p/4, flanco 5p/16.
// Aqui a crista aparece partida ao meio nas duas pontas do intervalo, o que
// deixa a funcao periodica e continua (sem degrau radial no perfil).
//   0     .. 1/16  crista (metade)
//   1/16  .. 6/16  flanco descendo
//   6/16  .. 10/16 raiz
//   10/16 .. 15/16 flanco subindo
//   15/16 .. 1     crista (a outra metade)
// ---------------------------------------------------------------------
function thr_r(t, r_min, r_maj) =
      t <  1/16 ? r_maj
    : t <  6/16 ? r_maj - (r_maj - r_min) * (t -  1/16) / (5/16)
    : t < 10/16 ? r_min
    : t < 15/16 ? r_min + (r_maj - r_min) * (t - 10/16) / (5/16)
    :             r_maj;

module thread_profile_2d(r_min, r_maj) {
    n = round(360 / thread_astep);
    polygon([for (i = [0 : n - 1])
             let (a = i * 360 / n, r = thr_r(i / n, r_min, r_maj))
             [r * cos(a), r * sin(a)]]);
}

// Haste roscada MACICA (o disco ja inclui o nucleo, nao precisa de union).
// Torcao negativa = o filete anda no sentido anti-horario visto de cima
// conforme sobe = rosca de MAO DIREITA (aperta girando no sentido horario).
module thread_rod(r_min, r_maj, h) {
    tw = -360 * h / lead;
    linear_extrude(height = h, twist = tw,
                   slices = max(2, ceil(abs(tw) / thread_slice)), convexity = 10)
        thread_profile_2d(r_min, r_maj);
}

// O MESMO campo helicoidal global, recortado a partir de z0. O rotate
// compensa a fase que o translate introduz (cada mm de subida gira o perfil
// 360/passo graus): assim macho e femea modelados em z diferentes ENGRENAM
// de verdade, sem precisar catar a fase na mao.
module thread_field(z0, h, r_min, r_maj) {
    translate([0, 0, z0]) rotate([0, 0, 360 * z0 / lead])
        thread_rod(r_min, r_maj, h);
}

// ---------------------------------------------------------------------
// Parafuso - modelado JA na orientacao de impressao:
// cabeca em z = 0..head_h (fenda virada pra cama), rosca subindo dai.
// ---------------------------------------------------------------------
module head() {
    difference() {
        union() {
            // chanfro de 45 na aresta que encosta na cama (mata o pe de elefante)
            cylinder(h = head_chamfer, d1 = head_d - 2 * head_chamfer, d2 = head_d);
            translate([0, 0, head_chamfer])
                cylinder(h = head_h - head_chamfer, d = head_d);
        }
        // serrilha: canais cilindricos verticais em volta
        for (i = [0 : knurl_n - 1])
            rotate([0, 0, i * 360 / knurl_n])
                translate([knurl_r, 0, -0.1])
                    cylinder(h = head_h + 0.2, d = knurl_d);
        // (nao ha corte de fenda aqui, e nao deve haver - ver o bloco
        //  APERTO SO DE DEDO no cabecalho)
    }
}

// Solido que corta o chanfro de 45 da ponta: cilindro folgado ate o comeco
// do chanfro e cone dai pra cima. O +0.2 no diametro do cone evita face
// coincidente com a crista da rosca sem mudar o angulo de 45.
module tip_solid(h) {
    c = tip_chamfer + 0.1;
    union() {
        cylinder(h = h - c, d = d_maj + 2);
        translate([0, 0, h - c])
            cylinder(h = c, d1 = d_maj + 0.2, d2 = d_maj + 0.2 - 2 * c);
    }
}

module screw(t_len = undef) {
    L = is_undef(t_len) ? thread_len : t_len;
    head();
    intersection() {
        thread_field(head_h, L, R_min, R_maj);
        translate([0, 0, head_h]) tip_solid(L);
    }
}

// ---------------------------------------------------------------------
// Porca - modelada JA na orientacao de impressao: deitada, furo em Z.
// A femea e o MESMO perfil do macho com os raios somados da folga radial.
// ---------------------------------------------------------------------
module nut() {
    over = 1; // o corte comeca abaixo e termina acima da porca
    difference() {
        // prisma hexagonal com os cantos comidos por um chanfro de 45 nas
        // duas faces, do jeito de uma porca de verdade
        intersection() {
            cylinder(h = nut_h, d = nut_ac, $fn = 6);
            union() {
                cylinder(h = nut_chamfer, d1 = nut_ac - 2 * nut_chamfer, d2 = nut_ac);
                translate([0, 0, nut_chamfer])
                    cylinder(h = nut_h - 2 * nut_chamfer, d = nut_ac);
                translate([0, 0, nut_h - nut_chamfer])
                    cylinder(h = nut_chamfer, d1 = nut_ac, d2 = nut_ac - 2 * nut_chamfer);
            }
        }
        // rosca interna (mesmo campo helicoidal global do macho + folga)
        thread_field(-over, nut_h + 2 * over, R_min + clear_r, R_maj + clear_r);
        // funil de entrada nas duas bocas: a porca cata a rosca por qualquer lado
        translate([0, 0, -0.01])
            cylinder(h = nut_lead_in + 0.01,
                     d1 = D_min + 2 * nut_lead_in, d2 = D_min);
        translate([0, 0, nut_h - nut_lead_in])
            cylinder(h = nut_lead_in + 0.01,
                     d1 = D_min, d2 = D_min + 2 * nut_lead_in);
    }
}

// ---------------------------------------------------------------------
// Chapas de impressao
// ---------------------------------------------------------------------
module row(n, pitch) {
    for (i = [0 : n - 1]) translate([i * pitch, 0, 0]) children();
}

module plate() {
    row(plate_n, plate_pitch_x) screw();
    translate([0, plate_pitch_y, 0]) row(plate_n, plate_pitch_x) nut();
}

// Cupom: 1 parafuso de rosca curta + 1 porca, na MESMA orientacao de
// impressao do jogo grande. Serve pra medir a folga na mao (~10 min de
// impressao) antes de gastar o jogo inteiro.
module plate_coupon() {
    screw(coupon_thread_len);
    translate([plate_pitch_x / 2, 0, 0]) nut();
}

// ---------------------------------------------------------------------
// Vistas de conferencia (NAO sao jobs de impressao)
// ---------------------------------------------------------------------
// A porca sobe z_nut no parafuso; o rotate de 360*z/passo remonta a fase, o
// mesmo truque do thread_field. Se a rosca estiver certa, macho e femea
// encaixam sem interpenetrar.
module assembly(z_nut = undef) {
    zn = is_undef(z_nut) ? head_h + thread_len - nut_h - 1 : z_nut;
    screw();
    translate([0, 0, zn]) rotate([0, 0, 360 * zn / lead]) nut();
}

module section() {
    difference() {
        assembly();
        translate([-20, 0, -1]) cube([40, 20, screw_h + 2]);
    }
}

module coupon_screw() { screw(coupon_thread_len); }

// Corte da CABECA: confere que a cabeca e MACICA nos 2 mm (nenhuma fenda),
// o chanfro de 0.3 da aresta que fica na cama e a serrilha. Rosca curta so
// pra enquadrar.
module head_section() {
    difference() {
        screw(4);
        translate([0, -20, -1]) cube([20, 40, 20]);
    }
}

// ---------------------------------------------------------------------
if      (part == "screw")        screw();
else if (part == "nut")          nut();
else if (part == "plate")        plate();
else if (part == "plate_coupon") plate_coupon();
else if (part == "assembly")     assembly();
else if (part == "section")      section();
else if (part == "coupon_screw") coupon_screw();
else if (part == "head_section") head_section();
else assert(false, str("part desconhecida: ", part));
