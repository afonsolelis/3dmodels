// penny-holder-01.scad
//
// Caixa aberta pra cartas com PENNY SLEEVE guardadas DEITADAS na aresta longa,
// em DUAS camadas, com a pilha correndo de lado a lado. 74.2 x 102.7 x 150mm,
// empilhável (ressalto + chaveta), colmeia hexagonal no piso e nas laterais,
// frente com VÃO CONTÍNUO do piso ao alto e uma CINTA fechando a volta no topo.
//
// DE ONDE VEIO, E POR QUE NÃO É O ARQUIVO DE ORIGEM
// O ponto de partida é o `../PennySleeveHolder_Stackable_Colmeia_80mm.3mf`
// ("Stackable Penny Sleeve Holder", Sazabi, MakerWorld, MakerWorld Exclusive
// License — já um derivado de terceiro, com o piso em colmeia). Aquele arquivo
// NÃO é redistribuível e é por causa dessa família de licenças que o repo virou
// privado em 2026-08-09. Este .scad é RECONSTRUÇÃO PARAMÉTRICA própria: nada
// da malha de origem foi copiado, só medidas de engenharia reversa.
// Medido na malha de origem (3589 vértices / 7278 triângulos, estanque):
//   envelope 74.20 x 102.70 x 80.00 (bbox conferido: x ±37.10, y ±51.35)
//   parede 2.60 constante (face interna em x ±34.50 e y ±48.75 -> vão 69.0 x 97.5)
//   ressalto de empilhamento z 0..3 (nenhum vértice entre 0 e 3: prisma reto),
//     contorno 68.6 x 97.1 mais uma língua atrás até y=-50.75
//   aba do corpo aparece em z=3 (74.2 x 102.7) e topo do piso em z=10
//   piso em colmeia: célula 24 entre faces, nervura 1.6, moldura perimetral 3.0
//   travessa traseira em z=42.1..46.9, com ponte plana de 53 x 2.6 (o pior ponto
//     da peça) — NÃO foi recriada aqui
//   volume sólido 52.4 cm3; fatiado real na A1 mini 2h32 / 61.2g
//
// ATENÇÃO — A MEDIDA DA CARTA NÃO É DE RÉGUA
// card_w/card_h = 66 x 91 são CATÁLOGO (carta 63 x 88 + penny sleeve), não
// medida de régua. O usuário foi perguntado e optou por seguir assim; o risco
// está assumido, do mesmo jeito que os slabs PSA deste repo (ver o bloco de
// alerta em ../README.md). TODA a caixa é derivada desses dois números:
//   altura total  = floor_h + layers*card_w + head = 10 + 132 + 8 = 150
//   profundidade  = card_h + 2*card_gap_y + 2*wall = 91 + 6.5 + 5.2 = 102.7
// então medir com régua e re-exportar conserta o modelo inteiro. Se a carta
// medir mais que 66 de largura, a caixa CRESCE em Z (2mm por mm de carta) e o
// teto de 180 da A1 mini só é atingido com card_w = 81.
//
// COMO SE MANUSEIA (é uma gaveta de fichário em pé, não uma deckbox):
//   1. A caixa fica de pé na mesa, com a JANELA GRANDE virada pra você. As
//      cartas entram DEITADAS na aresta longa: os 91mm vão no sentido
//      frente-fundo (você vê a lateral curta da carta pela janela), os 66mm
//      ficam de pé, e a pilha cresce da esquerda pra direita, atravessando os
//      69mm de vão. Cabem ~150 cartas por camada, ~300 na caixa.
//   2. GUARDAR: pela BOCA, que é aberta e livre (69.0 x 97.5, sem nenhum
//      estrangulamento — a cinta é rente à parede, não avança pra dentro).
//      Enche a camada de baixo primeiro, empurra o bloco pro fundo, e a
//      segunda camada senta em cima da primeira, apoiada na aresta de 91mm.
//   3. TIRAR uma carta da camada de CIMA: enfia a mão pela boca, abre a pilha
//      com o polegar e puxa a carta pra cima. A boca é aberta em cima, então a
//      carta sai reta pro ar livre — não existe teto pra bater.
//   4. TIRAR uma carta da camada de BAIXO: é pela JANELA DA FRENTE, e é por
//      isso que ela vai do piso ao alto sem travessa nenhuma. Você entra com
//      dois dedos na altura da camada de baixo (o peitoril está RENTE ao piso,
//      em z=10, sem degrau nenhum pra carta enroscar), pinça a aresta curta da
//      carta e puxa pra frente; a carta corre os 91mm e sai pela janela.
//      LEIA A PENDÊNCIA no fim deste cabeçalho antes de contar com isso.
//   5. EMPILHAR: a caixa de cima desce na boca da de baixo. Só entra numa
//      orientação — janela com janela (ver CHAVETA). Se estiver virada, ela
//      para 3mm alta e óbvia, não encaixa "quase".
//
// O QUE MUDOU EM RELAÇÃO AO ORIGINAL, E POR QUÊ
//   1. ALTURA 80 -> 150 (decisão do usuário). Duas camadas de carta deitada
//      dentro de UMA caixa em vez de empilhar duas caixas. O orçamento fecha
//      exato: 10 de piso + 132 de carta + 8 de ar = 150, e os 8 de ar são o
//      MESMO espaço que a cinta ocupa na parede, então não brigam.
//   2. FRENTE SEM TRAVESSA NO MEIO (decisão do usuário: "ele é robusto o
//      suficiente para segurar sem abrir os lados"). O original tem travessa a
//      meia altura; aqui a janela é um vão único de 58.2 x 132, do piso ao topo.
//      Quem amarra os lados vira: (a) a CINTA de 8mm no alto, em volta inteira;
//      (b) o piso em colmeia de 10mm de profundidade, que é um diafragma
//      rígido embaixo; (c) os MONTANTES de 8mm em cada lado da janela, que
//      viram flange do canto — cada parede lateral fica com seção em L de
//      8 x 8mm correndo os 150mm de altura, e isso é o que de fato impede o
//      lado de abrir. Ver a conta de esforço em "CINTA" mais abaixo.
//   3. TRAVESSA TRASEIRA DELETADA. No original ela é uma PONTE PLANA de
//      53 x 2.6mm em z=42.1 — 90 graus de balanço, o pior ponto da peça. Aqui
//      o fundo é colmeia de ponta pra cima, que fecha cada furo em bico e não
//      tem uma única ponte reta.
//   4. COLMEIA TAMBÉM NAS PAREDES (regra 5 do repo). No original a colmeia é
//      só o piso e as paredes são arcos ogivais com travessa. Numa parede de
//      150mm essa linguagem exigiria uma segunda fileira de arcos com mais uma
//      travessa (mais uma ponte); a colmeia de ponta pra cima empilha quantas
//      fileiras precisar SEM nenhum plano horizontal. Mesma largura de célula
//      (24mm) do piso medido, pra ficar uma coisa só — mas com o bico de 45,
//      ver logo abaixo.
//
// COLMEIA DE BICO DE 45 NAS PAREDES (e regular no piso) — não é capricho
// "Hexágono de ponta pra cima imprime sem ponte" (regra 5) é verdade, mas é
// meia verdade, e a auditoria da malha exportada pegou isso: no hexágono
// REGULAR os dois flancos do bico ficam a 30 graus DA HORIZONTAL, ou seja 60
// graus de balanço — PIOR que os 45 que o resto da peça respeita. Medido na
// versão regular: 3094mm2 de teto de furo a 30 graus, em 5 fileiras.
// Dois motivos pra consertar, e o segundo é o que decide:
//   a) 30 graus da horizontal significa cada camada avançar 0.35mm sobre a
//      anterior (camada de 0.2), o que deixa ~17% da linha apoiada contra os
//      ~52% de um teto de 45. Cai, mesmo que só cosmeticamente.
//   b) 30 graus é EXATAMENTE o limiar de suporte padrão do Bambu Studio. O
//      usuário fatia com SUPORTE LIGADO: um teto no limiar é sorteio, e o
//      prêmio é suporte dentro dos 47 furos de colmeia, num rasgo de 2.6mm de
//      profundidade de onde não se tira.
// A célula das paredes então não é o hexágono regular: 24mm entre faces,
// lateral reta de 8mm e BICO DE 45 graus (12mm de altura), o que dá célula de
// 24 x 32. Continua colmeia, continua de ponta pra cima, continua sem uma
// única ponte reta — e agora o teto de furo está a 45, folgado acima do
// limiar do fatiador. O passo entre fileiras é recalculado pra manter a
// nervura de 2.6mm TAMBÉM na costura diagonal (ver hex_field).
// No PISO a célula segue o hexágono REGULAR de 24mm medido no original: o
// piso é horizontal, os furos são prismas verticais, não existe teto nenhum
// pra pender — deformar a célula lá seria mexer no que foi medido, à toa.
//   5. CHAVETA REDESENHADA. A do original deixa ~0.3-0.6mm de parede atrás do
//      rasgo (a língua avança até 0.6mm da face externa numa parede de 2.6).
//      Aqui a chaveta é um RESSALTO PRA DENTRO na boca do fundo (1.2mm) com
//      rasgo correspondente no ressalto de baixo: a parede fica inteira, com
//      os 2.6mm, e o ar de sobra que existe atrás da carta (6.5mm de folga em
//      Y) paga o ressalto sem encostar em carta nenhuma.
//   6. RESSALTO DE EMPILHAMENTO com folga 0.25/lado (padrão de deslize do
//      repo) em vez dos 0.20 medidos no original, mais chanfro de entrada de
//      0.4 embaixo do ressalto e funil de 0.6 na boca: 1.0mm de erro lateral
//      aceito na hora de empilhar, e a zona de pé-de-elefante do ressalto sai
//      da superfície de encaixe.
//
// CINTA — POR QUE 8mm DE FAIXA BASTAM SEM TRAVESSA NO MEIO
// O modo de falha é o lado abrir pra fora, girando em torno da base. Quem
// segura o topo é o segmento da frente da cinta, e ele trabalha em TRAÇÃO ao
// longo de X, não em flexão: seção 2.6 x 8 = 20.8mm2, o que em PLA a 30MPa dá
// ~620N. A carga real é o empurrão de ~300 cartas soltas contra a parede, que
// não chega perto de 1% disso. A cinta é rente à parede (não avança pra dentro
// nem pra fora): pra dentro ela estrangularia a boca e brigaria com a carta de
// cima; pra fora ela cresceria o footprint e viraria degrau no empilhamento.
//
// CURSO COMPLETO DO EMPILHAMENTO (simulado com número antes de dar por bom —
// lição do elevador do deckbox-01, que tinha 10mm de vão pra 48mm de curso):
//   separação 1.00mm .. o chanfro de 0.4 do pé do ressalto encontra o funil de
//                       0.6 da boca. É o PRIMEIRO contato e é ele quem alinha:
//                       aceita 1.0mm de erro lateral de mão.
//   separação 0.60mm .. o ressalto reto (68.5 x 97.0) entra na boca reta
//                       (69.0 x 97.5). Folga 0.25/lado, deslize do repo.
//   separação 0.60mm .. NO MESMO INSTANTE a chaveta decide: com a caixa na
//                       orientação certa, o ressalto pra dentro do fundo
//                       (36 x 1.2) entra no rasgo do ressalto (36.6 x 1.5),
//                       0.30/lado em X e 0.55 de sobra em Y. Virada 180 graus,
//                       o mesmo ressalto bate na moldura CHEIA do piso e a
//                       caixa para 3mm alta — interferência de 0.95mm em
//                       36 x 3mm de contato, que NÃO entra forçando.
//   separação 0.00mm .. assenta. Quem faz o batente é a ABA do corpo (2.6mm de
//                       largura em toda a volta) contra o ARO da caixa de
//                       baixo (2.0mm de largura, depois do funil) — nunca o
//                       fundo do ressalto contra carta. Engate reto = 2.0mm
//                       (3.0 de ressalto - 0.6 de funil - 0.4 de chanfro).
//   Com a caixa cheia: o topo da carta de cima fica em z=142 e o ressalto da
//   caixa de cima desce até z=147 -> sobram 5mm de ar. O empilhamento não
//   encosta em carta nem com a pilha 5mm desalinhada.
//   Provas na geometria: part="fit" (as duas caixas empilhadas) TEM QUE SAIR
//   VAZIO; part="fit180" (a de cima virada) TEM QUE SAIR NÃO-VAZIO, senão a
//   chaveta não existe de fato.
//
// IMPRIME EM PÉ, BOCA PRA CIMA, SEM SUPORTE — inventário de balanço, TODO ELE
// MEDIDO NA MALHA EXPORTADA (área de face virada pra baixo, por ângulo):
//   colmeia das paredes ...... teto de furo a 45 graus da horizontal, em bico.
//                               Zero ponte reta. (Com hexágono regular seriam
//                               30 graus e 3094mm2 de teto ruim — ver acima.)
//   colmeia do piso .......... prisma vertical, não tem teto.
//   janela da frente ......... duas águas de 45 graus fecham os 58.2mm de vão
//                               em 29.1mm de subida (2mm de vão por mm de
//                               altura, o mesmo critério do original).
//   funil da boca ............ material RECUA subindo: cada camada apoia na de
//                               baixo, não é balanço.
//   chaveta .................. rampa de 45 graus embaixo do ressalto.
//   aba do corpo em z=3 ...... ÚNICO plano horizontal sem apoio: 2.6mm de
//                               aba em toda a volta, 1029mm2, ancorada na
//                               moldura maciça do ressalto. Herdada do
//                               original (lá são 2.8mm / 876mm2) e mantida DE
//                               PROPÓSITO: é ela, contra o aro da caixa de
//                               baixo, que faz o assento do empilhamento. Um
//                               chanfro de 45 no lugar dela imprimiria mais
//                               bonito E DEIXARIA A CAIXA DE CIMA SEM APOIO,
//                               afundando até bater nas cartas — o chanfro só
//                               toca o aro depois de passar dele.
//   VEREDITO DA AUDITORIA na malha exportada (área de face virada pra baixo,
//   por faixa de ângulo DA HORIZONTAL): 0-15 graus = 1029mm2 (a aba, e só
//   ela); 15-44 graus = ZERO; 45 exatos = 4230mm2. Ou seja 100% das faces
//   inclinadas estão em 45, que é o mesmo padrão que o original cumpre.
//   1a camada colada na cama: 1739mm2 (moldura de 2.6mm de largura em toda a
//   volta do ressalto + as nervuras da colmeia do piso).
//   O usuário fatia com SUPORTE LIGADO (decisão dele). O modelo não precisa de
//   suporte nenhum; o único lugar em que o fatiador pode querer pôr alguma
//   coisa é embaixo dessa aba, a 3mm da cama — é um anel fino que sai com a
//   unha, mas ele encosta JUSTO na superfície de assento do empilhamento, então
//   se as caixas ficarem bambas empilhadas, o primeiro suspeito é esse resto de
//   suporte, não a geometria. Esta peça pode ser fatiada com suporte desligado.
//   USAR BRIM: 150mm de altura sobre uma primeira camada que é grade de
//   nervura de 1.6mm mais uma moldura de 2.6mm de largura.
//
// EXPORT CANÔNICO (caminhos absolutos; flatpak não enxerga /tmp):
//   STL da peça
//     flatpak run org.openscad.OpenSCAD -o .../stl/penny-holder-01-box.stl \
//       -D 'part="box"' .../penny-holder-01.scad
//   JOBS DE IMPRESSÃO (3mf/ só tem job; footprints medidos com o bbox.py do
//   /bed-check, teto confortável da A1 mini = 170)
//     flatpak run org.openscad.OpenSCAD -o .../3mf/penny-holder-01-plate.3mf \
//       -D 'part="plate"' .../penny-holder-01.scad
//         1 caixa  ->  74.2 x 102.7 x 150.0  (ok)   ~78 cm3, ~97g
//     flatpak run org.openscad.OpenSCAD -o .../3mf/penny-holder-01-par.3mf \
//       -D 'part="par"' .../penny-holder-01.scad
//         2 caixas -> 154.4 x 102.7 x 150.0  (ok)  ~156 cm3, ~194g
//   Nos dois casos a caixa vai com os 102.7 no eixo Y, que é o eixo que a cama
//   da A1 mini balança: é a base MAIOR contra a inércia de uma torre de 150mm.
//   DIAGNÓSTICO (não exportar pra 3mf/)
//     part="fit"    -> empilhado certo:  TEM QUE SAIR VAZIO
//     part="fit180" -> empilhado virado: TEM QUE SAIR NÃO-VAZIO (a chaveta)
//     part="cards"  -> caixa + as duas camadas de carta, pra conferir no render
//
// VARIANTE: por INCLUDE, nunca por -D (os *_override só existem via -D e o
// ternário is_undef() é avaliado antes). Ex.: um arquivo com
//   layers_override = 3; include <penny-holder-01.scad>
// dá a caixa de 3 camadas (216mm — ESTOURA a A1 mini, o assert avisa).
//
// PENDÊNCIA FUNCIONAL, DECLARADA (não é descuido, é o resultado da conta):
// com DUAS camadas e SEM prateleira, a camada de baixo é ARQUIVO, não é a
// camada de trabalho. Tirar uma carta de baixo puxando pela janela deixa uma
// fenda de ~0.5mm embaixo da carta que estava por cima, e essa carta cai
// dentro da fenda (66mm de queda) ou emperra torta. Não existe conserto dentro
// dos 150mm: uma prateleira no meio seria uma PONTE de 69 x 93mm no ar (o
// oposto do item 3 acima) e ainda comeria os 8mm de folga que sobraram. Os
// caminhos honestos são (a) usar a camada de baixo como estoque e a de cima
// como giro; ou (b) imprimir DUAS caixas de uma camada (layers_override = 1,
// 84mm cada) e empilhar — o ressalto e a chaveta existem exatamente pra isso,
// e aí cada camada tem boca própria. Ver ../README.md e o index.json.

/* [Peça] */
// box | plate | par | cards | fit | fit180
part = "box";

/* [Conteúdo — carta com penny sleeve] */
// mm — LARGURA da carta com sleeve (63 nua + sleeve). CATÁLOGO, não é régua. Vira a altura de UMA camada
card_w = is_undef(card_w_override) ? 66 : card_w_override;
// mm — ALTURA da carta com sleeve (88 nua + sleeve). CATÁLOGO, não é régua. Vira a profundidade da caixa
card_h = is_undef(card_h_override) ? 91 : card_h_override;
// mm — espessura de UMA carta com sleeve; só serve pra estimar capacidade, não entra em geometria
card_t = 0.45;
// camadas de carta deitada, uma em cima da outra
layers = is_undef(layers_override) ? 2 : layers_override;
// mm — folga por lado no COMPRIMENTO da carta (Y). 3.25 e não o 1.0 de conteúdo do repo: é o que mantém o footprint 74.2 x 102.7 do modelo de origem (vão 97.5), o que deixa esta caixa empilhar com uma cópia do original e dá espaço pra abrir a pilha em leque. Com 1.0 a caixa fica 98.2 em Y
card_gap_y = 3.25;

/* [Caixa] */
// mm — parede, do piso ao aro (medida na malha de origem)
wall = 2.6;
// mm — vão interno na direção da PILHA; é a profundidade de cartas de cada camada
stack_x = is_undef(stack_x_override) ? 69.0 : stack_x_override;
// mm — profundidade do piso em colmeia; o topo do piso é o peitoril da janela
floor_h = 10.0;
// mm — ar entre o topo da última camada e o aro (paga o ressalto da caixa de cima)
head = 8.0;
// mm — CINTA: faixa maciça que fecha a volta no alto, rente à parede
band = 8.0;
// mm — montante maciço de cada lado da janela da frente; é o flange do canto
front_jamb = 8.0;
// mm — raio dos cantos verticais externos (só conforto de mão)
corner_r = 1.5;

/* [Empilhamento] */
// mm — altura do ressalto que entra na boca da caixa de baixo
lip_h = 3.0;
// mm — folga por lado do ressalto na boca (deslize padrão do repo)
lip_gap = 0.25;
// mm — chanfro de 45 na base do ressalto (tira o pé-de-elefante da superfície de encaixe)
lip_lead = 0.4;
// mm — funil de 45 na boca, pra guiar o ressalto
mouth_lead = 0.6;

/* [Chaveta — só encaixa numa orientação] */
// mm — largura do ressalto de chaveta na boca do fundo
key_w = 36.0;
// mm — quanto a chaveta avança pra DENTRO da boca
key_proj = 1.2;
// mm — folga da chaveta no rasgo, por lado
key_fit = 0.3;
// mm — altura da parte reta da chaveta (tem que cobrir todo o engate do ressalto)
key_pad_h = 6.0;

/* [Colmeia] */
// mm — célula entre faces (medida no piso do modelo de origem)
hex_d = is_undef(hex_d_override) ? 24.0 : hex_d_override;
// graus — inclinação do BICO da célula nas PAREDES, medida da horizontal. 45 e não os 30 do hexágono regular: ver "COLMEIA DE BICO DE 45" no cabeçalho
hex_cap_ang = 45;
// mm — altura da lateral RETA da célula das paredes (o bico entra por cima e por baixo dela)
hex_side = 8.0;
// mm — nervura da colmeia nas PAREDES; 2.6 = espessura da parede, seção quadrada
hex_web = 2.6;
// mm — nervura da colmeia do PISO (medida no modelo de origem)
floor_web = 1.6;
// mm — moldura maciça em volta do piso (medida no modelo de origem)
floor_frame = 3.0;
// mm — faixa maciça entre o campo de colmeia e a borda da parede
border = 4.0;
// mm — faixa maciça nas bordas verticais do fundo (canto traseiro)
back_border = 6.0;

/* [Chapa] */
// mm — vão entre peças na chapa
plate_gap = 6.0;

/* [Oculto] */
$fn = 48;

// ---------------------------------------------------------------- Derivados
inner_x  = stack_x;                       // 69.0  — vão da pilha
inner_y  = card_h + 2 * card_gap_y;       // 97.5  — vão no comprimento da carta
box_x    = inner_x + 2 * wall;            // 74.2
box_y    = inner_y + 2 * wall;            // 102.7
stack_h  = layers * card_w;               // 132   — altura ocupada pelas cartas
box_z    = floor_h + stack_h + head;      // 150   — altura total, com o ressalto
card_top = floor_h + stack_h;             // 142   — topo da carta de cima

lip_x    = inner_x - 2 * lip_gap;         // 68.5
lip_y    = inner_y - 2 * lip_gap;         // 97.0
lip_grip = lip_h - mouth_lead - lip_lead; // 2.0   — engate reto do empilhamento
rim_w    = wall - mouth_lead;             // 2.0   — largura do aro que vira assento
eave_w   = wall;                          // 2.6   — aba do corpo, o outro lado do assento
head_free= head - lip_h;                  // 5.0   — ar sobre a carta com caixa empilhada

win_w    = box_x - 2 * front_jamb;        // 58.2  — vão da janela da frente
win_top  = box_z - band;                  // 142   — bico da água
win_sh   = win_top - win_w / 2;           // 112.9 — ombro (onde começam as águas)
win_h    = win_top - floor_h;             // 132   — altura total do vão
flange   = front_jamb - wall;             // 5.4   — quanto o montante avança na lateral

key_slot_w = key_w + 2 * key_fit;         // 36.6
key_slot_d = key_proj + key_fit;          // 1.5
key_bite   = key_proj - lip_gap;          // 0.95  — interferência se empilhar virado

hex_cap  = hex_d / 2 * tan(hex_cap_ang);  // 12.00 — altura do bico, paredes
hex_cell_h = hex_side + 2 * hex_cap;      // 32.00 — altura da célula das paredes
floor_cap  = hex_d / 2 * tan(30);         // 6.93  — bico do hexágono REGULAR
floor_side = hex_d / sqrt(3);             // 13.86 — lateral do hexágono REGULAR
floor_cell_h = floor_side + 2 * floor_cap;// 27.71 — ponta a ponta, piso
cap_layer= floor(inner_x / card_t);       // ~153  — cartas por camada
cap_total= cap_layer * layers;            // ~306

assert(box_z <= 180, "ALTURA ESTOURA A A1 MINI: floor_h + layers*card_w + head > 180");
assert(box_x <= 170 && box_y <= 170, "FOOTPRINT ESTOURA O ALVO DE 170 DA A1 MINI");
assert(inner_y >= card_h + 2, "a carta nao cabe no comprimento: aumente card_gap_y");
assert(head > lip_h, "a boca precisa de mais ar que o ressalto, senao a caixa de cima aperta a carta");
assert(win_w > 40, "janela estreita demais pra entrar dedo: baixe front_jamb");
assert(key_bite > 0.5, "chaveta sem mordida: empilhar virado ia entrar quase encaixando");
assert(floor_frame > key_slot_d + 1.0, "o rasgo da chaveta come a moldura do piso");

echo(str("penny-holder-01  externo ", box_x, " x ", box_y, " x ", box_z));
echo(str("  vao interno ", inner_x, " x ", inner_y, " x ", box_z - floor_h,
         "   carta ", card_w, " x ", card_h));
echo(str("  camadas ", layers, " x ", card_w, " = ", stack_h,
         "   topo da carta z=", card_top, "   ar acima ", head,
         " (", head_free, " com caixa empilhada)"));
echo(str("  janela ", win_w, " x ", win_h, "  ombro z=", win_sh, "  bico z=", win_top,
         "   cinta ", band, "   montante ", front_jamb, " (flange ", flange, ")"));
echo(str("  ressalto ", lip_x, " x ", lip_y, " x ", lip_h,
         "  folga ", lip_gap, "/lado  engate reto ", lip_grip,
         "  assento ", rim_w, "+", eave_w));
echo(str("  chaveta ", key_w, " x ", key_proj, " em rasgo ", key_slot_w, " x ", key_slot_d,
         "  mordida se virar ", key_bite));
echo(str("  colmeia PAREDE celula ", hex_d, " x ", hex_cell_h, " (bico ", hex_cap_ang,
         " graus, lateral reta ", hex_side, ")  nervura ", hex_web));
echo(str("  colmeia PISO celula ", hex_d, " x ", floor_cell_h,
         " (hexagono regular, bico 30 graus)  nervura ", floor_web));
echo(str("  capacidade estimada ~", cap_total, " cartas (", cap_layer, " por camada a ",
         card_t, "mm) — ESTIMATIVA"));

// -------------------------------------------------------------------- Peças
if      (part == "box")    box();
else if (part == "plate")  box();
else if (part == "par")    for (s = [-1, 1]) translate([s * (box_x + plate_gap) / 2, 0, 0]) box();
else if (part == "cards")  { box(); cards(); }
else if (part == "fit")    stack_check(0);
else if (part == "fit180") stack_check(180);
else                       assert(false, "part desconhecido");

// ------------------------------------------------------------------ Módulos

// A caixa inteira, apoiada em z=0 pelo ressalto de empilhamento e centrada em XY.
module box() {
    union() {
        difference() {
            shell_solid();
            cavity();
            floor_cells();
            side_hexes();
            back_hexes();
            front_window();
            mouth_chamfer();
            key_slot();
        }
        key_pad();
    }
}

// Bloco maciço: ressalto (z 0..lip_h, contorno do encaixe) + corpo (contorno cheio).
module shell_solid() {
    lip_solid();
    translate([0, 0, lip_h]) linear_extrude(box_z - lip_h) outer_2d();
}

// Contorno externo do corpo, com os cantos verticais arredondados.
module outer_2d() {
    offset(r = corner_r, $fn = 32)
        square([box_x - 2 * corner_r, box_y - 2 * corner_r], center = true);
}

// Ressalto de empilhamento com chanfro de entrada de 45 na base.
module lip_solid() {
    hull() {
        linear_extrude(0.01)
            square([lip_x - 2 * lip_lead, lip_y - 2 * lip_lead], center = true);
        translate([0, 0, lip_lead]) linear_extrude(0.01) square([lip_x, lip_y], center = true);
    }
    translate([0, 0, lip_lead]) linear_extrude(lip_h - lip_lead)
        square([lip_x, lip_y], center = true);
}

// Vão interno acima do piso.
module cavity() {
    translate([0, 0, floor_h]) linear_extrude(box_z - floor_h + 1)
        square([inner_x, inner_y], center = true);
}

// Funil de 45 na boca: guia o ressalto da caixa de cima e deixa aro de rim_w.
module mouth_chamfer() {
    hull() {
        translate([0, 0, box_z - mouth_lead]) linear_extrude(0.01)
            square([inner_x, inner_y], center = true);
        translate([0, 0, box_z]) linear_extrude(0.01)
            square([inner_x + 2 * mouth_lead, inner_y + 2 * mouth_lead], center = true);
    }
    translate([0, 0, box_z]) linear_extrude(1)
        square([inner_x + 2 * mouth_lead, inner_y + 2 * mouth_lead], center = true);
}

// Colmeia do piso: atravessa os 10mm, respeitando a moldura perimetral.
// Aqui a célula é o hexágono REGULAR de 24mm medido no modelo de origem — o
// piso é horizontal, não tem teto de furo, então não existe motivo de balanço
// pra deformar a célula.
module floor_cells() {
    translate([0, 0, -1]) linear_extrude(floor_h + 2)
        hex_field(-inner_x / 2 + floor_frame,  inner_x / 2 - floor_frame,
                  -inner_y / 2 + floor_frame,  inner_y / 2 - floor_frame,
                  hex_d, floor_side, floor_cap, floor_web);
}

// Colmeia das DUAS laterais (um só corte atravessando a caixa em X).
module side_hexes() {
    translate([-box_x, 0, 0]) rotate([90, 0, 90]) linear_extrude(2 * box_x)
        hex_field(-box_y / 2 + border, box_y / 2 - front_jamb,
                  floor_h + border,    box_z - band - border,
                  hex_d, hex_side, hex_cap, hex_web);
}

// Colmeia do fundo (corte só na parede de trás).
module back_hexes() {
    translate([0, -inner_y / 2 + 1, 0]) rotate([90, 0, 0]) linear_extrude(wall + 2)
        hex_field(-box_x / 2 + back_border, box_x / 2 - back_border,
                  floor_h + border,         box_z - band - border,
                  hex_d, hex_side, hex_cap, hex_web);
}

// Janela da frente: vão único do peitoril (rente ao piso) ao bico, com as duas
// águas de 45 fechando o topo. É o único rasgo da frente; acima dele, a cinta.
module front_window() {
    translate([0, box_y / 2 + 1, 0]) rotate([90, 0, 0]) linear_extrude(wall + 3)
        polygon([[-win_w / 2, floor_h], [win_w / 2, floor_h],
                 [ win_w / 2, win_sh ], [0, win_top], [-win_w / 2, win_sh]]);
}

// Chaveta: ressalto pra DENTRO na boca do fundo, com rampa de 45 embaixo e
// chanfro no topo (pra não estragar o funil da boca).
module key_pad() {
    y0 = -inner_y / 2;
    zs = box_z - key_pad_h;
    hull() {
        translate([-key_w / 2, y0, zs]) cube([key_w, key_proj, key_pad_h - mouth_lead]);
        // topo EXATAMENTE em box_z: um plate de hull acima disso deixaria uma
        // aresta de 0.01mm passando do aro (pega no bbox e vira sujeira na 1a
        // camada da caixa de cima)
        translate([-key_w / 2, y0, box_z - 0.01]) cube([key_w, key_proj - mouth_lead, 0.01]);
    }
    hull() {  // rampa de 45 embaixo, pra imprimir sem balanço
        translate([-key_w / 2, y0, zs]) cube([key_w, key_proj, 0.01]);
        translate([-key_w / 2, y0, zs - key_proj]) cube([key_w, 0.01, 0.01]);
    }
}

// Rasgo da chaveta no ressalto de empilhamento (só ele quebra a simetria de 180).
module key_slot() {
    translate([-key_slot_w / 2, -lip_y / 2 - 0.5, -0.5])
        cube([key_slot_w, key_slot_d + 0.5, lip_h + 0.5]);
}

// Uma célula da colmeia: hexágono de PONTA PRA CIMA, `w` entre faces, lateral
// reta de `s` e bico de `c` de altura em cima e embaixo. Com c = w/2 o bico é
// de 45 graus; com c = w/(2*sqrt(3)) sai o hexágono REGULAR (bico de 30).
module hex_cell(w, s, c) {
    polygon([[ w / 2,  s / 2], [0,  s / 2 + c], [-w / 2,  s / 2],
             [-w / 2, -s / 2], [0, -(s / 2 + c)], [ w / 2, -s / 2]]);
}

// Colmeia cobrindo o retângulo [u0,u1] x [v0,v1] do plano local, furos
// atravessando a extrusão. Só entra célula cujo CENTRO cai dentro do retângulo,
// e o furo é recortado por ele: o menor furo é ~meia célula (nunca um
// furo-lasca) e o material que sobra na borda é a faixa maciça de fora, nunca
// uma aleta fina — regra 4 do repo, "sem lascas".
// O passo dy sai de exigir nervura `web` também na costura DIAGONAL (a fileira
// de cima entra deslocada dx/2): projetando a distância entre centros na normal
// do flanco do bico. Confere no caso regular: dá dy = 0.866*dx.
module hex_field(u0, u1, v0, v1, w, s, c, web) {
    dx = w + web;
    dy = 2 * c + s + 2 * web * sqrt(c * c + w * w / 4) / w - c * dx / w;
    uc = (u0 + u1) / 2;
    vc = (v0 + v1) / 2;
    ni = ceil((u1 - u0) / dx) + 1;
    nj = ceil((v1 - v0) / dy) + 1;
    intersection() {
        translate([u0, v0]) square([u1 - u0, v1 - v0]);
        union() {
            for (j = [-nj : nj], i = [-ni : ni]) {
                cu = uc + i * dx + (j % 2 == 0 ? 0 : dx / 2);
                cv = vc + j * dy;
                if (cu >= u0 && cu <= u1 && cv >= v0 && cv <= v1)
                    translate([cu, cv]) hex_cell(w, s, c);
            }
        }
    }
}

// As camadas de carta, do jeito que ficam guardadas (diagnóstico/render).
module cards() {
    for (k = [0 : layers - 1])
        translate([0, 0, floor_h + k * card_w])
            linear_extrude(card_w) square([inner_x - 1, card_h], center = true);
}

// Duas caixas empilhadas. rot=0 -> orientação certa, TEM QUE SAIR VAZIO.
// rot=180 -> caixa de cima virada, TEM QUE SAIR NÃO-VAZIO (a chaveta barrando).
module stack_check(rot) {
    intersection() {
        box();
        translate([0, 0, box_z - lip_h]) rotate([0, 0, rot]) box();
    }
}
