// sleeve-tower-01.scad
//
// TORRE de penny sleeves DEITADOS: bandeja aberta em cima, 75 x 102.5 x 150mm,
// com três paredes maciças (duas laterais + fundo), a frente aberta num SULCO
// vertical que vai do piso ao topo e duas ABAS EM L nos cantos da frente que
// seguram a pilha. Piso de 10mm que é lastro e, embaixo dele, um RESSALTO de
// empilhamento — a torre de cima senta na boca da de baixo.
//
// COMO SE MANUSEIA (é uma torre de bancada, não uma caixa de deck):
//   1. A torre fica DE PÉ na mesa, com o sulco virado pra você. O sleeve entra
//      DEITADO (os 66 no eixo X, os 91 no eixo Y) e a pilha cresce em Z: são
//      140mm de curso, do piso (z=10) até a boca (z=150).
//   2. ABASTECER: pela BOCA, que é aberta e livre nos 69.0 x 99.5 inteiros —
//      nada estrangula a entrada, você despeja o maço de sleeves de cima.
//   3. TIRAR: pelo SULCO da frente. Você enfia dois dedos nos 50mm de vão, na
//      altura do topo da pilha, pinça o sleeve e puxa pra frente. O sleeve tem
//      66.7 de largura e o sulco tem 50, então ele NÃO sai reto: ele passa
//      arqueando entre as duas abas — que é exatamente o que impede a pilha
//      inteira de escorregar pra fora quando você puxa um. Ver a nota
//      "SLEEVE VAZIO x CARTA ENSLEEVADA" mais abaixo, porque isso muda tudo.
//   4. EMPILHAR: a torre de cima desce na boca da de baixo. O ressalto de 3mm
//      entra na boca com 0.4/lado e a torre assenta no aro. Sulco com sulco:
//      não foi desenhada chaveta nenhuma, mas o ressalto é assimétrico em Y
//      (rente na frente, recuado 0.4 atrás) e isso já trava — virada 180 graus
//      ela bate no fundo e fica boiando 3mm alta, óbvio na mão. Duas empilhadas
//      dão 297mm de coluna, não 300: a de cima afunda os 3mm do ressalto.
//
// DE ONDE VEIO, E POR QUE ESTE ARQUIVO NÃO É O ORIGINAL
// Referência de geometria: `../PennySleeveHolderStacking_V2.3mf`
// ("Stackable Penny Sleeve Holder", Sazabi, MakerWorld, MakerWorld Exclusive
// License — arquivo de TERCEIRO, NÃO redistribuível; é por essa família de
// licenças que o repo virou privado em 2026-08-09). Este .scad é reconstrução
// paramétrica própria: nada da malha foi copiado, só medidas de engenharia
// reversa. Medido na malha da variante Stackable (3D/Objects/object_1.model,
// 296 vértices, origem no centro do bbox):
//   envelope 73.00 x 101.50 x 45.00  (x ±36.50, y ±50.75, z ±22.50)
//   parede 2.00 nas laterais (face interna x ±34.50 -> vão 69.00)
//   parede 2.00 no fundo (face interna y = 48.75 -> vão 99.50)
//   piso: topo da cavidade em z = 10.00 (níveis de z: 0, 3, 10, ...)
//   ressalto de empilhamento z 0..3, contorno 68.6 x 99.3 (0.2/lado de folga)
//   abas em L: y -50.75..-47.25 (3.5 de profundidade), aresta interna em
//     x = ±25.00 na FACE DA FRENTE, abrindo em filete até ±28.83 no fundo da
//     aba -> o vão do sulco na cara da peça é 50.00 = 68.5% dos 73.0
//   quinas verticais externas e arestas do sulco arredondadas em r ≈ 1.0
//
// O QUE MUDA NESTA VARIANTE (tudo decidido com o usuário)
//   1. ALTURA 45 -> 150. O piso segue com 10.0, então a cavidade vai de 35 pra
//      140mm de curso de pilha. Piso pesado é bem-vindo: é o lastro que segura
//      uma peça de 150mm de pé (ver ESTABILIDADE).
//   2. PAREDE 2.0 -> 3.0, CRESCENDO PRA FORA. A 150mm de altura uma parede de
//      2mm empena e é mole. Os 3mm saem do envelope externo (73.0 -> 75.0 em X
//      e 101.5 -> 102.5 em Y), NUNCA da cavidade: com 3mm pra dentro o vão
//      cairia pra 67.0 e um penny sleeve de ~66.7 não entraria mais.
//   3. PAREDE MACIÇA — PEDIDO LITERAL DO USUÁRIO. Sem colmeia, sem furo, sem
//      baixo relevo. Isto SOBREPÕE a regra 5 (identidade visual hexagonal) do
//      CLAUDE.md, de propósito e por escrito, não é esquecimento. O preço está
//      medido e declarado embaixo, em MATERIAL E TEMPO.
//   4. SULCO = 2/3 DA LARGURA, do piso ao topo, sem travessa nenhuma. Com o
//      externo de 75.0 dá 50.0mm exatos — que por coincidência é o mesmo vão
//      que a referência tem na cara da peça.
//   5. ABAS MAIORES: retorno de 9.5mm pra dentro da face interna da lateral,
//      contra os 7.25 da referência. Não é número escolhido, é consequência do
//      item 4: sulco de 50 (x ±25) com a face interna da lateral em x ±34.5 dá
//      34.5 - 25.0 = 9.5 de retorno. Mais aba = pilha mais presa.
//   6. FOLGA DO RESSALTO 0.2 -> 0.4/LADO, com chanfro de entrada de 0.8. Regra
//      6 do CLAUDE.md, aprendida no deckbox-02 impresso, que TRAVOU no meio do
//      curso: peça alta impressa em pé faz barriga pra dentro, a boca sai
//      subdimensionada, o sólido sai superdimensionado e ainda tem pé de
//      elefante. Aos 150mm isso é pior que aos 45 da referência.
//   7. ABA CORTADA NO TOPO. O retorno da aba em L para 3.4mm abaixo da boca
//      (z=146.6) — ver ABA CORTADA NO TOPO, é o que deixa o ressalto ser um
//      prisma limpo e mata o pior balanço da peça.
//
// ATENÇÃO — A MEDIDA DO SLEEVE NÃO É DE RÉGUA
// A cavidade 69.0 x 99.5 NÃO foi medida no sleeve do usuário: ela veio da
// malha da referência, que é peça impressa e aprovada por terceiros. É a mesma
// ressalva que o README de organizadores_tcg faz pro penny-holder-01. Vale
// como ponto de partida (peça impressa que funciona > catálogo), mas o dia em
// que o sleeve for medido com régua, a correção é um include de 3 linhas:
//   cav_w_override = <largura + 2>; cav_d_override = <altura + 2>;
//   include <sleeve-tower-01.scad>
// e o modelo inteiro se refaz — externo, sulco, abas e ressalto são todos
// derivados desses dois números.
//
// SLEEVE VAZIO x CARTA ENSLEEVADA (a cinemática de tirar, com número)
// O sulco tem 50.0mm e o conteúdo tem ~66.7 de largura: 16.7mm a menos, 8.35
// de mordida em cada aba. Isso quer dizer que:
//   - SLEEVE VAZIO (filme mole): sai pelo sulco arqueando, sem esforço. É pra
//     isso que a peça existe e é o que a referência faz.
//   - CARTA JÁ ENSLEEVADA (rígida, a carta não dobra): NÃO passa pelo sulco.
//     Sai pela BOCA, por cima — que é aberta e livre. O sulco vira janela de
//     ver o nível da pilha e de empurrar a pilha pra cima com o dedo.
// Nenhuma das duas é defeito, mas é bom saber qual das duas você comprou antes
// de encher a torre. Quem quiser a carta enseleevada saindo pela frente tem que
// abrir o sulco pra ~70 (open_frac_override = 0.93) e aí perde a aba.
//
// ABA CORTADA NO TOPO (por que o retorno para em z=146.6)
// O ressalto da torre de cima ocupa os 3mm de cima da cavidade da torre de
// baixo. Se a aba em L subisse até a boca, o ressalto teria que ser recortado
// em volta dela — e esse recorte deixaria, na cara da frente, dois trechos de
// 12.9 x 3.9mm de laje horizontal boiando no ar em z=3 (é o que a referência
// faz; o perfil dela vem com suporte LIGADO). Cortar 3.4mm do RETORNO da aba
// (só do retorno: a parede lateral sobe inteira até 150) resolve os dois lados:
//   - o ressalto vira um prisma retangular limpo, rente à frente, sem recorte;
//   - o único balanço que sobra na peça é o degrau de 1.2mm do assento.
// O que se perde: os 3.4mm de cima da pilha ficam sem aba na frente. Não custa
// nada — com uma torre empilhada em cima, esses 3mm estão ocupados pelo
// ressalto dela, e sem torre em cima a pilha nunca chega rente à boca.
//
// ASSENTO DO EMPILHAMENTO — O PROBLEMA DA SAIA, E COMO FOI RESOLVIDO
// Parede 3.0 + folga 0.4 = 3.4mm de saia em volta do ressalto, a 3mm da mesa
// (na referência eram 2.2). 3.4mm de laje horizontal saindo do nada é balanço
// puro: a camada de z=3 avançaria 3.4mm de uma vez sobre o vazio e a superfície
// que pende é justamente a que faz o assento do empilhamento. Foram avaliadas
// três saídas:
//   (a) degrau reto de 3.4 ....... assento perfeito, superfície pendurada feia
//                                  e ondulada — e ondulação no assento é torre
//                                  balançando.
//   (b) chanfro de 45 puro ....... imprime lindo e NÃO TEM ASSENTO: a torre de
//                                  cima escorregaria na rampa até cunhar na
//                                  aresta interna do aro, abrindo a parede.
//   (c) ADOTADA: 1.2mm de ledge plano + 2.2mm a 45. O ledge dá um assento
//                                  definido e o resto sobe em rampa. O balanço
//                                  cai de 3.4 pra 1.2mm — quase metade do que
//                                  a referência já imprime hoje.
// O aro da torre de baixo tem 3.0 de largura (x 34.5..37.5); o ledge da de cima
// pousa em x 34.1..35.3. Sobreposição REAL de contato = 0.8mm num anel contínuo
// em U de ~276mm de perímetro = ~220mm² de apoio. Pra uma torre cheia (~2.5N)
// dá ~0.011MPa: o assento é geométrico, não estrutural, e 0.8mm contínuo é
// assento de sobra. Por isso também NÃO existe funil na boca: um funil de 0.6
// comeria justo esses 0.8 e o assento sumiria. Quem guia o encaixe é o chanfro
// de 0.8 embaixo do ressalto, sozinho.
//
// CURSO COMPLETO DO EMPILHAMENTO (simulado com número antes de dar por bom —
// lição do elevador do deckbox-01, que tinha 10mm de vão pra 48mm de curso):
//   separação 3.00mm .. a base do ressalto (66.6 x 97.5, já descontado o
//                       chanfro) procura a boca (69.0 x 99.5). Aceita 1.2mm de
//                       erro lateral de mão em X — é a folga de 0.4 mais o
//                       chanfro de 0.8.
//   separação 2.20mm .. o chanfro de 45 termina e entra o RETO. Daqui pra baixo
//                       são 2.2mm de engate reto com 0.4/lado: a torre já está
//                       alinhada e só desce.
//   separação 0.00mm .. assenta. O batente é o LEDGE de 1.2mm da torre de cima
//                       contra o ARO de 3.0 da de baixo (0.8mm de contato real),
//                       nunca o fundo do ressalto contra sleeve.
//   com a torre cheia . o ressalto desce até z=147 da torre de baixo, ou seja
//                       come os 3mm de cima da cavidade: o curso útil vira 137
//                       (e não 140) quando há torre empilhada em cima. Encher
//                       além disso não trava nada — só levanta a torre de cima.
//   PROVAS NA GEOMETRIA (rodadas, não deduzidas):
//     part="fit" (passo 147) ....... VAZIO. Encaixa sem tocar em nada.
//     passo 146 (1mm fundo demais) . 382mm³ de interferência em z 146..150. É
//                                    o assento parando a descida — o teste tem
//                                    dente, não é vazio por acidente.
//     virada 180 graus ............. 589mm³ em y 48.05..51.25, z 147..150: o
//                                    ressalto bate no FUNDO, 3mm de mordida na
//                                    largura inteira. Não existe chaveta neste
//                                    modelo, mas o contorno assimétrico do
//                                    ressalto (rente na frente, recuado atrás)
//                                    já é uma: empilhar virado não entra nem
//                                    "quase", a torre fica boiando 3mm alta.
//
// ESTABILIDADE (é o preço de 150mm, e o usuário aceitou de olho aberto)
// Centro de massa MEDIDO na malha exportada: (0, 4.85, 52.11) — o piso de 10mm
// é 37% do material e puxa tudo pra baixo. Uma torre sozinha tomba com
//   35.7 graus pro lado | 47.1 pra frente | 41.7 pra trás — estável de verdade.
// DUAS EMPILHADAS: 297mm de coluna (o passo é 147, não 150 — a de cima afunda
// os 3mm do ressalto), centro de massa em z=125.6, e o ângulo despenca pra
//   16.6 graus pro lado | 24.1 pra frente | 20.3 pra trás.
// E isso VAZIA: cheia, o conteúdo sobe o centro de massa mais ainda. Duas
// empilhadas é uma coluna que um esbarrão derruba — usar encostada na parede ou
// na prateleira, não solta no meio da mesa.
//
// MATERIAL E TEMPO (o preço da parede maciça, item 3)
// 197.3cm³ de SÓLIDO, medido na malha exportada. Só as três paredes são 115cm³:
// 3.0 x 150 x (2 x 102.5 + 69). Fatiado com 2 perímetros e 15% de grade a
// estimativa é ~120cm³ de filamento (~150g) e ~7h — é peça grande, não é
// impressão de tarde, e o número real quem dá é o fatiador. Pra comparar: o
// penny-holder-01, mesmo envelope de 150mm mas todo em colmeia, tem 78cm³.
// Se incomodar, os botões honestos são, nesta ordem:
//   - baixar wall pra 2.6 (o mesmo do penny-holder-01) -> ~-20cm³;
//   - baixar a altura (total_h_override = 100) -> a peça inteira encolhe;
//   - NÃO mexer no infill do piso pra baixo: ali o peso é feature, é o lastro.
// Colmeia resolveria de verdade, e é justamente o que o usuário não quer.
//
// IMPRIME EM PÉ, NA ORIENTAÇÃO DE USO, SEM SUPORTE. Inventário de balanço:
//   ressalto (z 0..3) .......... prisma vertical na mesa, 6.7 mil mm² de 1ª
//                                camada maciça. Não precisa de brim.
//   chanfro do ressalto ........ 45 graus com o material CRESCENDO pra fora
//                                subindo: cada camada apoia na de baixo.
//   ledge do assento (z=3) ..... 1.2mm de laje horizontal em anel — ÚNICO
//                                balanço plano da peça. Fica a 3mm da mesa.
//   saia (z 3..5.2) ............ 45 graus.
//   paredes .................... verticais, maciças, dos 3mm de espessura.
//   abas em L .................. prismas verticais, arrancam do piso em z=10.
//   topo das abas (z=146.6) .... face horizontal virada pra CIMA, não é balanço.
//   piso da cavidade (z=10) .... face horizontal virada pra cima.
//   NENHUMA PONTE em lugar nenhum: a frente é aberta do piso ao topo e não há
//   uma única travessa horizontal na peça.
//
// EXPORTS CANÔNICOS (caminhos absolutos, flatpak — ver CLAUDE.md):
//   flatpak run org.openscad.OpenSCAD -o stl/sleeve-tower-01.stl        -D 'part="tower"' sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-plate.3mf  -D 'part="plate"' sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-par.3mf    -D 'part="par"'   sleeve-tower-01.scad
//   DIAGNÓSTICO (não vai pra 3mf/):
//     part="fit"    -> as duas torres empilhadas: TEM QUE SAIR VAZIO
//     part="stack2" -> as duas empilhadas em união, só pra render
//
// VARIANTE: por INCLUDE, nunca por -D (os *_override só existem via -D e o
// ternário is_undef() é avaliado antes). Ex.: um arquivo com
//   total_h_override = 100; include <sleeve-tower-01.scad>
// dá a torre de 100mm com todo o resto igual.

/* [Peça] */
// tower | plate | par | fit | stack2
part = "tower";

/* [Cavidade — o que a torre guarda] */
// mm — vão interno em X, a LARGURA do sleeve deitado. 69.0 = medida de engenharia reversa da referência impressa, NÃO é régua (ver o aviso no cabeçalho). NUNCA estreitar: parede mais grossa cresce pra fora
cav_w = is_undef(cav_w_override) ? 69.0 : cav_w_override;
// mm — vão interno em Y, o COMPRIMENTO do sleeve deitado. Mesma origem e mesma ressalva do cav_w
cav_d = is_undef(cav_d_override) ? 99.5 : cav_d_override;
// mm — espessura de UM penny sleeve vazio; só serve pra estimar capacidade, não entra em geometria nenhuma
sleeve_t = 0.08;

/* [Envelope] */
// mm — altura total da torre, do chão do ressalto à boca. 150 = pedido do usuário ("as paredes sobem até 15cm")
total_h = is_undef(total_h_override) ? 150.0 : total_h_override;
// mm — parede MACIÇA das duas laterais e do fundo. 3.0 e não os 2.0 da referência porque a 150mm de altura 2mm empena; cresce pra FORA, o vão interno não muda
wall = is_undef(wall_override) ? 3.0 : wall_override;
// mm — piso total, do chão ao fundo da cavidade (inclui o ressalto). É o lastro que segura a torre em pé
floor_h = 10.0;

/* [Frente — o sulco e as abas em L] */
// fração da largura EXTERNA que o sulco ocupa. 2/3 = pedido do usuário; com o externo de 75.0 dá 50.0mm de vão
open_frac = is_undef(open_frac_override) ? 2 / 3 : open_frac_override;
// mm — profundidade da aba em L no eixo Y (medida na referência)
tab_depth = is_undef(tab_depth_override) ? 3.5 : tab_depth_override;

/* [Empilhamento] */
// mm — altura do ressalto que entra na boca da torre de baixo (medida na referência)
boss_h = 3.0;
// mm — folga do ressalto na boca, POR LADO. 0.4 e não os 0.2 da referência: regra 6 do CLAUDE.md, lição do deckbox-02 que travou. Peça de 150mm em pé empena mais que uma de 45
stack_clear = is_undef(stack_clear_override) ? 0.4 : stack_clear_override;
// mm — chanfro de 45 na aresta de baixo do ressalto. É ele sozinho que guia o encaixe (não há funil na boca, ele comeria o assento): aceita stack_clear + este valor de erro de mão
boss_lead = 0.8;
// mm — largura do LEDGE plano do assento, em volta do ressalto. O resto da saia sobe em rampa de 45. Tem que ser MENOR que wall + stack_clear, senão a rampa fura a face externa
seat_ledge = 1.2;

/* [Acabamento] */
// mm — raio das quinas verticais externas e das arestas do sulco (medido na referência; é o que a mão pega)
corner_r = 1.0;
// mm — raio dos cantos verticais internos da cavidade (só tira o canto vivo; o bico da impressora já arredonda sozinho)
inner_r = 1.0;

/* [Chapa] */
// mm — vão entre peças em part="par"
plate_gap = 6.0;

/* [Oculto] */
$fn = 48;

// ---------------------------------------------------------------- Derivados
ext_w      = cav_w + 2 * wall;              // 75.0  — externo em X (parede dos DOIS lados)
ext_d      = cav_d + wall;                  // 102.5 — externo em Y (parede só no fundo, a frente é aberta)
cav_h      = total_h - floor_h;             // 140.0 — curso da pilha, do piso à boca
slab_h     = floor_h - boss_h;              // 7.0   — laje cheia acima do ressalto

y_front    = -ext_d / 2;                    // -51.25 — plano da frente
y_back     =  ext_d / 2;                    //  51.25 — plano do fundo
y_cav_back =  y_back - wall;                //  48.25 — face interna do fundo
x_wall_in  =  cav_w / 2;                    //  34.50 — face interna da lateral

open_w     = ext_w * open_frac;             // 50.0  — vão do sulco
x_open     = open_w / 2;                    // 25.0  — aresta interna da aba
tab_return = x_wall_in - x_open;            // 9.5   — quanto a aba avança pra dentro da lateral
tab_x_out  = ext_w / 2 - corner_r;          // 36.5  — a aba morre dentro da parede lateral
tab_top    = total_h - boss_h - stack_clear;// 146.6 — o retorno da aba para aqui (ver ABA CORTADA NO TOPO)

boss_w     = cav_w - 2 * stack_clear;       // 68.2  — ressalto em X
boss_yb    = y_cav_back - stack_clear;      // 47.85 — fundo do ressalto (a frente é rente ao plano da frente)
boss_d     = boss_yb - y_front;             // 99.1  — ressalto em Y
boss_cy    = (y_front + boss_yb) / 2;       // -1.70 — centro do ressalto em Y
boss_grip  = boss_h - boss_lead;            // 2.2   — engate RETO do empilhamento
boss_catch = stack_clear + boss_lead;       // 1.2   — erro lateral de mão aceito na hora de empilhar
stack_pitch= total_h - boss_h;              // 147.0 — passo do empilhamento: a torre de cima
                                            //         AFUNDA boss_h na de baixo, então duas
                                            //         empilhadas dão 297 e não 300

seat_w     = boss_w + 2 * seat_ledge;       // 70.6  — contorno do assento em X
seat_yb    = boss_yb + seat_ledge;          // 49.05 — contorno do assento no fundo
seat_d     = seat_yb - y_front;             // 100.3
seat_cy    = (y_front + seat_yb) / 2;       // -1.10
skirt_ramp = wall + stack_clear - seat_ledge; // 2.2 — rampa de 45 da saia (igual em X e Y por construção)
skirt_top  = boss_h + skirt_ramp;           // 5.2   — onde o externo cheio começa
// o aro da torre de baixo vai de x_wall_in a ext_w/2 (largura wall) e o ledge
// da de cima de boss_w/2 a seat_w/2: a sobreposição real é seat_ledge - stack_clear
seat_grip  = seat_ledge - stack_clear;      // 0.8   — largura de contato REAL do ledge sobre o aro

cav_h_stacked = cav_h - boss_h;             // 137.0 — curso útil com torre empilhada em cima
cap_loose  = floor(cav_h / sleeve_t);       // ~1750 — ESTIMATIVA, sleeve_t não é régua
cap_stacked= floor(cav_h_stacked / sleeve_t);

assert(total_h <= 220, "ALTURA ESTOURA A AD5X (220)");
assert(ext_w <= 170 && ext_d <= 170, "FOOTPRINT ESTOURA O ALVO DE 170 DA AD5X");
assert(seat_ledge < wall + stack_clear, "seat_ledge grande demais: a rampa da saia fura a face externa");
assert(seat_grip > 0.4, "assento de menos: o ledge nao pousa no aro da torre de baixo");
assert(boss_grip > 1.0, "engate reto de menos: baixe boss_lead ou suba boss_h");
assert(tab_return > 4.0, "aba curta demais pra segurar a pilha: baixe open_frac");
assert(open_w > 40.0, "sulco estreito demais pra entrar dois dedos: suba open_frac");
assert(skirt_top < floor_h, "a rampa da saia invade a cavidade: baixe wall ou suba floor_h");
assert(tab_depth > 2 * corner_r, "aba mais rasa que os dois raios de canto");

echo(str("sleeve-tower-01  externo ", ext_w, " x ", ext_d, " x ", total_h, " mm"));
echo(str("  cavidade ", cav_w, " x ", cav_d, " x ", cav_h,
         "   piso ", floor_h, " (ressalto ", boss_h, " + laje ", slab_h, ")"));
echo(str("  sulco ", open_w, " mm (", open_frac * 100, "% do externo) do piso ao topo",
         "   aba ", tab_depth, " de fundura, retorno ", tab_return,
         ", topo em z=", tab_top));
echo(str("  ressalto ", boss_w, " x ", boss_d, " x ", boss_h,
         "  folga ", stack_clear, "/lado  chanfro ", boss_lead,
         "  engate reto ", boss_grip, "  aceita ", boss_catch, " de erro de mao"));
echo(str("  assento: ledge ", seat_ledge, " + rampa ", skirt_ramp,
         " a 45 (externo cheio a partir de z=", skirt_top, ")",
         "  contato real sobre o aro ", seat_grip, " mm"));
echo(str("  passo do empilhamento ", stack_pitch,
         " mm -> duas torres = ", 2 * stack_pitch + boss_h, " mm de coluna"));
echo(str("  curso de pilha ", cav_h, " mm solta / ", cav_h_stacked,
         " com torre empilhada  -> ~", cap_loose, " / ~", cap_stacked,
         " sleeves vazios a ", sleeve_t, "mm — ESTIMATIVA, nao e regua"));

// -------------------------------------------------------------------- Peças
if      (part == "tower")  tower();
else if (part == "plate")  tower();
else if (part == "par")    for (s = [-1, 1]) translate([s * (ext_w + plate_gap) / 2, 0, 0]) tower();
else if (part == "fit")    fit_check();
else if (part == "stack2") { tower(); translate([0, 0, stack_pitch]) tower(); }
else                       assert(false, "part desconhecido");

// ------------------------------------------------------------------ Módulos

// A torre inteira, apoiada em z=0 pelo ressalto e centrada em X.
// As abas entram DEPOIS do corte da cavidade — elas moram dentro do vão dela.
module tower() {
    union() {
        difference() {
            union() { stack_boss(); body_shell(); }
            cavity();
        }
        front_tabs();
    }
}

// Prisma de canto arredondado, centrado em XY, nascendo em z=0.
module rrect(w, d, r, h) {
    hull() for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * (w / 2 - r), sy * (d / 2 - r), 0])
            cylinder(h = h, r = r);
}

// Ressalto de empilhamento (z 0..boss_h): prisma reto com chanfro de 45 na
// aresta de baixo. Rente ao plano da frente, recuado stack_clear no fundo e
// nos dois lados. É também a 1ª camada da impressão — maciça, sem brim.
// Os 0.02 a mais no topo entram POR DENTRO do corpo (68.2 contra os 70.6 do
// assento): não mudam nada por fora e são o que faz o CGAL fundir ressalto e
// corpo num sólido só — encostados só na face, saíam como dois volumes.
module stack_boss() {
    c = boss_lead;
    hull() {
        translate([0, boss_cy, 0])
            rrect(boss_w - 2 * c, boss_d - 2 * c, max(corner_r - c, 0.2), 0.01);
        translate([0, boss_cy, c])
            rrect(boss_w, boss_d, corner_r, boss_h - c + 0.02);
    }
}

// Corpo maciço (z boss_h..total_h), ainda sem cavidade: o assento (ledge plano
// de seat_ledge) em z=boss_h, a rampa de 45 subindo até skirt_top e daí pra
// cima o prisma externo cheio. Na FRENTE não há rampa nenhuma — o ressalto é
// rente ao plano da frente, então ali não existe saia pra pender.
module body_shell() {
    hull() {
        translate([0, seat_cy, boss_h])   rrect(seat_w, seat_d, corner_r, 0.01);
        translate([0, 0,      skirt_top]) rrect(ext_w,  ext_d,  corner_r, 0.01);
    }
    translate([0, 0, skirt_top]) rrect(ext_w, ext_d, corner_r, total_h - skirt_top);
}

// Cavidade: do topo do piso (z=floor_h) até acima da boca, saindo pela FRENTE.
// É o mesmo corte que abre o sulco — a frente não tem parede nenhuma pra furar.
module cavity() {
    over = 20;                                   // avanço pra fora da frente
    d    = (y_cav_back - (y_front - over));
    translate([0, y_cav_back - d / 2, floor_h])
        rrect(cav_w, d, inner_r, cav_h + 1);
}

// As duas abas em L da frente. Cada uma é o RETORNO da lateral pra dentro:
// nasce no piso (z=floor_h) e para em tab_top, 3.4mm abaixo da boca, pra deixar
// passar o ressalto da torre empilhada (ver ABA CORTADA NO TOPO no cabeçalho).
// A aresta interna, que é a que a mão encosta ao puxar o sleeve, sai com
// corner_r de raio.
module front_tabs() {
    for (s = [-1, 1]) scale([s, 1, 1]) tab();
}

module tab() {
    w = tab_x_out - x_open;
    translate([(x_open + tab_x_out) / 2, y_front + tab_depth / 2, floor_h])
        rrect(w, tab_depth, corner_r, tab_top - floor_h);
}

// PROVA DE ENCAIXE: as duas torres empilhadas na orientação de uso, com o passo
// REAL (stack_pitch = 147), que é o que enfia o ressalto da de cima nos 3mm de
// cima da cavidade da de baixo. TEM QUE SAIR VAZIO — se sair sólido, o ressalto
// está batendo em alguma coisa (o suspeito nº1 é o retorno da aba em L, que é
// justamente por isso que ele para em tab_top).
module fit_check() {
    intersection() {
        tower();
        translate([0, 0, stack_pitch]) tower();
    }
}
