// xbox-stand-01.scad
// Suporte de mesa pra controle de XBOX (Series X/S), versão MACIÇA — bloco
// baixo, liso, de TOPO ABAULADO, com DOIS berços em vale onde caem os dois
// punhos do controle. PEÇA ÚNICA, sem montagem, sem ferragem e SEM SUPORTE
// DE IMPRESSÃO.
//
// COMO O USUÁRIO MANUSEIA. O bloco fica deitado na mesa, com o lado
// comprido (170mm) na horizontal, de frente pra quem senta. O controle
// desce de cima: cada PUNHO cai num berço e a "ponte" de baixo do controle
// (a barra entre os punhos, onde ficam os gatilhos e o logo) passa POR CIMA
// do miolo de 84,6mm que separa os dois berços — o miolo nunca encosta no
// controle, ele só existe pra amarrar as duas metades da peça.
// O controle DESCE QUASE RETO. O vale é assimétrico (o ponto mais fundo fica
// 4,5mm pro lado do FUNDO da mesa), então no fim do curso o punho está
// encostado na parede de trás e o controle fica deitado pra trás — mas isso
// é o FIM do movimento, não é uma rampa que guia a entrada: na boca a parede
// da frente já está a 68° da horizontal e a do fundo a 77° (o perfil é
// CÔNCAVO — os 44°/59° que aparecem nos echos são ângulos de CORDA, média
// da boca até o prato, e não a inclinação de nenhuma parede real).
// Pra tirar, puxa pra cima; nas primeiras vezes convém segurar o suporte com
// a outra mão — o punho fica plugado contra TPU, que tem atrito ALTO, e o
// suporte pesa só ~68g (é leve, não é âncora).
// Não tem trava, não tem clipe e não tem nada que precise de força: é apoio
// de mesa, não é suporte de parede.
//
// TPU E 15% DE INFILL — ISSO É PARTE DO PROJETO, NÃO É PALPITE DE FATIADOR.
// "Maciço" aqui quer dizer FORMA sólida (bloco liso, sem aletas e sem
// colmeia), NÃO parede cheia. A maciez vem do fatiador:
//   - filamento TPU (95A) SECO, spool EXTERNO (não passar TPU pelo AMS lite);
//   - 15% de infill, gyroid;  - 2 paredes;  - 5 camadas de topo / 4 de fundo;
//   - retração 0.4-0.8mm a ~20mm/s, combing ("avoid crossing walls") LIGADO;
//   - SEM suporte;  - sem brim.
// As 5 CAMADAS DE TOPO são pela ABÓBADA: 52 x 162mm de superfície quase
// plana (queda total de 1,5mm em 52mm de vão) apoiada só em gyroid a 15% —
// é ali que mora o risco de pillowing. NÃO é pelo fundo do vale: a parte
// quase plana do fundo do vale mede ~17,6 x 15,3mm e assenta em 2,5mm de TPU
// MACIÇO (o piso), sem vazio nenhum pra cobrir.
// Em PLA a peça também imprime, mas aí ela é só um calço duro: o projeto
// inteiro (berço grande, sem trava, parede de trás curta) conta com o TPU
// deformar e ABRAÇAR o punho. Ver o README do modelo.
//
// DE ONDE VIERAM OS NÚMEROS (licença!). O conceito é o
// ../../diversos/Xbox_Controller_Stand_lines_by_Pork3D.3mf (autor Pork3D,
// Standard Digital File License — NÃO redistribuível, e é por essa família
// de licenças que este repo é privado). Daquele arquivo NADA foi copiado,
// importado ou convertido: saíram só NÚMEROS DE REFERÊNCIA medidos na malha
// (bloco 170x50x25, berços a ±62 do meio, boca do bolso ~42x36 no topo,
// mergulho de ~24mm com o fundo deslocado ~4,5mm da linha do meio, o vão da
// seção a cada 2mm de altura E O CENTRO DA SEÇÃO A CADA 4mm DE ALTURA).
// Toda a geometria aqui é remodelada do zero em OpenSCAD, no mesmo
// precedente do bgs-stand-01.
// O original é VAZADO por aletas verticais paralelas ("lines"); este é o
// oposto: bloco maciço e liso, mesma função.
//
// ------------------------------------------------------------------------
// 4ª RODADA: ZERO MUDANÇA DE GEOMETRIA (o print-review APROVOU a 3ª)
// ------------------------------------------------------------------------
// Nenhuma cota, lei, parâmetro ou construção mudou — a malha exportada é
// vértice por vértice a mesma. O que mudou foi TEXTO E NÚMERO DECLARADO:
// 1. ERRO DE FONTE na tabela de conferência: o vão em Y de z=18 estava 29,9,
//    copiado de z=16 (artefato de amostragem — a mesma fileira de aletas caiu
//    nas duas alturas). Um bolso que ESTREITASSE subindo seria undercut e não
//    existe. Medição direta na malha, reconstruindo a superfície nas linhas
//    de nervura, corrige a coluna inteira: z=12..22 vira 27,0 / 28,5 / 29,9 /
//    31,5 / 33,1 / 34,7 e a boca 36,4 (a extrapolação por coluna até z=24 dá
//    36,34 com centro +1,69 contra os 36,40 / +1,68 medidos na boca —
//    bate em 0,06 e 0,01).
// 2. O ENCAIXE VIROU FAIXA: ~17 a 20mm no lugar do "20,09mm". Com o punho =
//    negativo do bolso MEDIDO (mesmo pior caso, folga zero) a lei entregue dá
//    ~16,7, e a sensibilidade é de 5,6mm de inserção por mm de folga por
//    lado. Ver "POR QUE O ENCAIXE É UMA FAIXA" abaixo. Nenhum desses números
//    merece duas casas decimais.
// 3. A FAIXA DE LEITURA DO GABARITO ESTAVA ERRADA e era o risco de uso: o
//    README chamava "sobra 3 a 6mm" de defeito ("o punho está parando cedo"),
//    mas a melhor estimativa do caso CORRETO (~16,7 de encaixe = 4,7 de
//    sobra) cai bem ali. O usuário imprimiria o gabarito, teria um resultado
//    BOM e reportaria como falha. Agora "está certo" = sobra 5 a 9mm.
// 4. Outras correções de texto: o encaixe pelo gabarito é 12,04 + sobra (não
//    12,0); a ponta do punho de pior caso para a 4,80 do prato com o bolso
//    MEDIDO (o 1,45 era do punho sintético); o prato mede 40,1mm² por berço
//    e 80,3 nos dois (não ~91), o que dá 0,035 MPa.
// 5. ASSERT ASSIMÉTRICO fechado nos dois lados (é a única mudança de código,
//    e assert não muda geometria): ccy_slope_max protegia só a parede de
//    FORA; a de DENTRO exige min(dccy/dt) > -13,79 e o valor atual é -3,49.
//    Não havia risco hoje, mas cradle_y_bow está exposto como parâmetro.
//
// ------------------------------------------------------------------------
// O QUE MUDOU NA 3ª RODADA (o print-review REPROVOU a 2ª)
// ------------------------------------------------------------------------
// 1. O CENTRO DO BOLSO ESTAVA ERRADO — é a correção que manda em tudo.
//    A 2ª rodada só tinha a tabela de VÃOS da referência, não a de CENTROS,
//    e subiu cradle_y_off de 2 pra 4 pra comprar borda de topo. Com a tabela
//    de centros medida, o erro fica escancarado: a referência segura o
//    centro EMBAIXO (chega a -0,96mm, ou seja o bolso desce ligeiramente
//    PRO BICO do bloco no meio da altura) e só sobe ~1,7mm no topo.
//      z  |  centro ref | 2ª rodada (4,0*t) | AGORA
//       4 |    -0,61    |      +1,40        | -0,59
//       8 |    -0,96    |      +2,35        | -1,19
//      12 |    -0,86    |      +2,92        | -0,77
//      16 |    +0,06    |      +3,36        | +0,18
//      20 |    +0,92    |      +3,73        | +1,18
//      24 |    +1,68    |      +4,00        | +1,70
//    erro máximo do centro: 3,78mm  ->  0,26mm
//    Duas causas somadas: (a) cradle_y_off grande demais; (b) a lei antiga
//    era LINEAR EM t, e como z ∝ t^2.5 o t sobe cedo em z — o centro saía
//    correndo pro meio do bloco já na primeira metade da altura.
//    AGORA: cradle_y_off = 1,7 (medido: a boca da referência em z=24 vai de
//    -78,52 a -42,12, ou seja vão 36,40 com centro em -60,32, que a 124mm
//    entre centros dá 1,7) e a lei do centro passa a ser
//       ccy = cradle_y_off*u - cradle_y_bow*(27/4)*u*(1-u)²,   u = t^2.5
//    ou seja: DESLOCAMENTO linear na ALTURA (u é a altura normalizada) mais
//    um ABAULAMENTO pra fora que nasce e morre em zero e vale cradle_y_bow
//    milímetros no seu máximo (o 27/4 é 1/max[u(1-u)²], então o parâmetro
//    está em mm de verdade). É o mesmo formato da referência: bolso segurado
//    embaixo, subindo só no fim.
// 2. O QUE ISSO COMPRA (simulação de descida — ver "SIMULAÇÃO" abaixo):
//    a PAREDE DE FORA é quem trava o punho, e o erro dela contra a
//    referência (tabela de vãos JÁ CORRIGIDA — ver 4ª rodada) em z=8..20
//    cai de +3,2..+4,0mm pra -0,3..+0,7mm.
//    Profundidade de encaixe com o punho preso pelos DOIS berços:
//       2ª rodada .............  ~10mm      (o punho EMPOLEIRA)
//       y_off=1,7 sem o bow ...  ~15,5mm
//       AGORA .................  ~17 a 20mm (máximo geométrico: 21,54mm)
//    As duas primeiras linhas saíram do MESMO bolso da terceira, então o que
//    elas medem com confiança é a DIFERENÇA entre as leis, não o valor
//    absoluto — e é por isso que nenhuma delas leva duas casas decimais.
// 3. O PISO RECEBE CARGA, SIM. A 2ª rodada documentou o contrário ("o punho
//    assenta nas paredes, o piso não recebe carga") e usou isso pra baixar o
//    piso de 3,0 pra 2,5. O piso de 2,5 CONTINUA CERTO, mas a justificativa
//    era falsa: com o centro corrigido a ponta do punho de PIOR CASO
//    (= negativo EXATO do bolso MEDIDO, folga zero) para a 4,80mm do prato;
//    um punho real é MENOR que o bolso e ENCOSTA no prato. Os 2,5mm são
//    dimensionados pra isso: o prato é um retângulo arredondado R2,5 de
//    7 x 6,5, ou seja 7*6,5 - (4-pi)*2,5² = 40,1mm² por berço e 80,3mm² nos
//    dois; 287g ali dão ~0,035 MPa, longe de qualquer coisa que amasse
//    TPU 95A maciço.
// 4. ASSERT DE BORDA NA PONTA: 4,5 -> 2,5mm. Com o y_off certo, margin_end
//    cai pra 2,7 e o assert antigo travava a função. Não é opinião: o
//    print-review FATIOU a peça (interseção com lajes de 0,2mm, contando
//    sólidos pelo `Volumes:` do CGAL) e a ÚLTIMA camada tem 3 pedaços — a
//    tira do coroamento (~19x80mm) e duas plaquinhas de ponta que com
//    margin_end=5,0 mediam 6,2 x 19mm e com margin_end=2,7 medem 4,0 x 19mm,
//    ou seja ~10 extrusões no lado curto, e nenhuma delas é ilha (a camada
//    de baixo é maior). O problema da 2ª rodada era uma FITA de 2mm dando a
//    volta no berço inteiro, e quem resolveu isso foi a ABÓBADA (não existe
//    mais camada de topo em forma de fita fechada) — o pedido do usuário
//    continua atendido com margin_end=2,7. margin_x segue 5,0.
// 5. O CUPOM DE 1 BERÇO VIROU GABARITO DE 2 BERÇOS. Com um berço só, nada
//    impede o punho de escorregar em Y — que é exatamente o movimento que a
//    chapa cheia proíbe (o outro punho está preso no outro berço). O cupom
//    da 2ª rodada lia ~21mm de encaixe onde a peça inteira dava ~10:
//    +11mm de FALSO POSITIVO, e o deslocamento em Y que ele permitia era
//    justamente o erro do cradle_y_off. O usuário leria "encaixe perfeito"
//    numa peça errada. Agora o teste é o part="gauge": a FATIA DE CIMA da
//    peça inteira (de z=12 pra cima, 170 x 60 x 13mm), com OS DOIS BERÇOS,
//    que trava o Y de verdade. O corte em z=12 fica abaixo de TODA a faixa
//    de aperto: as reconstruções da descida põem o contato acima de z~14,7,
//    e com o bolso corrigido ele sobe ainda mais (o punho para mais cedo,
//    então o contato sobe junto) — abaixo do corte o punho nem chega perto
//    da parede de fora.
//    E o gabarito devolve um NÚMERO, não uma impressão: enfia o punho por
//    cima, a ponta dele SAI pela face de baixo do gabarito, e
//       profundidade de encaixe = 12,04 + (quanto a ponta sobra por baixo)
//    (12,04 = boca em 24,0396 menos o corte em 12,000; estava declarado 12,0)
//    Não é predição de simulação, é aritmética do corte. Ver o README.
//
// SIMULAÇÃO DE DESCIDA (é de onde saem os números de encaixe acima).
// Punho = NEGATIVO EXATO do bolso da referência (folga zero, pior caso),
// amostrado a cada 0,05mm de altura; ele desce nos DOIS berços ao mesmo
// tempo, o que TRAVA o Y (deslocar o controle em Y ajuda um punho e atrapalha
// o outro na mesma medida) e deixa o X livre. Encaixe = plano da boca (24,04)
// menos o z onde a ponta do punho para. O perfil t^2.5 ganha ~3mm sobre o
// 2t³-t⁶ da 1ª rodada, com o mesmo centro corrigido.
//
// POR QUE O ENCAIXE É UMA FAIXA (~17 a 20mm) E NÃO UM NÚMERO:
//  (a) PIOR CASO, FOLGA ZERO: com o punho = negativo exato do bolso MEDIDO
//      (tabela já corrigida), a lei entregue dá ~16,7mm — a ponta para a 4,80
//      do prato. Punho de verdade é MENOR que o bolso, então o real mora
//      ACIMA disso.
//  (b) SENSIBILIDADE BRUTAL: perto da boca a parede está a 74-80°, então cada
//      milímetro de folga POR LADO em Y vale 5,6mm de inserção — 16,7 / 18,1
//      / 19,5 / 20,9 pra folga de 0 / 0,25 / 0,50 / 0,75 por lado.
//  (c) LIMITE DA FONTE: a malha de referência é VAZADA por aletas (37 fendas
//      de 1,95mm a passo 4,55) e as FENDAS caem em cima da parede de fora em
//      toda a faixa que trava — ou seja, a posição dessa parede entre z=12 e
//      z=24 NÃO É AMOSTRADA. Só com dados exatos de nervura a inserção fica
//      em qualquer ponto de [9,5 ; 21,1]; com interpolação suave entre as
//      linhas de nervura, 17 a 20mm. Quem mede o valor real é o GABARITO.
//
// ------------------------------------------------------------------------
// O QUE VEIO DA 2ª RODADA E CONTINUA VALENDO (o print-review aprovou)
// ------------------------------------------------------------------------
// - TOPO ABAULADO: abóbada de raio ~230mm, flecha 1,5mm. Não existe plano
//   chapado nem aresta reta no topo; convexa PRA CIMA, então cada camada é
//   MENOR que a de baixo (zero balanço) e as faixas de topo ficam entre 1,8
//   e 4,6mm, nunca abaixo de ~4 extrusões.
// - PERFIL z ∝ largura^2.5 com inclinação DEFINIDA na boca e filete R1 POR
//   DENTRO dos 42x36 (o lábio tangente do 2t³-t⁶ comia encaixe).
//   ATENÇÃO ao que esse "erro <= 0,64mm" cobre: é o VÃO EM X (profundidade)
//   no trecho z=8..20. Em Y (comprimento), contra a tabela CORRIGIDA da 4ª
//   rodada, o vão fica dentro de +0,2/-0,9mm nesse mesmo trecho, mas o modelo
//   é ~1,5mm MAIS LARGO em z=4..6 e ~1,3mm MAIS ESTREITO em z=22. É esse
//   estreitamento lá em cima que come inserção — ver a faixa de encaixe.
// - PISO 2,5mm, cradle_gap 124, boca 42x36, cradle_x_off 4,5, cradle_steps 24.
// - CHAPA GIRADA 90°: os 170mm no eixo X. Na A1 mini quem corre é a CAMA
//   (eixo Y), então a peça comprida em X poupa inércia num job de 8 horas.
//
// SEM COLMEIA HEXAGONAL, e é EXCEÇÃO CONSCIENTE à regra 5 do CLAUDE.md: o
// usuário pediu MACIÇO E LISO explicitamente. Não "consertar" pondo hexágono.
//
// SEM BALANÇO, POR CONSTRUÇÃO. (a) o berço é um loft cujas quatro bordas de
// seção só ANDAM PRA FORA conforme sobe — a meia-largura é linear em t e o
// centro anda devagar o suficiente NOS DOIS SENTIDOS, o que os asserts de
// ccy_slope_max/min guardam numericamente (+11,15 e -3,49 contra o limite de
// ±13,79); (b) o lábio da boca
// também só abre subindo; (c) a abóbada é convexa pra cima; (d) o resto é
// chão chapado e parede vertical. Conferir na malha exportada a cada
// mudança. NÃO LIGAR SUPORTE.
//
// Exports canônicos:
//   openscad -o stl/xbox-stand-01-stand.stl -D 'part="stand"' xbox-stand-01.scad
//   openscad -o stl/xbox-stand-01-gauge.stl -D 'part="gauge"' xbox-stand-01.scad
//   openscad -o 3mf/xbox-stand-01-gauge.3mf -D 'part="gauge"' xbox-stand-01.scad
//   openscad -o 3mf/xbox-stand-01-plate.3mf -D 'part="plate"' xbox-stand-01.scad
// "plate" é a MESMA peça de "stand", girada 90° e centrada na cama da A1
// mini — é o job de impressão cheio (peça única, 1 objeto, 1 filamento).
// "gauge" é o job de teste, também já centrado na cama.
// Diagnóstico (não são peças): part="cut_depth" corta no centro de um berço
// e mostra o perfil do vale + o piso + a abóbada; part="cut_len" corta ao
// longo do comprimento e mostra os dois berços em corte (é a vista onde se
// vê o centro do bolso subindo com a altura).

/* [Peça a renderizar] */
part = "plate"; // "stand" | "plate" (job cheio) | "gauge" (job de teste) | "cut_depth" | "cut_len"

/* [Bloco] */
// VARIANTE (outro controle, punho mais gordo, bloco menor): por INCLUDE,
// nunca por -D — os *_override só existem via -D e o is_undef() do ternário
// é avaliado antes. Num arquivo novo ao lado deste:
//   cradle_gap_override = 110; include <xbox-stand-01.scad>
body_len   = is_undef(body_len_override) ? 170 : body_len_override; // mm, COMPRIMENTO (eixo Y do modelo) — é o maior eixo e vai no teto de conforto da A1 mini
body_depth = 60;   // mm, PROFUNDIDADE (eixo X), da frente (-X) pro fundo (+X) da mesa
body_h     = 25;   // mm, ALTURA MÁXIMA do bloco — é a altura do COROAMENTO da abóbada, em x=0
round_r    = 4;    // mm, raio dos cantos em planta E do rolamento da aresta de topo (é o mesmo, por construção)
vault_rise = 1.5;  // mm, FLECHA da abóbada: quanto o topo cai do coroamento (x=0) até a borda do topo (x = ±(body_depth/2 - round_r)). 0 daria topo chapado
vault_n    = 12;   // estações da abóbada no hull do bloco (12 -> erro de corda de 0.010mm, 20x abaixo da camada)

/* [Berços - onde caem os punhos] */
cradle_gap    = is_undef(cradle_gap_override) ? 124 : cradle_gap_override;       // mm entre os CENTROS dos dois berços (±62 do meio, medido na malha de referência)
cradle_floor  = 2.5;  // mm de material maciço sob o ponto MAIS FUNDO do vale (o original tem ~1.0). RECEBE CARGA: a ponta do punho encosta aqui — ver cabeçalho
cradle_x_open = is_undef(cradle_x_open_override) ? 42 : cradle_x_open_override;  // mm, boca do berço no sentido da PROFUNDIDADE (X), medida NA SUPERFÍCIE (é a medida que a grossura do punho come)
cradle_y_open = is_undef(cradle_y_open_override) ? 36 : cradle_y_open_override;  // mm, boca do berço no sentido do COMPRIMENTO (Y), medida NA SUPERFÍCIE
cradle_x_off  = 4.5;  // mm, quanto o ponto mais fundo é deslocado pro FUNDO da mesa (+X); é o que faz o controle acabar o curso encostado pra trás
cradle_y_off  = 1.7;  // mm, quanto a BOCA é deslocada pro MEIO do bloco (medido: centro da boca da referência a -60,32, ou seja +1,7 do centro do berço)
cradle_y_bow  = 1.7;  // mm, ABAULAMENTO do bolso pro lado da PONTA do bloco no meio da altura. Zero = centro linear na altura; 1.7 é o que casa a tabela de centros medida (erro <= 0,26mm)
cradle_pad_x  = 7.0;  // mm, chapada do fundo do vale no sentido da profundidade (o prato onde a ponta do punho pousa)
cradle_pad_y  = 6.5;  // mm, chapada do fundo do vale no sentido do comprimento
cradle_r_bot  = 2.5;  // mm, raio dos cantos da seção do FUNDO do vale (fundo quase oval)
cradle_r_top  = 15;   // mm, raio dos cantos da BOCA do vale (boca quase oval — punho é redondo, não é caixa)
cradle_pow    = 2.5;  // EXPOENTE do perfil do vale: z ∝ (largura)^cradle_pow. 2.5 é o que casa a parábola medida na malha de referência (vão em X com erro <= 0.64mm em z=8..20; em Y, contra a tabela corrigida, +0.2/-0.9 no mesmo trecho, +1.5 em z=4..6 e -1.3 em z=22)
mouth_fillet  = 1.0;  // mm, raio do filete da boca. Vive POR DENTRO dos 42x36: a parede sobe reta e só o último 0.72mm rola pra encontrar a superfície
cradle_steps  = 24;   // fatias do loft da parede do vale (24 -> desvio geométrico de 0.017mm, 12x abaixo da camada de 0.2). Render do sólido inteiro: ~2min
lip_steps     = 6;    // fatias do filete da boca

/* [Gabarito de teste] */
// part="gauge": a FATIA DE CIMA da peça inteira, com OS DOIS BERÇOS. É o
// primeiro job da fila. Dois berços não é luxo: com um berço só o punho
// escorrega em Y e o teste dá falso positivo (+11mm de encaixe imaginário).
gauge_z = 12.0;  // mm, altura do corte. Tem que ficar ABAIXO da faixa onde o punho aperta (as reconstruções da descida põem o contato acima de z~14,7) e ACIMA do piso, senão o gabarito vira a peça inteira. A leitura é encaixe = (mouth_z - gauge_z) + sobra = 12,04 + sobra

/* [Posição na cama] */
// O modelo é construído em volta da origem (bloco centrado em XY); as peças
// de EXPORT saem giradas 90° (170 no eixo X) e centradas na cama, pra chapa
// abrir pronta no Bambu Studio.
bed_mm = 180; // mm, cama da A1 mini

/* [Qualidade] */
$fn = 64;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------

// --- Abóbada do topo -------------------------------------------------
// A abóbada é um cilindro deitado no eixo do COMPRIMENTO: curva só na
// profundidade (X), então os dois berços veem exatamente o mesmo topo.
// O bloco é o hull de uma corrente de esferas de raio round_r cujos CENTROS
// seguem um arco de raio vault_r_ctr; a superfície de topo é esse arco
// deslocado pra fora, ou seja um arco de raio vault_r_ctr + round_r.
vault_x_edge = body_depth / 2 - round_r;                                  // 26: até onde vai a corrente de esferas
vault_r_ctr  = (pow(vault_x_edge, 2) + pow(vault_rise, 2)) / (2 * vault_rise);
vault_r_top  = vault_r_ctr + round_r;
function ctr_z(x)  = body_h - round_r - (vault_r_ctr - sqrt(pow(vault_r_ctr, 2) - pow(x, 2))); // z do CENTRO da esfera
function dome_z(x) = body_h - vault_r_top + sqrt(pow(vault_r_top, 2) - pow(x, 2));             // z da SUPERFÍCIE de topo

// --- Boca e lábio ----------------------------------------------------
// A boca é PLANA e mora na altura da abóbada em x = ±cradle_x_open/2, que é
// onde a borda da boca cruza o topo: assim os 42mm são 42mm DE VERDADE na
// superfície, e o filete morre tangente ao topo exatamente ali.
mouth_z = dome_z(cradle_x_open / 2);

// Inclinação da parede na boca: depende do quanto o filete come da parede,
// que por sua vez depende da inclinação. Ponto fixo — 4 passos convergem em
// menos de 0.01°.
function wall_theta(th) =
    let (bite = mouth_fillet * sin(th),
         zl   = mouth_z - mouth_fillet * (1 - cos(th)),
         run  = ((cradle_x_open / 2 - bite - cradle_pad_x / 2) +
                 (cradle_y_open / 2 - bite - cradle_pad_y / 2)) / 2)
    atan2((zl - cradle_floor) * cradle_pow, run);
lip_theta = wall_theta(wall_theta(wall_theta(wall_theta(72))));

lip_bite  = mouth_fillet * sin(lip_theta);          // quanto o filete recua a parede, em largura
lip_h     = mouth_fillet * (1 - cos(lip_theta));    // altura do filete
lip_z     = mouth_z - lip_h;                        // onde a parede acaba e o filete começa
wall_rise = lip_z - cradle_floor;                   // subida da parede (o "D" do perfil)
wall_hx   = cradle_x_open / 2 - lip_bite;           // meia-largura no topo da parede
wall_hy   = cradle_y_open / 2 - lip_bite;

cradle_depth = mouth_z - cradle_floor;         // mm, mergulho do vale (boca -> ponto mais fundo)
top_span_x   = body_depth - 2 * round_r;       // mm, largura do topo abaulado (onde o rolamento da aresta ainda não começou)
top_span_y   = body_len   - 2 * round_r;       // mm, comprimento idem

// Extremos da BOCA de um berço, no referencial do próprio berço
// (+Y = pro MEIO do bloco, -Y = pra PONTA; +X = fundo da mesa, -X = frente)
mouth_x_front = -cradle_x_open / 2;                     // -21: borda da boca na frente
mouth_x_back  =  cradle_x_open / 2;                     // +21: borda da boca no fundo
mouth_y_out   = cradle_y_off - cradle_y_open / 2;       // -16.3: borda da boca virada pra PONTA do bloco
mouth_y_in    = cradle_y_off + cradle_y_open / 2;       // +19.7: borda da boca virada pro MEIO do bloco

// Sobras de material (o que separa a boca do vale das arestas arredondadas)
margin_x     = top_span_x / 2 - cradle_x_open / 2;                      // mm, borda de cada lado da profundidade
margin_end   = body_len / 2 - round_r - (cradle_gap / 2 - mouth_y_out); // mm, borda entre o berço e a ponta do bloco
middle_flat  = cradle_gap - 2 * mouth_y_in;                             // mm, miolo entre os dois berços

// Ângulos de CORDA da parede do vale (do prato até a boca, em graus da
// horizontal). É a inclinação MÉDIA, e MÉDIA SÓ: o perfil é côncavo, então
// nenhuma parede real tem esse ângulo em lugar nenhum. Serve pra comparar
// frente x fundo, não pra dizer como o controle entra.
run_front  = abs(mouth_x_front - (cradle_x_off - cradle_pad_x / 2));
run_back   = abs(mouth_x_back  - (cradle_x_off + cradle_pad_x / 2));
chord_front = atan(cradle_depth / run_front);
chord_back  = atan(cradle_depth / run_back);

// ---------------------------------------------------------------------
// Perfil do vale
// ---------------------------------------------------------------------
// t = 0 no fundo do prato, t = 1 no topo da parede (onde o filete da boca
// começa). u = t^cradle_pow é a ALTURA NORMALIZADA (0 no prato, 1 no topo da
// parede) — é nela que o centro do bolso anda, porque foi assim que a
// referência foi medida (centro por ALTURA, não por parâmetro de loft).
//
// A meia-largura é LINEAR em t e a ALTURA é a POTÊNCIA z ∝ largura^2.5:
// a malha de referência, normalizada, tem exatamente essa forma (regressão
// log-log do vão contra a altura dá expoente 2.0 no trecho baixo e 2.4 no
// alto). Duas propriedades que vêm de graça:
//   - g'(0) = 0 (pow > 1): a superfície nasce HORIZONTAL no fundo, então o
//     berço tem PRATO e não bico;
//   - g'(1) != 0: a parede chega na boca com INCLINAÇÃO DEFINIDA (68° na
//     frente, 77° no fundo, 79,6° na parede de fora e 70,9° na de dentro),
//     em vez de se derramar tangente no topo.
//
// O CENTRO em Y é a correção da 3ª rodada: deslocamento linear na ALTURA
// mais um ABAULAMENTO pro lado da ponta do bloco que nasce e morre em zero.
// bow_norm = 1/max[u(1-u)²] = 27/4, então cradle_y_bow está em mm de
// abaulamento máximo, não em unidade abstrata.
bow_norm = 27 / 4;
function cz(t)  = cradle_floor + wall_rise * pow(t, cradle_pow);
function t_of_z(z) = pow((z - cradle_floor) / wall_rise, 1 / cradle_pow);
function chx(t) = cradle_pad_x / 2 + (wall_hx - cradle_pad_x / 2) * t;
function chy(t) = cradle_pad_y / 2 + (wall_hy - cradle_pad_y / 2) * t;
function ccx(t) = cradle_x_off * (1 - t);   // o fundo é deslocado pro fundo da mesa; a boca é centrada
function ccy(t) = let (u = pow(t, cradle_pow))
                  cradle_y_off * u - cradle_y_bow * bow_norm * u * pow(1 - u, 2);
function crr(t) = min(cradle_r_bot + (cradle_r_top - cradle_r_bot) * t,
                      chx(t) - 0.05, chy(t) - 0.05);

// ZERO BALANÇO = as quatro bordas da seção monotônicas em t. Em X a conta é
// fechada (ccx é linear). Em Y o centro não é linear, então o guarda é
// numérico — E ELE PRECISA DOS DOIS LADOS, porque a lei do centro sobe E
// desce: a borda de FORA é ccy - chy (só anda pra fora se ccy' < +chy') e a
// de DENTRO é ccy + chy (só anda pra fora se ccy' > -chy'). Como chy é linear
// em t, chy' = wall_hy - cradle_pad_y/2 = 13.79 nos dois casos. Folga atual:
// +11.15 de um lado e -3.49 do outro, contra o limite de ±13.79. O guarda de
// baixo não é decoração: cradle_y_bow está exposto como parâmetro e é ele
// quem cava o centro pra baixo no meio da altura.
ccy_slope_max = max([for (i = [1 : 400]) (ccy(i / 400) - ccy((i - 1) / 400)) * 400]);
ccy_slope_min = min([for (i = [1 : 400]) (ccy(i / 400) - ccy((i - 1) / 400)) * 400]);

assert(cradle_floor >= 2.0, "piso do berço fino demais pra TPU — e ele RECEBE a carga da ponta do punho");
assert(margin_x    >= 4.5, "borda estreita demais na profundidade: em TPU uma fita fina de topo enrola e o bico arrasta");
// 2.5 e não 4.5: a última camada não é uma FITA em volta do berço (a abóbada
// acabou com isso), são a tira do coroamento (~19x80) mais duas plaquinhas
// de ponta que com margin_end=2.7 medem 4.0 x 19mm — ~10 extrusões no lado
// curto, e nenhuma delas é ilha. Fatiado e contado, não estimado.
assert(margin_end  >= 2.5, "borda estreita demais até a ponta do bloco: a plaquinha de ponta da última camada fica com menos de ~10 extrusões");
assert(middle_flat >= 10,  "os dois berços se encostam: não sobra miolo entre eles");
assert(max(body_len, body_depth) <= 170, "estoura o teto de conforto de 170mm da A1 mini");
assert(mouth_fillet < min(cradle_x_open, cradle_y_open) / 4, "filete de boca grande demais");
assert(vault_rise > 0 && vault_rise < round_r, "flecha da abóbada fora de faixa (0 = topo chapado; >= round_r come o rolamento da aresta)");
assert(gauge_z >= cradle_floor + 3, "corte do gabarito rente ao piso: o gabarito vira a peça inteira e não economiza nada");
assert(gauge_z <= 12.5, "corte do gabarito alto demais: as reconstruções da descida põem o aperto do punho todo acima de z~14,7 e o corte tem que ficar pelo menos 2mm abaixo disso, senão o gabarito deixa passar o que a peça inteira segura");
assert(wall_hx - cradle_pad_x / 2 > cradle_x_off, "a borda do FUNDO do vale volta pra trás: criaria face virada pra baixo");
assert(ccy_slope_max < wall_hy - cradle_pad_y / 2, "o centro do bolso SOBE mais rápido que a meia-largura: a parede de FORA fecharia subindo e viraria balanço (baixar cradle_y_off, ou cradle_y_bow, que é quem faz o centro voltar correndo no fim)");
assert(ccy_slope_min > -(wall_hy - cradle_pad_y / 2), "o centro do bolso DESCE mais rápido que a meia-largura: a parede de DENTRO fecharia subindo e viraria balanço (baixar cradle_y_bow)");

echo(str("xbox-stand-01 BLOCO: ", body_depth, " x ", body_len, " x ", body_h,
         " mm (altura no coroamento) | cantos e aresta de topo R", round_r,
         " | topo abaulado ", top_span_x, " x ", top_span_y));
echo(str("  ABÓBADA: flecha ", vault_rise, " mm | raio da superfície ", vault_r_top,
         " | queda em x=21: ", body_h - dome_z(cradle_x_open / 2),
         " | altura da lateral (x=±", body_depth / 2, "): ", ctr_z(vault_x_edge)));
echo(str("  BERÇOS: 2, centros a ±", cradle_gap / 2, " (", cradle_gap, " entre centros)",
         " | boca ", cradle_x_open, " x ", cradle_y_open, " no plano z=", mouth_z,
         " | mergulho ", cradle_depth, " | piso ", cradle_floor));
echo(str("  PERFIL: z = piso + ", wall_rise, " * t^", cradle_pow,
         " | parede na boca ", lip_theta, "° | filete R", mouth_fillet,
         " (recuo ", lip_bite, ", altura ", lip_h, ") | boca da parede ",
         2 * wall_hx, " x ", 2 * wall_hy));
echo(str("  CENTRO do bolso: ccy = ", cradle_y_off, "*u - ", cradle_y_bow,
         "*(27/4)*u*(1-u)^2, u = t^", cradle_pow,
         " | inclinação ", ccy_slope_min, " .. ", ccy_slope_max,
         " (limite ±", wall_hy - cradle_pad_y / 2, ", os dois lados)"));
echo(str("  boca em X: ", mouth_x_front, " .. ", mouth_x_back,
         " | boca em Y (local): ", mouth_y_out, " .. ", mouth_y_in,
         " | ponto mais fundo em x=", cradle_x_off));
echo(str("  sobras: ", margin_x, " mm de borda em cada lado da profundidade, ",
         margin_end, " mm até a ponta do bloco, miolo de ", middle_flat, " mm entre os berços"));
echo(str("  CORDA (média, não é parede nenhuma): frente ", chord_front, "° (corrida ",
         run_front, ") x fundo ", chord_back, "° (corrida ", run_back, ")"));
echo(str("  GABARITO: corte em z=", gauge_z, " -> ", body_len, " x ", body_depth,
         " x ", body_h - gauge_z, " mm | encaixe = ", mouth_z - gauge_z,
         " + (quanto a ponta do punho sobra abaixo da face de baixo)"));

// Tabela de conferência do vale contra a malha de referência.
// vão X / vão Y por altura (a referência foi medida com piso de ~1mm).
// A COLUNA Y de z=12 pra cima foi REMEDIDA na 4ª rodada, reconstruindo a
// superfície nas linhas de nervura (37 fendas de 1,95mm a passo 4,55): o
// valor antigo de z=18 (29,9) era cópia do de z=16, artefato de amostragem —
// bolso que estreita subindo seria undercut e não existe.
//   z=  4: 17.4 / 14.6     z= 14: 33.6 / 28.5
//   z=  6: 21.9 / 18.5     z= 16: 35.4 / 29.9
//   z=  8: 25.8 / 22.5     z= 18: 37.0 / 31.5   (era 29.9)
//   z= 10: 29.0 / 24.7     z= 20: 38.5 / 33.1   (era 32.1)
//   z= 12: 31.6 / 27.0     z= 22:  --  / 34.7   (linha nova)
//   (era 27.3)             boca: 42.0 / 36.4 (centro +1.68)
// A boca em Y é 36,4 MEDIDA (a extrapolação por coluna até z=24 dá 36,34 com
// centro +1,69 — bate em 0,06 e 0,01); o modelo usa 36,0, ou seja 0,4 mais
// estreito. O X não foi remedido (a amostragem em X não tinha o artefato).
// centro do bolso por altura (+ = pro MEIO do bloco):
//   z=4: -0.61   z=8: -0.96   z=12: -0.86   z=16: +0.06   z=20: +0.92
for (z = [4, 8, 12, 16, 20]) {
    t = t_of_z(z);
    echo(str("  vale z=", z, " -> vao X=", 2 * chx(t), "  vao Y=", 2 * chy(t),
             "  centro Y=", ccy(t),
             "  parede de fora=", ccy(t) - chy(t), "  de dentro=", ccy(t) + chy(t)));
}

// Filete da boca: arco de raio mouth_fillet tangente ao topo no plano da
// boca (s = 1) e tangente à parede (s = 0). Como o recuo é o mesmo nos dois
// eixos, é uma bola rolando na quina — fillet de verdade, e ele SÓ ABRE
// subindo (continua sem balanço) e nunca passa dos 42x36. O centro dele é
// cradle_y_off, que é exatamente ccy(1) — a emenda é contínua.
function lpsi(s) = lip_theta * (1 - s);
function lz(s)   = mouth_z - mouth_fillet * (1 - cos(lpsi(s)));
function lhx(s)  = cradle_x_open / 2 - mouth_fillet * sin(lpsi(s));
function lhy(s)  = cradle_y_open / 2 - mouth_fillet * sin(lpsi(s));
function lrr(s)  = min(cradle_r_top, lhx(s) - 0.05, lhy(s) - 0.05);

// Uma fatia do vale: retângulo arredondado.
module rr_slice(cx, cy, hx, hy, r, z, h) {
    translate([cx, cy, z])
        linear_extrude(h)
            offset(r = r)
                square([2 * hx - 2 * r, 2 * hy - 2 * r], center = true);
}
module cradle_slice(t, h) { rr_slice(ccx(t), ccy(t), chx(t), chy(t), crr(t), cz(t), h); }
module lip_slice(s, h)    { rr_slice(0, cradle_y_off, lhx(s), lhy(s), lrr(s), lz(s), h); }

// O NEGATIVO de um berço: loft da parede + loft do filete da boca + um
// prolongamento RETO acima do plano da boca, que a abóbada apara (é ele que
// abre a boca no topo abaulado sem passar de 42x36 em lugar nenhum).
// Referencial local: +Y aponta pro MEIO do bloco.
module cradle_cutter() {
    for (i = [0 : cradle_steps - 1])
        hull() {
            cradle_slice(i / cradle_steps, 0.02);
            cradle_slice((i + 1) / cradle_steps, 0.02);
        }
    for (i = [0 : lip_steps - 1])
        hull() {
            lip_slice(i / lip_steps, 0.02);
            lip_slice((i + 1) / lip_steps, 0.02);
        }
    lip_slice(1, vault_rise + 2); // sobe acima do coroamento
}

// Os dois berços, já posicionados. O de +Y é o de -Y espelhado no
// comprimento (a assimetria da PROFUNDIDADE não pode espelhar: o encosto
// tem que ficar no fundo da mesa nos dois).
module cradles() {
    translate([0, -cradle_gap / 2, 0]) cradle_cutter();
    translate([0,  cradle_gap / 2, 0]) mirror([0, 1, 0]) cradle_cutter();
}

// ---------------------------------------------------------------------
// Bloco
// ---------------------------------------------------------------------
// Chão chapado, laterais verticais, cantos verticais arredondados e TOPO
// ABAULADO, tudo com o mesmo raio de rolamento: hull de 4 "pinos" nos cantos
// (que dão o chão e as laterais) com uma corrente de esferas seguindo a
// abóbada (que dá o topo e a aresta rolada). É a soma de Minkowski feita à
// mão — mesmo resultado do minkowski() e sem o custo dele.
module body() {
    hull() {
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * vault_x_edge, sy * (body_len / 2 - round_r), 0])
                cylinder(r = round_r, h = ctr_z(vault_x_edge));
        for (sy = [-1, 1], i = [0 : vault_n])
            translate([-vault_x_edge + i * 2 * vault_x_edge / vault_n,
                       sy * (body_len / 2 - round_r), 0])
                translate([0, 0, ctr_z(-vault_x_edge + i * 2 * vault_x_edge / vault_n)])
                    sphere(r = round_r);
    }
}

module stand() {
    difference() {
        body();
        cradles();
    }
}

// GABARITO DE TESTE: a FATIA DE CIMA da peça inteira, de gauge_z pra cima,
// com OS DOIS BERÇOS — é o segundo berço que trava o Y e impede o falso
// positivo que um cupom de berço único daria. Imprime deitado na face do
// corte (chão chapado, tudo abrindo pra cima, sem suporte).
module gauge() {
    translate([0, 0, -gauge_z])
        intersection() {
            stand();
            translate([-body_depth, -body_len, gauge_z])
                cube([2 * body_depth, 2 * body_len, body_h + 2]);
        }
}

// Peça de export: girada 90° (os 170mm no eixo X, que na A1 mini é o eixo
// que NÃO carrega a cama) e centrada na cama, pra chapa abrir pronta.
module on_bed() { translate([bed_mm / 2, bed_mm / 2, 0]) rotate([0, 0, 90]) children(); }

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "stand") {
    on_bed() stand();
} else if (part == "plate") {
    // JOB CHEIO: peça única, chão na cama, boca dos berços pra cima, sem
    // suporte e sem brim. Footprint 170 (X) x 60 (Y).
    on_bed() stand();
} else if (part == "gauge") {
    // JOB DE TESTE (imprimir ESTE primeiro): 170 x 60 x 13.
    on_bed() gauge();
} else if (part == "cut_depth") {
    // DIAGNÓSTICO: corta no centro do berço de -Y e mostra o perfil do vale
    // no sentido da profundidade (parede da frente x encosto do fundo), o
    // piso e a abóbada.
    difference() {
        stand();
        translate([-body_depth, -cradle_gap / 2, -1])
            cube([2 * body_depth, body_len, body_h + 2]);
    }
} else if (part == "cut_len") {
    // DIAGNÓSTICO: corta ao longo do comprimento, na linha do ponto mais
    // fundo, e mostra os dois berços em corte — é aqui que se vê o CENTRO do
    // bolso descendo pro bico do bloco no meio da altura e subindo no fim.
    difference() {
        stand();
        translate([cradle_x_off, -body_len, -1])
            cube([body_depth, 2 * body_len, body_h + 2]);
    }
} else {
    stand();
}
