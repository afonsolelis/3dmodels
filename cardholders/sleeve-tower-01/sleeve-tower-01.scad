// sleeve-tower-01.scad
//
// TORRE de cartas/penny sleeves DEITADOS com TAMPA DESLIZANTE: 78 x 102.5 x
// 150mm (75 de corpo + cinta de 1.5 por lado no topo), três paredes maciças
// (duas laterais + fundo), a frente aberta num SULCO vertical de 50mm que
// fecha em ARCO DE 45 (ponta pra cima) numa TRAVESSA logo abaixo da boca, duas
// ABAS EM L nos cantos da frente que seguram a pilha, piso de 10mm que é
// lastro e, embaixo dele, um RESSALTO de empilhamento. A tampa é uma chapa
// inteira de 2.6 que corre em CANALETAS nas laterais, estilo estojo: entra
// pela frente e bate no fundo. SEM TRAVA (ver TAMPA DESLIZANTE).
//
// COMO SE MANUSEIA (é uma torre de bancada, não uma caixa de deck):
//   1. A torre fica DE PÉ na mesa, sulco virado pra você. A carta entra
//      DEITADA (66.7 no X, ~91 no Y) e a pilha cresce em Z: 133.9mm de curso
//      útil, do piso (z=10) até o fundo da tampa (z=143.9).
//   2. ABRIR: ponta do dedo em cima da tampa, perto da frente (ela fica 3.5
//      abaixo do aro), e arrasta pra você. A tampa desliza 99.3mm até sair.
//      Não tem puxador: pedido do usuário ("não precisa de puxador").
//   3. ABASTECER / TIRAR: pela BOCA, aberta nos 69.0 x 99.5 inteiros. Carta já
//      ensleevada é rígida e NÃO passa pelo sulco (66.7 de carta contra 50 de
//      vão): a boca é a única saída, e é por isso que existe a tampa. O sulco
//      é janela de ver o nível da pilha (e, com sleeve VAZIO, filme mole, dá
//      pra tirar arqueando entre as abas como na referência). A carta do FUNDO
//      da pilha só sai virando a torre (com a tampa aberta, mão na boca).
//   4. FECHAR: encosta a tampa (chanfro de baixo pra trás e pra baixo) na boca das
//      canaletas na cara da frente e empurra até bater no fundo.
//   5. EMPILHAR (com a tampa fechada ou não): a torre de cima desce na boca da
//      de baixo. O ressalto de 3mm entra com 0.4/lado e assenta no aro; a tampa
//      de baixo fica 0.5 abaixo do ressalto e não encosta. Assimétrico em Y
//      (rente na frente, recuado atrás): virada 180 graus ela bate no fundo e
//      fica 3mm alta. Duas empilhadas dão 297mm de coluna (passo 147).
//   ATENÇÃO, SEM TRAVA: a tampa é presa PRA CIMA pelo trilho, mas pode
//   DESLIZAR PRA FORA PELA FRENTE se a torre for inclinada pra frente ou
//   ficar de cabeça pra baixo. Carregar de pé, ou com a mão sobre a frente.
//
// DE ONDE VEIO, E POR QUE ESTE ARQUIVO NÃO É O ORIGINAL
// Referência de geometria: `../PennySleeveHolderStacking_V2.3mf`
// ("Stackable Penny Sleeve Holder", Sazabi, MakerWorld, MakerWorld Exclusive
// License — arquivo de TERCEIRO, NÃO redistribuível, removido do repo em
// 2026-08-28). Este .scad é reconstrução paramétrica própria: nada da malha foi
// copiado, só medidas de engenharia reversa (object_1.model, 296 vértices):
//   envelope 73.00 x 101.50 x 45.00, parede 2.00, cavidade 69.00 x 99.50,
//   piso 10.00, ressalto z 0..3 de 68.6 x 99.3 (0.2/lado), abas em L de 3.5
//   de fundura com aresta interna em x ±25.00, quinas r ≈ 1.0.
//
// O QUE MUDA EM RELAÇÃO À REFERÊNCIA (tudo decidido com o usuário)
//   1. ALTURA 45 -> 150. Piso segue com 10.0 (é o lastro).
//   2. PAREDE 2.0 -> 3.0, CRESCENDO PRA FORA (73 -> 75 em X, 101.5 -> 102.5 em
//      Y). Pra dentro, a cavidade cairia pra 67.0 e a carta de 66.7 não entraria.
//   3. PAREDE MACIÇA — PEDIDO LITERAL DO USUÁRIO. Sem colmeia, sem furo. Isto
//      SOBREPÕE a regra 5 do CLAUDE.md de propósito. A tampa segue igual: lisa.
//      O único aceno à identidade é o ARCO DE 45 de ponta pra cima no topo do
//      sulco — e ele está lá porque é o jeito de fechar o sulco SEM PONTE.
//   4. SULCO = 2/3 DO EXTERNO DO CORPO = 50.0mm, do piso até z=115.3, e daí
//      fecha em arco de 45 até a ponta em z=140.3.
//   5. ABAS com retorno de 9.5 (consequência do sulco de 50) e fundura 3.5,
//      a da referência. Atrás da aba sobram 96.0 de vão em Y pra carta.
//   6. FOLGA DO RESSALTO 0.2 -> 0.4/LADO, com chanfro de entrada de 0.8 (regra
//      6, lição do deckbox-02 que travou).
//   7. TAMPA DESLIZANTE (2026-10-04) — substitui uma tampa de encaixe por cima
//      que o usuário reprovou na mão: "ela não segura nada, fica solta". Ele
//      escolheu deslizante, e isso exigiu mexer na torre: CANALETAS, CINTA e
//      TRAVESSA (abaixo). A 1ª versão tinha uma trava de CLIQUE (lingueta-mola
//      com dente num rebaixo da travessa); a peça de teste impressa aprovou o
//      trilho e REPROVOU o clique ("ficou ruim, não precisa dessa trava,
//      apenas o deslizar já está ok") — o clique saiu, o trilho ficou
//      EXATAMENTE como estava, e as abas voltaram de 5.0 (fundura que só
//      existia pra caber o rebaixo) pra 3.5. Depois o puxador também saiu
//      ("não precisa de puxador não"): a tampa é uma chapa retangular lisa.
//
// ATENÇÃO — A MEDIDA DA CARTA NÃO É DE RÉGUA
// A cavidade 69.0 x 99.5 veio da malha da referência, não da carta do usuário.
// Quando a régua chegar, a correção é um include de 3 linhas:
//   cav_w_override = <largura + 2>; cav_d_override = <comprimento + 2>;
//   include <sleeve-tower-01.scad>
// e o modelo inteiro se refaz — sulco, abas, ressalto, canaletas e tampa.
//
// TAMPA DESLIZANTE — POR QUE ASSIM (trilho APROVADO no teste físico)
//   POR ONDE ENTRA: PELA FRENTE. A frente já é a face aberta (não há parede
//   pra furar), o FUNDO vira batente de graça (a canaleta termina na face
//   interna dele) e o lado de abrir é o que você olha.
//   ONDE FICA EM Z: ABAIXO DA ZONA DO RESSALTO, pra continuar empilhável com
//   a tampa fechada. O ressalto da torre de cima desce até z=147; a tampa vai
//   de 143.9 a 146.5 (0.5 de folga). Preço: o curso útil cai de 137 (o que a
//   torre empilhada já tinha) pra 133.9 — 3.1mm, ~9 cartas ensleevadas.
//   PERFIL DO TRILHO (corte XZ, lado +x; o -x é espelho):
//     tampa ......... chapa retangular LISA de 2.6 (z 143.9..146.5), 73.0 x
//                     99.0, frente em y=-50.95 (0.3 atrás da cara da frente,
//                     onde o trilho já definia), sem nada projetando pra fora
//     lingueta ...... entra 2.0 na parede além da face interna (x 34.5..36.5).
//                     Fundo PLANO (apoia no piso da canaleta) e topo com
//                     CHANFRO DE 45 de x=34.9 até a ponta, que tem 1.0 de
//                     altura (z 143.9..144.9)
//     canaleta ...... piso plano em z=143.9, fundo vertical em x=37.0 (1.0 de
//                     altura), TETO A 45 descendo pra dentro da parede, de
//                     z=147.4 na boca a 144.9 no fundo. O teto é a lingueta
//                     crescida 0.5 em X e 0.5 em Z.
//     folgas ........ 0.5/lado em X (regra 6, deslize de ~100mm), 0.5 vertical.
//                     Engate mínimo da lingueta com a tampa encostada num lado:
//                     1.5mm.
//     boca .......... chanfro de entrada de 0.6 na frente da canaleta (com a
//                     quina da cinta em r=0.3 sobram 1.1 de parede na cara da
//                     frente — regra 4). A tampa tem os cantos de trás
//                     chanfrados em 0.8 e a aresta de BAIXO da borda de ataque
//                     (a de trás, que entra primeiro) chanfrada em 0.5: passa
//                     POR CIMA de uma carta empenada em vez de empurrá-la.
//     ACOPLAMENTO ... por causa do teto a 45, folga lateral e folga vertical
//                     são a MESMA folga: tampa centrada sobe 0.5; encostada
//                     num lado não sobe. A tampa tem 0.5 de jogo e pode fazer
//                     um leve barulho chacoalhando.
//   POR QUE TETO A 45 E NÃO RETO: a torre imprime em pé, e uma canaleta
//   horizontal numa parede vertical tem teto voltado pra baixo. Teto reto
//   seria balanço de 2.5mm em cada camada da canaleta. A 45 descendo PRA DENTRO
//   da parede, cada camada acima do teto avança 1 camada sobre a de baixo,
//   presa na parede — imprime sem suporte.
//   CINTA: com a canaleta indo até x=37.0, uma parede de 3.0 deixaria 0.5mm
//   atrás dela. As laterais engrossam 1.5 pra FORA só no topo (x até 39.0,
//   cheia de z=142.9 a 150, com chanfro de 45 embaixo, de 141.4 a 142.9 —
//   cresce subindo, imprime). Sobra 2.0 de parede atrás da canaleta. Quinas
//   verticais da cinta em r=0.3 pra não comer a parede ao lado da boca.
//   TRAVESSA DA FRENTE (y -51.25..-47.75, mesma fundura das abas, até z=143.9):
//   amarra as duas laterais na boca — o U, que era aberto em cima na frente,
//   vira um quadro fechado (o topo de uma torre de 150 impressa em pé faz
//   barriga; com as pontas soltas a tampa travaria ou soltaria). É também o
//   APOIO DA FRENTE DA TAMPA: com a tampa fechada (frente em y=-50.95) são
//   3.2mm de chapa apoiados na travessa na largura toda, além dos pisos das
//   canaletas. Fica INTEIRA na faixa das abas: as cartas ficam atrás dela
//   (y > -47.75) e saem pela boca sem encostar. Embaixo fecha o sulco em ARCO
//   DE 45, sem ponte, com 3.6 de travessa acima da ponta (o arco ficou no mesmo
//   lugar de quando ela levava o rebaixo do clique).
//   O QUE SEGURA A TAMPA (SEM TRAVA): pra cima, o teto da canaleta (sobe no
//   máximo 0.5; fit_dz=+0.7 já interfere) — de cabeça pra baixo ela fica
//   pendurada nos tetos, não cai pra baixo. Pros lados, 0.5. Pra trás, o
//   batente. PRA FRENTE, NADA: só o atrito. Inclinar a torre pra frente ou
//   virar de cabeça pra baixo faz a tampa ESCORREGAR PRA FORA pela frente.
//   Decisão do usuário depois do teste físico (o clique "ficou ruim").
//
// CURSO COMPLETO DA TAMPA (simulado; regra 3, lição do elevador do deckbox-01):
//   part="lid_fit" com dy = 0, -1, -2, -3, -5, -10, -25, -50, -75, -95, -99 em
//   repouso (dz=0.01) e dy = 0, -2, -50, -99 levantada até o teto (dz=0.5):
//   VAZIO em TODOS. Nada pega no curso inteiro.
//   PROVAS NA POSIÇÃO FECHADA: dz=+0.7 67mm³ (não sai pra cima); dx=0.6 27mm³;
//   dy=+0.4 31mm³ (batente).
//   EMPILHAMENTO: part="fit" (duas torres, passo 147) VAZIO; part="stack_fit"
//   (tampa fechada x torre de cima) VAZIO, dz=+0.7 1305mm³.
//   TRILHO INALTERADO desde o teste físico: o recorte da torre acima do piso
//   da canaleta (z >= 143.95), o recorte das paredes/cinta (|x| >= 34.6,
//   z 140..150) e o recorte das linguetas da tampa (|x| 33..37, y -45..47) têm
//   o MESMO nº de triângulos, bbox e hash de vértices ordenados antes e
//   depois de tirar o clique.
//
// ASSENTO DO EMPILHAMENTO (inalterado)
// Parede 3.0 + folga 0.4 = 3.4mm de saia em volta do ressalto, a 3mm da mesa.
// Solução: 1.2mm de LEDGE plano (assento definido) + 2.2mm de RAMPA A 45. O
// balanço plano cai de 3.4 pra 1.2mm. Contato real do ledge sobre o aro: 0.8mm
// num anel em U de ~276mm. Sem funil na boca (comeria o assento): quem guia é
// o chanfro de 0.8 do ressalto, que aceita 1.2mm de erro de mão.
//
// ESTABILIDADE (o preço de 150mm, aceito pelo usuário)
// Centro de massa MEDIDO na malha: (0, 4.11, 53.80). Uma torre tomba com
//   34.9 graus pro lado | 45.8 pra frente | 41.2 pra trás.
// DUAS EMPILHADAS (297mm, centro de massa em z=127.3):
//   16.4 graus pro lado | 23.5 pra frente | 20.3 pra trás.
// Vazias — cheias, pior. Coluna de duas: encostada na parede/prateleira.
//
// MATERIAL E TEMPO
// Torre 201.2cm³ de SÓLIDO, tampa 18.5cm³ (medidos na malha). Fatiada com 2
// perímetros e 15% de grade a torre fica na casa de ~125cm³ / ~155g / ~7h — o
// número real é do fatiador. Botões honestos se incomodar: wall_override =
// 2.6; altura menor (total_h_override). NÃO baixar o infill do piso: ali o
// peso é o lastro.
//
// IMPRESSÃO, SEM SUPORTE
//   TORRE: em pé, na orientação de uso. Inventário de balanço:
//     ressalto (z 0..3) ...... prisma na mesa, ~6.7 mil mm² de 1ª camada
//     chanfro do ressalto .... 45, crescendo pra fora
//     ledge do assento (z=3) . 1.2mm — o ÚNICO balanço plano da peça
//     saia, cinta ............ rampas de 45 crescendo pra fora
//     arco do sulco .......... 45 dos dois lados, fechando na ponta: sem ponte
//     teto das canaletas ..... 45 descendo pra dentro da parede
//     piso das canaletas, topo da travessa ... faces pra cima
//   TAMPA: DE CABEÇA PRA BAIXO, o topo liso na cama (é como part="lid" sai),
//     2.6mm de altura. O chanfro de 45 das linguetas vira balanço de 45 pra
//     fora, que imprime; a face que fica à vista sai com o acabamento do PEI.
//     Preenchimento 100% (ou no mínimo 5 camadas de topo e de fundo): chapa
//     de 2.6 com grade fica mole e empena.
//
// EXPORTS CANÔNICOS (caminhos ABSOLUTOS na hora de rodar; aqui abreviados)
//   flatpak run org.openscad.OpenSCAD -o stl/sleeve-tower-01.stl           -D 'part="tower"'   sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o stl/sleeve-tower-01-tampa.stl     -D 'part="lid"'     sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-plate.3mf     -D 'part="plate"'   sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-par.3mf       -D 'part="par"'     sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-tampa.3mf     -D 'part="lid"'     sleeve-tower-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/sleeve-tower-01-tampa-par.3mf -D 'part="lid_par"' sleeve-tower-01.scad
//   JOBS: plate = 1 torre + 1 tampa lado a lado (157.0 x 102.5 x 150) | par =
//   2 torres numa fileira + 2 tampas na outra (162.0 x 207.5 x 150: sem a pega
//   a tampa tem 99.0 em Y e 102.5 + 6 + 99.0 = 207.5 cabe no alvo de 210) |
//   tampa = 1 tampa (73.0 x 99.0 x 2.6) | tampa-par = 2 tampas (152.0 x 99.0
//   x 2.6), pra reimprimir só tampa.
//   DIAGNÓSTICO (não vai pra 3mf/):
//     part="fit"       -> duas torres empilhadas: TEM QUE SAIR VAZIO
//     part="lid_fit"   -> tampa x torre (com fit_dx/dy/dz): VAZIO com
//                         fit_dz=0.01 (em 0 é contato de face: a tampa apoia)
//     part="stack_fit" -> tampa fechada x torre empilhada em cima: VAZIO
//     part="stack2", part="with_lid" -> só pra render
//   Os fit_* são variáveis FINAIS, então -D funciona com eles (ao contrário dos
//   *_override, que só valem por include).
//
// VARIANTE: por INCLUDE, nunca por -D nos *_override. Ex.:
//   total_h_override = 100; include <sleeve-tower-01.scad>

/* [Peça] */
// tower | lid | plate | par | lid_par | fit | lid_fit | stack_fit | stack2 | with_lid
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

/* [Frente — o sulco, as abas em L e a travessa] */
// fração da largura EXTERNA (do corpo, sem a cinta) que o sulco ocupa. 2/3 = pedido do usuário; com o externo de 75.0 dá 50.0mm de vão
open_frac = is_undef(open_frac_override) ? 2 / 3 : open_frac_override;
// mm — profundidade da aba em L (e da travessa) no eixo Y. 3.5 = a medida da referência. (Foi 5.0 só enquanto a travessa levava o rebaixo do clique; sem clique, voltou: a carta ganha 1.5 em Y, 96.0 atrás da aba)
tab_depth = is_undef(tab_depth_override) ? 3.5 : tab_depth_override;
// mm — material da travessa acima da ponta do arco. 3.6 mantém o arco onde estava (z 115.3..140.3)
beam_min = 3.6;

/* [Empilhamento] */
// mm — altura do ressalto que entra na boca da torre de baixo (medida na referência)
boss_h = 3.0;
// mm — folga do ressalto na boca, POR LADO. 0.4 e não os 0.2 da referência: regra 6 do CLAUDE.md, lição do deckbox-02 que travou. Peça de 150mm em pé empena mais que uma de 45
stack_clear = is_undef(stack_clear_override) ? 0.4 : stack_clear_override;
// mm — chanfro de 45 na aresta de baixo do ressalto. É ele sozinho que guia o encaixe (não há funil na boca, ele comeria o assento): aceita stack_clear + este valor de erro de mão
boss_lead = 0.8;
// mm — largura do LEDGE plano do assento, em volta do ressalto. O resto da saia sobe em rampa de 45. Tem que ser MENOR que wall + stack_clear, senão a rampa fura a face externa
seat_ledge = 1.2;

/* [Tampa deslizante — trilho] */
// mm — espessura da tampa (chapa maciça)
lid_t = 2.6;
// mm — espessura da PONTA da lingueta que corre na canaleta (o topo dela desce a 45 da face de cima até aqui)
lid_tip_t = 1.0;
// mm — quanto a lingueta entra na parede, além da face interna
lid_tongue = 2.0;
// mm — folga de deslize POR LADO (ponta da lingueta x fundo da canaleta) e folga vertical (lingueta x teto). Regra 6: 0.5
slide_clear = 0.5;
// mm — folga entre o topo da tampa e o fundo do ressalto de uma torre empilhada em cima (z = 147)
lid_gap_top = 0.5;
// mm — chanfro de entrada na boca da canaleta (frente da parede) e nos cantos de trás da tampa
slot_lead = 0.8;
// mm — chanfro de entrada na BOCA da canaleta (frente da parede). 0.6 e não 0.8: com 0.8 sobrava 0.2 de parede contra a quina da cinta em y=-51.25 (lasca, regra 4)
slot_mouth = 0.6;
// mm — chanfro na aresta de BAIXO da borda de ataque da tampa (a de trás, que entra primeiro): passa por cima de carta empenada em vez de empurrar
lid_lead_z = 0.5;
// mm — CINTA: engrossa as laterais pra fora só no topo, pra sobrar parede atrás da canaleta
collar_w = 1.5;
// mm — raio das quinas verticais da CINTA. 0.3 e não o corner_r de 1.0: com r=1 a quina da frente comia a parede ao lado da boca da canaleta
collar_r = 0.3;


// mm — folga entre o fundo da tampa fechada e a face interna do fundo
lid_back_gap = 0.2;

/* [Diagnóstico de encaixe da tampa] */
// mm — desloca a tampa em part="lid_fit" (dy<0 = puxada pra FRENTE, abrindo; dz>0 = levantada). Valores != 0 são TESTE, nunca exportar
fit_dx = 0;
fit_dy = 0;
fit_dz = 0;

/* [Acabamento] */
// mm — raio das quinas verticais externas e das arestas do sulco (medido na referência; é o que a mão pega)
corner_r = 1.0;
// mm — raio dos cantos verticais internos da cavidade (só tira o canto vivo; o bico da impressora já arredonda sozinho)
inner_r = 1.0;

/* [Chapa] */
// mm — vão entre peças nas chapas
plate_gap = 6.0;

/* [Oculto] */
$fn = 48;

// ---------------------------------------------------------------- Derivados
ext_w      = cav_w + 2 * wall;              // 75.0  — externo do CORPO em X
ext_d      = cav_d + wall;                  // 102.5 — externo em Y (parede só no fundo, a frente é aberta)
cav_h      = total_h - floor_h;             // 140.0 — altura da cavidade, do piso à boca
slab_h     = floor_h - boss_h;              // 7.0   — laje cheia acima do ressalto

y_front    = -ext_d / 2;                    // -51.25 — plano da frente
y_back     =  ext_d / 2;                    //  51.25 — plano do fundo
y_cav_back =  y_back - wall;                //  48.25 — face interna do fundo
x_wall_in  =  cav_w / 2;                    //  34.50 — face interna da lateral

open_w     = ext_w * open_frac;             // 50.0  — vão do sulco
x_open     = open_w / 2;                    // 25.0  — aresta interna da aba
tab_return = x_wall_in - x_open;            // 9.5   — quanto a aba avança pra dentro da lateral
tab_x_out  = ext_w / 2 - corner_r;          // 36.5  — a aba morre dentro da parede lateral

boss_w     = cav_w - 2 * stack_clear;       // 68.2  — ressalto em X
boss_yb    = y_cav_back - stack_clear;      // 47.85 — fundo do ressalto (a frente é rente ao plano da frente)
boss_d     = boss_yb - y_front;             // 99.1  — ressalto em Y
boss_cy    = (y_front + boss_yb) / 2;       // -1.70
boss_grip  = boss_h - boss_lead;            // 2.2   — engate RETO do empilhamento
boss_catch = stack_clear + boss_lead;       // 1.2   — erro lateral de mão aceito na hora de empilhar
stack_pitch= total_h - boss_h;              // 147.0 — passo do empilhamento (duas torres = 297)

seat_w     = boss_w + 2 * seat_ledge;       // 70.6
seat_yb    = boss_yb + seat_ledge;          // 49.05
seat_d     = seat_yb - y_front;             // 100.3
seat_cy    = (y_front + seat_yb) / 2;       // -1.10
skirt_ramp = wall + stack_clear - seat_ledge; // 2.2
skirt_top  = boss_h + skirt_ramp;           // 5.2
seat_grip  = seat_ledge - stack_clear;      // 0.8   — contato REAL do ledge sobre o aro

// TRILHO DA TAMPA (perfil da canaleta no plano XZ, lado +x; o -x é espelho)
z_lt       = stack_pitch - lid_gap_top;     // 146.5 — topo da tampa
z_lb       = z_lt - lid_t;                  // 143.9 — fundo da tampa = piso da canaleta = topo da travessa
x_tt       = x_wall_in + lid_tongue;        // 36.5  — ponta da lingueta
x_sb       = x_tt + slide_clear;            // 37.0  — fundo da canaleta
z_tip_top  = z_lb + lid_tip_t;              // 144.9 — topo da ponta da lingueta
x_bev0     = x_tt - (lid_t - lid_tip_t);    // 34.9  — onde o chanfro de 45 da lingueta começa
function z_ceil(x) = z_tip_top + (x_tt - x) + slide_clear;   // teto da canaleta, 45 descendo pra dentro da parede
z_ceil_in  = z_ceil(x_wall_in);             // 147.4 — teto na boca da canaleta (face interna)
z_ceil_sb  = z_ceil(x_sb);                  // 144.9 — teto no fundo da canaleta
slot_back_h= z_ceil_sb - z_lb;              // 1.0   — altura da canaleta no fundo
ext_w_top  = ext_w + 2 * collar_w;          // 78.0  — externo em X na CINTA
web        = ext_w_top / 2 - x_sb;          // 2.0   — parede que sobra atrás da canaleta
z_col0     = z_lb - 1.0;                    // 142.9 — cinta cheia daqui pra cima
z_col_ch   = z_col0 - collar_w;             // 141.4 — começo do chanfro de 45 da cinta
tongue_eng = lid_tongue - slide_clear;      // 1.5   — lingueta dentro da parede no pior caso lateral

lid_w      = 2 * x_tt;                      // 73.0  — tampa em X (ponta a ponta)
lid_yb     = y_cav_back - lid_back_gap;     // 48.05 — fundo da tampa fechada
lid_yf     = y_front + 0.3;                 // -50.95 — frente da tampa (0.3 pra dentro da cara)
lid_len    = lid_yb - lid_yf;               // 99.0
lid_travel = lid_yb - y_front;              // 99.3  — curso de deslize até a tampa sair da torre
lid_play_z = slide_clear;                   // 0.5   — folga vertical da tampa

// TRAVESSA DA FRENTE
y_beam_b   = y_front + tab_depth;           // -47.75 — face de trás da travessa (= das abas)
z_apex     = z_lb - beam_min;               // 140.3 — ponta do arco do sulco
z_arch0    = z_apex - x_open;               // 115.3 — onde o sulco começa a fechar em arco de 45
lid_on_beam= y_beam_b - lid_yf;             // 3.2   — quanto a frente da tampa fechada apoia na travessa
card_y     = y_cav_back - y_beam_b;         // 96.0  — vão em Y pra carta atrás da aba

cav_h_useful = z_lb - floor_h;              // 133.9 — curso útil da pilha (até o fundo da tampa)
cap_useful = floor(cav_h_useful / sleeve_t);

assert(total_h <= 220, "ALTURA ESTOURA A AD5X (220)");
assert(ext_w_top <= 170 && ext_d <= 170, "FOOTPRINT ESTOURA");
assert(seat_ledge < wall + stack_clear, "seat_ledge grande demais: a rampa da saia fura a face externa");
assert(seat_grip > 0.4, "assento de menos");
assert(boss_grip > 1.0, "engate reto de menos");
assert(tab_return > 4.0, "aba curta demais pra segurar a pilha");
assert(open_w > 40.0, "sulco estreito demais pra entrar dois dedos");
assert(skirt_top < floor_h, "a rampa da saia invade a cavidade");
assert(tab_depth > 2 * corner_r, "aba mais rasa que os dois raios de canto");
assert(x_bev0 >= x_wall_in, "o chanfro da lingueta começa dentro da cavidade: o teto da canaleta ficaria com degrau");
assert(web >= 1.6, "parede de menos atrás da canaleta: suba collar_w");
assert(z_arch0 > floor_h + 20, "arco do sulco baixo demais");
assert(lid_on_beam >= 2.0, "a frente da tampa quase nao apoia na travessa");
assert(x_sb + slot_mouth <= ext_w_top / 2 - collar_r - 0.7, "boca da canaleta lasca a quina da cinta");

echo(str("sleeve-tower-01  corpo ", ext_w, " x ", ext_d, " x ", total_h, " mm, cinta no topo ", ext_w_top));
echo(str("  cavidade ", cav_w, " x ", cav_d, " x ", cav_h, "  curso util ", cav_h_useful,
         " (piso ", floor_h, " ate o fundo da tampa ", z_lb, ")"));
echo(str("  sulco ", open_w, " fecha em arco de 45 de z=", z_arch0, " a ", z_apex,
         "  travessa ate z=", z_lb, "  aba ", tab_depth, " fundura, retorno ", tab_return));
echo(str("  ressalto ", boss_w, " x ", boss_d, " x ", boss_h, " folga ", stack_clear,
         "  passo ", stack_pitch));
echo(str("  CANALETA: piso z=", z_lb, "  fundo x=", x_sb, " (altura ", slot_back_h,
         ")  teto 45 de ", z_ceil_in, " na boca a ", z_ceil_sb, " no fundo  parede atras ", web,
         "  cinta z>=", z_col0));
echo(str("  TAMPA ", lid_w, " x ", lid_len, " x ", lid_t, " (chapa lisa, sem pega, frente 0.3 atras da cara)",
         "  lingueta ", lid_tongue, " (engate min ", tongue_eng, ")  folga ", slide_clear,
         "/lado e ", lid_play_z, " vertical  curso ", lid_travel));
echo(str("  tampa apoia ", lid_on_beam, " na travessa  carta tem ", card_y, " em Y atras da aba"));

// -------------------------------------------------------------------- Peças
if      (part == "tower")    tower();
else if (part == "lid")      lid_print();
else if (part == "plate")    { translate([-(ext_w_top + plate_gap) / 2, 0, 0]) tower();
                               translate([ (lid_w + plate_gap) / 2, 0, 0]) lid_print(); }
else if (part == "par")      for (s = [-1, 1]) {   // 2 torres numa fileira + 2 tampas na outra
                                 translate([s * (ext_w_top + plate_gap) / 2, -(lid_len + plate_gap) / 2, 0]) tower();
                                 translate([s * (lid_w + plate_gap) / 2, (ext_d + plate_gap) / 2, 0]) lid_print(); }
else if (part == "lid_par")  for (s = [-1, 1]) translate([s * (lid_w + plate_gap) / 2, 0, 0]) lid_print();
else if (part == "fit")      fit_check();
else if (part == "lid_fit")  intersection() { tower(); lid_placed(); }
else if (part == "stack_fit")intersection() { lid_placed(); translate([0, 0, stack_pitch]) tower(); }
else if (part == "stack2")   { tower(); translate([0, 0, stack_pitch]) tower(); }
else if (part == "with_lid") { tower(); lid_placed(); }
else                         assert(false, "part desconhecido");

// ------------------------------------------------------------------ Módulos

module tower() {
    difference() {
        union() {
            difference() {
                union() { stack_boss(); body_shell(); }
                cavity();
            }
            front_tabs();
            front_beam();
        }
        for (s = [-1, 1]) scale([s, 1, 1]) lid_slot();
    }
}

module rrect(w, d, r, h) {
    hull() for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * (w / 2 - r), sy * (d / 2 - r), 0])
            cylinder(h = h, r = r);
}

// 2D no plano (x, z) extrudado em Y de y0 a y1.
module xz_extrude(y0, y1) {
    translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();
}

module stack_boss() {
    c = boss_lead;
    hull() {
        translate([0, boss_cy, 0])
            rrect(boss_w - 2 * c, boss_d - 2 * c, max(corner_r - c, 0.2), 0.01);
        translate([0, boss_cy, c])
            rrect(boss_w, boss_d, corner_r, boss_h - c + 0.02);
    }
}

// Corpo cheio: assento + saia, prisma externo e a CINTA no topo (laterais
// engrossadas collar_w pra fora, com chanfro de 45 embaixo — cresce subindo).
module body_shell() {
    seat_skirt();
    translate([0, 0, skirt_top]) rrect(ext_w, ext_d, corner_r, total_h - skirt_top);
    hull() {
        translate([0, 0, z_col_ch]) rrect(ext_w, ext_d, corner_r, 0.01);
        translate([0, 0, z_col0])   rrect(ext_w_top, ext_d, collar_r, 0.01);
    }
    translate([0, 0, z_col0]) rrect(ext_w_top, ext_d, collar_r, total_h - z_col0);
}

module seat_skirt() {
    hull() {
        translate([0, seat_cy, boss_h])   rrect(seat_w, seat_d, corner_r, 0.01);
        translate([0, 0,      skirt_top]) rrect(ext_w,  ext_d,  corner_r, 0.01);
    }
}

module cavity() {
    over = 20;
    d    = (y_cav_back - (y_front - over));
    translate([0, y_cav_back - d / 2, floor_h])
        rrect(cav_w, d, inner_r, cav_h + 1);
}

// Abas em L: do piso até o topo da travessa (z_lb), onde se fundem nela.
module front_tabs() {
    for (s = [-1, 1]) scale([s, 1, 1]) tab();
}

module tab() {
    w = tab_x_out - x_open;
    translate([(x_open + tab_x_out) / 2, y_front + tab_depth / 2, floor_h])
        rrect(w, tab_depth, corner_r, z_lb - floor_h);
}

// TRAVESSA DA FRENTE: amarra as duas laterais na boca (o U deixa de ser
// aberto em cima) e é o apoio da frente da tampa.
// Embaixo, o sulco fecha num ARCO DE 45 (ponta pra cima): sem ponte.
module front_beam() {
    xz_extrude(y_front, y_beam_b)
        difference() {
            translate([-x_wall_in - 0.5, z_arch0]) square([cav_w + 1, z_lb - z_arch0]);
            polygon([[-x_open, z_arch0 - 1], [x_open, z_arch0 - 1], [x_open, z_arch0],
                     [0, z_apex], [-x_open, z_arch0]]);
        }
}

// Perfil da canaleta (lado +x) no plano XZ.
module slot_profile() {
    polygon([[x_wall_in - 1, z_lb], [x_sb, z_lb], [x_sb, z_ceil_sb],
             [x_wall_in - 1, z_ceil(x_wall_in - 1)]]);
}

// Canaleta: da frente até a face interna do fundo (o fundo é o BATENTE), com
// boca alargada em slot_lead na frente (chanfro de entrada de 45).
module lid_slot() {
    xz_extrude(y_front - 1, y_cav_back) slot_profile();
    hull() {
        xz_extrude(y_front - 1, y_front) offset(delta = slot_mouth) slot_profile();
        xz_extrude(y_front + slot_mouth, y_front + slot_mouth + 0.01) slot_profile();
    }
}

// TAMPA na posição FECHADA, em coordenadas da torre. Chapa retangular lisa:
// sem pega (pedido do usuário), frente onde o trilho já define (0.3 atrás da cara).
module lid() {
    difference() {
        union() {
            // chapa com as linguetas (perfil XZ extrudado em Y)
            intersection() {
                xz_extrude(lid_yf, lid_yb)
                    polygon([[-x_tt, z_lb], [x_tt, z_lb], [x_tt, z_tip_top], [x_bev0, z_lt],
                             [-x_bev0, z_lt], [-x_tt, z_tip_top]]);
                // cantos de trás chanfrados (entrada na canaleta)
                linear_extrude(200) polygon([[-x_tt, lid_yf - 1], [x_tt, lid_yf - 1],
                    [x_tt, lid_yb - slot_lead], [x_tt - slot_lead, lid_yb],
                    [-x_tt + slot_lead, lid_yb], [-x_tt, lid_yb - slot_lead]]);
            }
        }
        // chanfro de 45 na aresta de baixo da borda de ataque (a de trás)
        translate([0, lid_yb, z_lb]) rotate([45, 0, 0])
            cube([lid_w + 2, lid_lead_z * sqrt(2), lid_lead_z * sqrt(2)], center = true);
    }
}

// Tampa com os deslocamentos de teste. dy<0 abre (puxa pra frente).
module lid_placed() {
    translate([fit_dx, fit_dy, fit_dz]) lid();
}

// Tampa na orientação de IMPRESSÃO: de cabeça pra baixo, o topo liso na cama,
// centrada em X e em Y. Gira em Y (espelha X, simétrico): a frente
// continua em -y.
module lid_print() {
    translate([0, -(lid_yb + lid_yf) / 2, z_lt]) rotate([0, 180, 0]) lid();
}

module fit_check() {
    intersection() {
        tower();
        translate([0, 0, stack_pitch]) tower();
    }
}
