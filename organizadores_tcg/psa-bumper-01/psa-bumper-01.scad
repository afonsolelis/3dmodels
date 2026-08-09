// psa-bumper-01.scad
//
// ##########################################################################
// #  A CHAPA DA MOLDURA É PROVISÓRIA. NÃO IMPRIMA ELA AINDA.               #
// #  O envelope do slab (84.5 x 139.5 x 7.2) é ESTIMATIVA, não medida — e  #
// #  84.5 é quase o MÍNIMO das 5 fontes: 2 delas não entram, e em Z 7.5 de #
// #  cavidade contra 0.30" = 7.62 já dá interferência.                     #
// #  IMPRIMA PRIMEIRO o 3mf/psa-bumper-01-gauge.3mf (13.4g), devolva os    #
// #  três números, corrija slab_w/slab_h/slab_t e re-exporte.              #
// ##########################################################################
// Bumper (case clamshell) pra slab PSA graduado. Duas metades IGUAIS de moldura
// que fecham em cima do slab e se prendem por ímã: nenhuma das duas é placa
// cega, então dá pra ver a FRENTE e o DORSO da carta. A janela é um VÃO ÚNICO
// e contínuo — carta e etiqueta PSA aparecem juntas, sem travessa cortando o
// meio (é a diferença principal em relação ao PSA Graded Card Case do
// MaskForge, que serviu de inspiração).
//
// COMO SE MANUSEIA:
//   1. Deita uma metade na mesa com a boca pra cima (o aro de 9mm virado pra
//      você) e põe o slab dentro da cavidade — ele afunda 3.75mm. ATENÇÃO:
//      nessa hora o slab está só APOIADO. O lip de 2mm fica EMBAIXO dele (é o
//      chão da cavidade, z 0..2); os 2.7mm de pega por cima da borda do slab
//      são do lip da OUTRA metade e só existem depois de fechar. Virar a
//      metade cheia na mão antes de fechar = slab no chão.
//   2. Pega a SEGUNDA cópia, vira ela de boca pra baixo e encaixa em cima. O
//      DEGRAU PERIMETRAL guia o encaixe: metade do perímetro é ressalto e a
//      outra metade é rebaixo, em diagonal, então tombar a cópia pelo lado
//      curto OU pelo lado longo dá no mesmo — ressalto sempre cai em rebaixo.
//      Os 10 pares de ímã puxam as duas faces até se encostarem.
//   3. Pra ABRIR: é fácil de propósito (é um bumper de VITRINE, o usuário troca
//      a carta). O fecho inteiro tem ~40N e o degrau trava só o escorregamento
//      lateral — folga de 0.25/lado, NÃO é encaixe de pressão —, então não se
//      abre puxando de lado. Use as meia-luas (2 em cada lado curto, flanqueando
//      o ímã do meio): a costura passa no meio delas e o chanfro de 45° das DUAS
//      metades forma um V de ~1.6mm de boca — entra unha, moeda ou palheta.
//      Método secundário, sempre disponível: dedo na janela empurrando o slab
//      por dentro (~45N) descola as metades sem ferramenta nenhuma.
//
// DEPOIS DE IMANTADAS AS METADES NÃO SÃO MAIS INTERCAMBIÁVEIS: as duas peças
// saem idênticas da impressora, mas uma é populada com o polo N pra cima e a
// outra com S pra cima. Duas metades "iguais" se REPELEM. Marque as duas
// (caneta na face externa, um ponto numa e dois na outra) antes de colar.
//
// POR QUE DEGRAU E NÃO PINO: a primeira versão alinhava com 2 pinos de Ø3
// subindo 2.5mm. Pino fino impresso em pé pega esforço de flexão na base, que
// é exatamente onde as linhas de camada são o elo fraco do FDM (e sem filete
// de raiz). O degrau perimetral distribui o mesmo travamento por ~184mm de
// borda, com 1.2mm de altura só — não tem o que quebrar.
//
// UMA PEÇA SÓ, IMPRESSA 2x. Frente e verso são a MESMA geometria; o usuário
// popula uma cópia com o ímã de polo N pra cima e a outra com S pra cima, e aí
// os 10 pares atraem. Layout de ímã simétrico nos dois eixos centrais + degrau
// com simetria de rotação de 180° (ressalto nos quadrantes 1 e 3, rebaixo nos
// 2 e 4) = a peça casa com a própria cópia virada de qualquer um dos dois
// jeitos. Os `part`s de debug provam isso na geometria:
//   part="fit"   -> interseção das duas metades acasaladas; TEM QUE SAIR VAZIO
//                   (nada colide: ressalto cai em rebaixo, nunca em ressalto)
//   part="pairs" -> discos onde os bolsos de ímã de uma metade encontram os da
//                   outra; TEM QUE SAIR 10 DISCOS (Volumes: 11 no sumário CGAL)
//   part="grip"  -> o ressalto desta metade DENTRO do rebaixo da outra; TEM QUE
//                   SAIR 6 SEGMENTOS (Volumes: 7). Sem este, o "fit" vazio
//                   passaria por vacuidade: ressalto de altura zero ou fora de
//                   posição não colide com nada e o fit sai vazio igual.
//   mate_flip="x" tomba a 2a cópia pelo eixo curto, "y" pelo eixo longo —
//   os dois casos passam nos três testes.
//
// Exports canônicos (nesta máquina, `openscad` = `flatpak run org.openscad.OpenSCAD`):
//   openscad -o stl/psa-bumper-01-frame.stl  -D 'part="frame"'  psa-bumper-01.scad
//   openscad -o 3mf/psa-bumper-01-plate.3mf  -D 'part="plate"'  psa-bumper-01.scad
// ESCOPO: bumper de VITRINE. Segura o slab em prateleira, mesa e na mão, mas
// NÃO É À PROVA DE QUEDA: 1m em piso duro põe ~1.2 J contra ~0.06 J pra separar
// os 10 pares, então pode abrir e liberar o slab. Isso é decisão de escopo do
// usuário (uso é exposição), não defeito — e é por isso que não entra detente
// mecânica no degrau: com o case parado na prateleira, o que importa é abrir
// fácil pra trocar a carta.
//
// USAR BRIM (ou brim ears nos 4 cantos). A planeza da face de encontro é
// funcional: 0.2mm de empeno no meio de um lado DOBRA o entreferro do ímã do
// meio, e anel comprido e baixo é candidato clássico a curvar as pontas.
// A chapa leva UMA moldura só: 109.1 x 164.1mm cabe na A1 mini (teto útil
// 170), mas duas molduras não cabem juntas em orientação nenhuma — cada uma
// precisa de 109.1mm no eixo curto (2x = 218.2 > 180) e a diagonal de 197.1mm
// impede girar. Então é o MESMO job impresso 2x — a chapa não vem com as duas
// metades dentro. Imprime de boca pra cima (como exportado), SEM SUPORTE:
// nada em balanço, o degrau sobe reto, o rebaixo é aberto em cima e a única
// ponte é o teto raso de cada hexágono da textura, a 0.6mm da mesa.
//
// Variantes por include (ex.: a variante "Small" do case original, cujo bolso
// de slab foi medido na malha em 81.0 x 133.5 x 6.0). Arquivo variante.scad:
//   slab_w_override = 81; slab_h_override = 133.5; slab_t_override = 6;
//   include <../psa-bumper-01/psa-bumper-01.scad>
// e o export PRECISA passar o part por -D:
//   openscad -o 3mf/variante-plate.3mf -D 'part="plate"' variante.scad
// COMO O -D SE COMPORTA AQUI (medido, não suposto — a explicação anterior deste
// cabeçalho estava com a CAUSA errada):
//   - variável JÁ ATRIBUÍDA no arquivo: o -D substitui a atribuição no lugar e o
//     valor PROPAGA pros derivados. Medido: `a=1; b=a*10;` com -D a=5 dá b=50.
//     É assim que os controles de teste variam step_h, step_w, groove_z, groove_w,
//     mag_pocket_z e step_keepout.
//   - variável que só existe via -D (os *_override): o -D a acrescenta no FIM do
//     escopo, então quando o ternário `is_undef(x_override) ? padrão : override`
//     é avaliado ela ainda está undefined. Medido: com -D x_override=85, o
//     is_undef no fim do arquivo já dá false mas x continua 80. Por isso variante
//     se faz por INCLUDE, nunca por -D.
//   - `part` e `mate_flip` funcionam por -D INCLUSIVE através de include (medido);
//     o que NÃO funciona é atribuí-los no arquivo que inclui, porque a atribuição
//     do modelo sobrescreve (o OpenSCAD avisa "was assigned ... but overwritten").

/* [Peça a renderizar] */
part = "frame"; // "frame" (a peça; imprimir 2x) | "plate" (chapa de impressão) | "closed" (preview do conjunto fechado) | "gauge" (gabarito de conferência de medida, NÃO é job de impressão) | "fit" (debug: interferência entre as metades, tem que sair VAZIO) | "column" (debug: coluna de ar de cada ímã atravessando a costura, 10 colunas de 4.2mm) | "pairs" (debug: pares de ímã que se encontram, tem que sair 10 discos)
mate_flip = "x"; // como a 2a cópia é virada nos debugs e no preview fechado: "x" (tomba pelo eixo curto) | "y" (tomba pelo eixo longo)

/* [Slab PSA - envelope adotado] */
// !!! ESTIMATIVA ADOTADA, NÃO É MEDIDA DE RÉGUA !!!
// O usuário foi consultado duas vezes e optou por não medir o slab. 84.5 x
// 139.5 x 7.2 é um envelope conservador em cima do CONSENSO de 5 fontes que o
// psa-box-01 catalogou (85.0 / 85.0x138.5 / 85.4x140.0 / 86.2x140.7 e o
// nominal PSA 83.6x134.4 x 7.1).
// O case original (Main.3mf, MaskForge) é OUTLIER: medindo a malha do
// `Frame PSA - Small.obj` dele, o bolso de slab é 81.0 de largura x ~133.5 de
// altura (topo aberto, fechado pela barra do lid) x 6.0 de espessura. Ou seja,
// a descrição de 80x135x6 é fiel à geometria DELE — mas o nome "Small" e as
// outras 5 fontes dizem que é variante de slab menor, não a medida geral. Pra
// essa variante, ver o exemplo de include no cabeçalho.
// Quando o slab for medido de verdade, é só corrigir os 3 números abaixo e
// re-exportar: o resto da peça é todo derivado.
slab_w = is_undef(slab_w_override) ? 84.5  : slab_w_override; // mm, largura do slab
slab_h = is_undef(slab_h_override) ? 139.5 : slab_h_override; // mm, altura do slab
slab_t = is_undef(slab_t_override) ? 7.2   : slab_t_override; // mm, espessura do slab

/* [Moldura] */
// O aro é uniforme em toda a volta (sem orelhas/lobos nos cantos). Foi de 12
// pra 9 quando as duas justificativas dos 12 caíram:
//   - parede de bolso: com ímã de Ø4 sobram 2.35mm de cada lado, folgado;
//   - rigidez: com fecho de ~4N por par a deflexão do aro é 0.024mm em aro 9
//     (k = 48EI/L³ = 167 N/mm, I = 9x5.75³/12 = 142.6mm⁴, vão de 49.7mm) contra
//     0.019mm em aro 12. As duas são irrelevantes — rigidez não EXIGE 12, ela
//     PERMITE estreitar.
// O que se compra estreitando: footprint 103.1 x 158.1 em vez de 109.1 x 164.1,
// o que deixa brim de 5mm em 168.1 dos 180 (com aro 12 dava 174.1, sem margem).
// NÃO ajustar o aro "pra fechar em nº inteiro de perímetros de 0.4": o Arachne
// do Bambu/Orca redistribui sobra de parede em linhas de largura variável, sem
// vazio e sem perder perímetro.
rim       = is_undef(rim_override) ? 9 : rim_override; // mm, largura do aro em toda a volta
lip_t     = 2;   // mm, espessura da placa da frente (o lip que segura o slab pela borda)
lip_inset = 3;   // mm, quanto o lip avança por cima da cavidade (janela recuada isto de cada lado)
outer_r   = 4;   // mm, raio dos cantos externos da moldura
window_r  = 4;   // mm, raio dos cantos da janela
cav_r     = 1.5; // mm, raio dos cantos da cavidade do slab (menor que o canto arredondado de qualquer slab -> nunca aperta)
// Chanfro de 45° na aresta SUPERIOR INTERNA do aro (a boca da cavidade). Sem
// ele, quem guia o fechamento é o SLAB e não o degrau: o slab sobra 3.45mm acima
// da face de encontro e a boca da cavidade tem 0.3/lado, mais apertada que a
// captura de 0.65/lado do degrau — então um erro de 0.3mm de mão fazia o aro
// pousar em cima da borda do slab, numa aresta viva. O chanfro é voltado pra
// CIMA (a cavidade ALARGA subindo), logo imprime sem suporte.
cav_chamfer = 0.5; // mm, chanfro de 45° na boca da cavidade

/* [Ímãs 4x2mm - 10 pares (20 ímãs no total)] */
// O ímã é o que o usuário COMPROU: neodímio Ø4 x 2mm, kit de 50 (20 em uso, 30
// de sobra). Ø4x2 em contato dá só ~3.5-4.9N por par, então o fecho inteiro
// fica em ~35-49N. Isso INVERTE o que segura a costura: não é mais a força do
// ímã, é NÃO DEIXAR O ARO FLEXIONAR entre um ímã e o vizinho. Por isso o layout
// é dimensionado por VÃO, e não por contagem — espaçamento de ~50mm em todo o
// perímetro (k = 48EI/L³ com I = 190.1mm⁴ dá ~175 N/mm num vão de 50.7, contra
// 22 N/mm se o vão fosse 101mm):
//   4 nos cantos
//   + 2 intermediários em cada lado LONGO, em ±my/3 -> 3 vãos iguais de 50.7
//   + 1 intermediário em cada lado CURTO, no meio   -> 2 vãos de 48.55
// CUIDADO: o intermediário do lado longo vai na POSIÇÃO ±my/3 = ±25.35, não em
// ±50.7, que é o VÃO. Ímã em ±50.7 deixaria o vão do MEIO com 101.4mm (k = 22
// N/mm, 7N já abrem 0.3mm) — pior que os 76mm que o adensamento veio consertar.
// Cada bolso é cavado na FACE DE ENCONTRO das metades; o centro fica na linha
// do meio do aro (rim/2 da borda externa), o que torna o padrão simétrico nos
// dois eixos centrais — condição pra peça casar com a própria cópia virada. As
// posições acompanham o externo automaticamente (derivam de out_w/out_h).
magnet_d = 4; // mm, diâmetro do disco
magnet_h = 2; // mm, espessura do disco
// FOLGA NO DIÂMETRO: 4.3 dá 0.15/lado. NÃO é press-fit, de propósito —
// interferência nominal de 0.075/lado é loteria, porque furo pequeno no A1 mini
// sai 0.05-0.2 menor que o nominal: ou prensa forte ou fica solto. E o
// carregamento é o pior possível: na hora de ABRIR, o ímã da outra metade puxa
// cada disco PRA FORA do bolso — é assim que ímã salta e migra de metade. Por
// isso COLA É OBRIGATÓRIA aqui, não é "se ficar frouxo" (os 20 bolsos ficam
// todos voltados pra cima na impressão, então colar é trivial).
magnet_fit = 0.3; // mm, folga no diâmetro (0.15/lado)
// PROFUNDIDADE: 2.0 exato é geometricamente perfeito (entreferro nominal zero)
// mas tem orçamento de tolerância ZERO, e todo o erro vai PRA FORA, que é o lado
// ruim: disco saliente afasta as faces e abre a costura. Somam contra: tolerância
// do disco (±0.1 típico), filme de cola (0.02-0.05) e quantização de camada (em
// 0.16 a profundidade sai 1.96 -> 0.04/lado de saliência). Por isso 2.1, que
// custa ~17% de força ((2/2.2)² = 0.83, fecho de 34-49N vira 28-40N — ainda
// 23-33x o peso do conjunto) e compra 0.1/lado de margem. O filme de cola é
// atacado de graça pelo alívio no FUNDO do bolso (magnet_relief), pra a cola ter
// pra onde ir em vez de levantar o disco.
magnet_slack   = 0.1; // mm, folga na profundidade do bolso
magnet_relief_d = 2.0; // mm, diâmetro do alívio de cola no fundo do bolso
magnet_relief_h = 0.3; // mm, profundidade do alívio de cola

/* [Degrau perimetral - alinhamento] */
// Ímã não segura cisalhamento: sem travamento mecânico as metades escorregam
// de lado e o slab desalinha na janela. O degrau corre a linha do meio do aro:
// nos quadrantes 1 e 3 é RESSALTO, nos quadrantes 2 e 4 é REBAIXO. Esse padrão
// tem simetria de rotação de 180° e é ANTI-simétrico em cada espelhamento, que
// é exatamente o que faz ressalto encontrar rebaixo virando a cópia por
// qualquer um dos dois eixos.
step_w        = 2.4; // mm, largura do ressalto (o rebaixo é step_fit mais largo de cada lado)
step_h        = 1.2; // mm, altura do ressalto acima da face de encontro
step_fit      = 0.25; // mm, folga por lado (folga de deslize do repo)
step_end_clear= 0.4; // mm, o rebaixo é MAIS FUNDO que o ressalto por isto — o fundo do rebaixo NÃO pode encostar no topo do ressalto, senão as faces não se tocam e o ímã perde contato
step_end_gap  = 1.0; // mm, quanto o ressalto recua dos eixos centrais (nas transições ressalto->rebaixo do meio dos lados curtos); o rebaixo vai até o eixo, então sobra esta folga
step_keepout  = 1.0; // mm, parede que sobra entre a ponta do rebaixo e o bolso de ímã (degrau e bolso dividem a mesma linha do aro, então o degrau se interrompe em cada ímã)
step_embed    = 0.6; // mm, quanto o ressalto afunda no aro — encostar só de face deixa o ressalto como SÓLIDO SEPARADO no Nef/CGAL (foi o que aconteceu com o pino da 1a versão: Volumes: 4 em vez de 2)
// Entrada guiada: ressalto comprido entrando em rebaixo com 0.25/lado briga na
// hora de encaixar se não tiver funil. O topo do ressalto afina e a boca do
// rebaixo abre — uma camada de 0.2 cada.
// POR QUE 0.2 E NÃO 0.4: o que guia de verdade é a faixa de ajuste apertado,
// step_h - step_lead - step_mouth. Com 0.4/0.4 essa faixa era 0.4mm, do tamanho
// do próprio erro de impressão: 0.4mm de costura aberta (empeno, cisco, disco
// saliente) e a guia dos lados longos ia A ZERO, sobrando 4 facinhas de 1.87mm².
// Com 0.2/0.2 a faixa dobra pra 0.8mm.
// NOTA (desvio deliberado): a auditoria pediu FILETE na raiz do ressalto,
// herdado do achado do pino. Aqui ele sai pela boca do rebaixo, não pela raiz
// do ressalto: filete de raiz engorda o macho justamente no plano da costura
// (2.4 + 2x0.25 = 2.9 = a largura INTEIRA do rebaixo -> folga zero, e a peça
// deixa de fechar). Alívio na fêmea dá o mesmo ganho — acomoda qualquer
// barriga de extrusão na raiz — sem comer a folga de alinhamento. E o
// argumento de resistência do pino não transfere: o pino era Ø3 x 2.5 em
// balanço com carga PONTUAL; este ressalto é 2.4 x 1.2 (razão de aspecto 0.5)
// com a carga espalhada por ~184mm de borda.
step_lead     = 0.2; // mm, quanto o TOPO do ressalto afina de cada lado
step_mouth    = 0.2; // mm, quanto a BOCA do rebaixo abre de cada lado

/* [Textura hexagonal - baixo relevo na face visível] */
// Identidade do repo. Fica só na faixa do ARO (nunca em cima do lip de 2mm,
// nunca perto das bordas), hexágonos de ponta pra cima, e nenhum hexágono
// chega perto de bolso de ímã nem do encaixe de dedo — o anel externo da
// moldura fica 100% sólido, o que também segura a peça na mesa (é a face que
// vai contra a cama). A colmeia fica na face OPOSTA ao degrau: entre o fundo
// do rebaixo e o fundo do hexágono sobram 3.55mm de material.
// hex_d desceu de 6 pra 4.2 junto com o aro: hexágono de ponta pra cima mede
// hex_d entre faces (X) mas 2*hex_d/sqrt(3) de ponta a ponta (Y), e num aro de 9
// o de 6mm deixaria só 1.03mm de material nos aros CURTOS — lasca. Com 4.2 a
// margem mínima é 2.07mm.
hex_d       = 4.2; // mm, tamanho do hexágono entre faces
hex_pitch   = 7.0; // mm, passo entre hexágonos vizinhos ao longo do aro
hex_depth   = 0.6; // mm, profundidade do baixo relevo
hex_keepout = 1.5; // mm, folga mínima entre hexágono e qualquer furo/bolso/rebaixo

/* [Encaixe de dedo pra abrir] */
// DUAS meia-luas por lado curto, flanqueando o ímã do meio (que agora ocupa o
// centro daquele aro) — 4 no total, mantendo a simetria de rotação de 180°.
// Cada uma atravessa a altura da metade, então com as duas metades fechadas
// vira uma concha com a costura no meio.
// O CHANFRO é o que faz a alavanca funcionar: as duas faces de encontro são
// planas e coplanares, então "unha no vão" não tinha vão nenhum (0mm). Com 45°
// x pry_chamfer na aresta da face de encontro, e as duas metades sendo iguais,
// o chanfro DOBRA e vira um V de 2*pry_chamfer = 2.4mm de boca.
// FERRAMENTA DECLARADA: PALHETA / ESPÁTULA de plástico. Não é unha e não é
// moeda — a força de abertura medida é 17-25N (momento em torno do lado curto
// oposto), unha engata 0.8mm e não faz 17N, e nenhuma moeda de real passa num V
// estreito (a mais fina, R$0,05, tem 1.65mm). Com 2.4mm de boca a moeda de 5
// centavos entra, mas a ferramenta certa segue sendo palheta.
pry_d       = 20;  // mm, diâmetro da meia-lua (dá uma boca de ~14.3mm na borda)
pry_depth   = 3;   // mm, quanto ela morde pra dentro da borda externa (sobram 9mm de aro ali)
pry_x       = 16;  // mm, distância de cada meia-lua ao meio do lado curto (tem que sair de cima do ímã do meio)
pry_chamfer = 1.2; // mm, chanfro de 45° na aresta da face de encontro, dentro da meia-lua (x2 metades = V de 2.4mm de boca)

/* [Gabarito de MEDIÇÃO (part="gauge") - o job que importa agora] */
// A medida do slab é ESTIMATIVA. Este gabarito devolve os TRÊS NÚMEROS em UMA
// impressão, em vez de responder só "entra ou não entra".
// GEOMETRIA: cada estação é um par de PILARES, um de face lisa (referência) e um
// com a face interna em ESCADA no eixo Z — vão maior em cima, menor embaixo. O
// slab desce entre os dois e PARA no degrau que não passa. O número gravado na
// face externa do pilar, na altura daquele degrau, é a medida.
// POR QUE ESCADA EM Z, e não degraus lado a lado: a aresta do slab é uma reta de
// 85 a 140mm. Qualquer escada NO PLANO é varrida inteira por essa aresta ao mesmo
// tempo, e o gabarito lê sempre o EXTREMO (o vão menor) — o valor não muda nunca.
// Foram duas versões erradas desta peça por isso. Em Z o vão é UNIFORME ao longo
// de toda a linha de contato em cada altura, que é a única forma de um passa/não
// passa medir um objeto rígido comprido.
// Bônus: com o vão maior EM CIMA, cada degrau se apoia inteiro no de baixo — o
// ressalto é sempre pra dentro, então não existe balanço e imprime sem suporte.
// POR QUE GABARITO IMPRESSO E NÃO RÉGUA: a régua herda o erro de escala da
// impressora (0.3% em 140mm = 0.4mm). O gabarito sai da MESMA máquina com a MESMA
// retração da moldura — mede em "unidades de impressora", que é o que a cavidade
// precisa. Auto-calibrado.
gw_min = 83;    // mm, menor vão da estação LARG
gw_step = 0.5;  // mm, passo
gw_n = 9;       // 83.0 .. 87.0
gh_min = 133;   // mm, menor vão da estação ALT
gh_step = 1;    // mm, passo (1.0 e não 0.5: em altura o lip pega 2.7mm e a cavidade dá 0.3/lado, então 1mm não muda função nenhuma; largura e espessura é que causam falha dura)
gh_n = 10;      // 133 .. 142
gt_min = 7.0;   // mm, menor vão da estação ESP
gt_step = 0.25; // mm, passo (0.25 aqui porque 0.1 já decide)
gt_n = 5;       // 7.00 .. 8.00
gz_step_h = 3;    // mm, altura de cada degrau em Z
gz_len    = 9;   // mm, comprimento do pilar (linha de contato)
gz_thick  = 4;    // mm, espessura do pilar
gz_base_t = 1.4;  // mm, espessura da base
gz_base_w = 11;   // mm, largura da base
gauge_text  = 2.2; // mm, altura da letra
gauge_text_d = 0.5; // mm, profundidade da gravação

/* [Folgas] */
slab_clear   = 0.3;  // mm, folga por lado NO PLANO (largura/altura) — padrão de peça solta em cavidade do repo, o slab tem que cair na cavidade sem forçar
slab_clear_z = 0.15; // mm, folga por lado NA ESPESSURA. Menor de propósito: aqui folga demais não ajuda a montar (quem fecha é a face de plástico contra a outra, não o slab) e só faz o slab chacoalhar — 0.3/lado dava 0.6mm de vão em Z. 0.15/lado = 0.3 de vão total, slab firme e ainda com margem pra elephant foot.

/* [Qualidade] */
$fn = 64;
// fenda de ar que o preview "closed" abre entre as duas metades. Só existe
// porque dois sólidos dividindo um plano coincidente fazem o CGAL cuspir
// "may not be a valid 2-manifold" na hora de unir (é artefato do union, não
// defeito da peça: a metade sozinha sai Volumes: 2, 1 componente, sem aviso).
// Com preview_gap = 0 o conjunto mede os 11.5 exatos e vem com o aviso; com
// 0.01 (1/20 de camada) o preview sai limpo. A checagem que vale é o
// part="fit", que é interseção e não union.
preview_gap = 0.01;
// altura acima da costura a partir da qual o part="grip" conta engate. Uma
// camada (0.2) já basta pra excluir o embed do ressalto e o overshoot do
// rebaixo, que faziam o teste passar sem engate nenhum.
grip_probe = 0.2;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
cav_w  = slab_w + 2 * slab_clear;          // 85.1  — cavidade do slab em X
cav_h  = slab_h + 2 * slab_clear;          // 140.1 — cavidade do slab em Y
cav_z  = (slab_t + 2 * slab_clear_z) / 2;  // 3.75  — profundidade da cavidade POR METADE (7.5 no conjunto)
half_h = lip_t + cav_z;                    // 5.75  — altura de uma metade (sem contar o ressalto)
shut_h = 2 * half_h;                       // 11.5  — conjunto fechado (o ressalto ocupa o rebaixo, não soma altura)
tall_h = half_h + step_h;                  // 6.95  — altura de impressão da peça solta

out_w = cav_w + 2 * rim;                   // 109.1 — externo em X
out_h = cav_h + 2 * rim;                   // 164.1 — externo em Y
win_w = cav_w - 2 * lip_inset;             // 79.1  — janela em X (vão único)
win_h = cav_h - 2 * lip_inset;             // 134.1 — janela em Y
// quanto do slab o lip cobre de cada lado (a retenção de verdade):
lip_grab = (slab_w - win_w) / 2;           // 2.7

// bolso de ímã: cavado da face de encontro pra baixo. A PROFUNDIDADE é a
// espessura nominal do ímã, sem folga: 0.15 de folga aqui rebaixaria o disco
// nas DUAS metades = 0.3mm de entreferro garantido, e pra ímã de 2mm isso é
// (2/2.3)^2 = -24% de força. Assim os discos se encostam e o batente segue
// sendo plástico contra plástico.
mag_pocket_d = magnet_d + magnet_fit;      // 4.3
mag_pocket_z = magnet_h + magnet_slack;    // 2.1
mag_floor    = half_h - mag_pocket_z;      // 3.75 — material atrás do bolso (não fura pro outro lado)
mag_wall     = (rim - mag_pocket_d) / 2;   // 3.85 — parede de cada lado do bolso, dentro do aro

// posições (peça centrada na origem; centro do ímã na linha do meio do aro)
mag_c = rim / 2;                           // 6.0
mx    = out_w / 2 - mag_c;                 // 48.55 — linha do meio dos aros longos
my    = out_h / 2 - mag_c;                 // 76.05 — linha do meio dos aros curtos
// POSIÇÃO (não vão) dos intermediários do lado longo: a 1/3 e 2/3 do lado, o
// que dá 3 vãos iguais de 2*my/3 = 50.7. O lado curto leva 1 no meio -> 2 vãos
// de mx = 48.55. Maior vão do perímetro inteiro: 50.7mm.
mag_long_mid = my / 3;                     // 25.35
mag_pos = concat(
    [for (sx = [1, -1], sy = [1, -1]) [sx * mx, sy * my]],           // 4 cantos
    [for (sx = [1, -1], sy = [1, -1]) [sx * mx, sy * mag_long_mid]], // 4 nos lados longos
    [for (sy = [1, -1]) [0, sy * my]]                                // 2 no meio dos lados curtos
);
mag_vao_max = max(2 * mag_long_mid, mx);   // 50.7 — maior distância entre ímãs vizinhos

// degrau perimetral
groove_w  = step_w + 2 * step_fit;         // 2.9  — largura do rebaixo
groove_z  = step_h + step_end_clear;       // 1.6  — profundidade do rebaixo
step_side = (rim - groove_w) / 2;          // 4.55 — material de cada lado do rebaixo, dentro do aro
// o degrau divide a linha do aro com os bolsos de ímã, então se interrompe em
// cada um. O RESSALTO recua step_fit mais que o rebaixo, pra ponta de ressalto
// e parede de rebaixo não se encostarem quando fechado.
// 4 meia-luas: 2 por lado curto, flanqueando o ímã do meio
pry_y   = out_h / 2 + pry_d / 2 - pry_depth; // 89.05 — centro da meia-lua, fora da peça
pry_pos = [for (sx = [1, -1], sy = [1, -1]) [sx * pry_x, sy * pry_y]];

// keep-out do degrau em volta de cada FERRAGEM. Não dependem do aro.
// O ressalto recua step_fit MAIS que o rebaixo, pra ponta de ressalto e parede
// de rebaixo não se encostarem quando fechado.
groove_keep = mag_pocket_d / 2 + step_keepout;            // 3.15
ridge_keep  = mag_pocket_d / 2 + step_keepout + step_fit; // 3.40
// as meia-luas TAMBÉM entram no keep-out: sem isso o chanfro da meia-lua passava
// a 0.355mm da boca do rebaixo nas duas meia-luas que caem do lado do rebaixo —
// parede de 0.36mm por 2.5mm de comprimento, que solta e o fragmento cai DENTRO
// do rebaixo (rebaixo com cisco = costura que não fecha = ímã sem contato).
// O raio é medido pra ULTRAPASSAR a borda mais interna do rebaixo em step_keepout:
// com um keep-out menor sobrava uma tira de rebaixo de 0.75mm e uma parede de
// 1.0mm — melhor que 0.355, mas ainda features finas sem função nenhuma. Assim o
// degrau simplesmente não existe na região da meia-lua e a face fica sólida.
pry_groove_keep = pry_y - (out_h / 2 - mag_c - groove_w / 2) + step_keepout; // 13.95
pry_ridge_keep  = pry_groove_keep + step_fit;                               // 14.20



// hexágono: circunraio e grade de centros ao longo das linhas do meio do aro
hex_R  = hex_d / sqrt(3);
hex_cx = [for (i = [-floor(mx / hex_pitch) : floor(mx / hex_pitch)]) i * hex_pitch];
hex_cy = [for (j = [-floor(my / hex_pitch) : floor(my / hex_pitch)]) j * hex_pitch];

// tudo que a textura tem que evitar: [x, y, raio do furo/bolso/rebaixo]
keepouts = concat(
    [for (p = mag_pos) [p[0], p[1], mag_pocket_d / 2]],
    [for (p = pry_pos) [p[0], p[1], pry_d / 2]]
);

// um hexágono só entra se ficar longe de TODA feature (senão sobra lasca)
function hex_ok(x, y) =
    len([for (k = keepouts)
            if (norm([x, y] - [k[0], k[1]]) < k[2] + hex_R + hex_keepout) 1]) == 0;

big = out_w + out_h; // quadrado auxiliar, maior que a peça

// ---------------------------------------------------------------------
// Retângulo 2D de cantos redondos, centrado na origem
// ---------------------------------------------------------------------
module rrect(w, h, r) {
    if (r > 0) offset(r = r) square([w - 2 * r, h - 2 * r], center = true);
    else square([w, h], center = true);
}

// ---------------------------------------------------------------------
// Uma metade da concha (frame): placa da frente com a janela + aro que sobe
// em volta da cavidade do slab. z=0 é a face VISÍVEL (vai contra a cama) e
// z=half_h é a FACE DE ENCONTRO com a outra metade — é nela que ficam os
// bolsos de ímã e o degrau perimetral.
// ---------------------------------------------------------------------
module frame() {
    difference() {
        union() {
            // placa da frente (o lip): face externa cheia
            linear_extrude(lip_t) rrect(out_w, out_h, outer_r);
            // aro em volta da cavidade do slab
            translate([0, 0, lip_t])
                linear_extrude(half_h - lip_t)
                    difference() {
                        rrect(out_w, out_h, outer_r);
                        rrect(cav_w, cav_h, cav_r);
                    }
            step_ridge();
        }

        // janela: UM vão único e contínuo (carta + etiqueta PSA juntas)
        translate([0, 0, -0.1])
            linear_extrude(tall_h + 0.2)
                rrect(win_w, win_h, window_r);

        magnet_pockets();
        step_groove();
        pry_notches();
        cav_mouth_chamfer();
        hex_texture();
    }
}

// Chanfro de 45° na boca da cavidade (aresta superior interna do aro). Subtrai o
// tronco inteiro: a parte de dentro já é vazio, então o que sobra é só o chanfro.
module cav_mouth_chamfer() {
    hull() {
        translate([0, 0, half_h - cav_chamfer])
            linear_extrude(0.01) rrect(cav_w, cav_h, cav_r);
        translate([0, 0, half_h - 0.005])
            linear_extrude(0.01)
                rrect(cav_w + 2 * cav_chamfer, cav_h + 2 * cav_chamfer, cav_r + cav_chamfer);
    }
}

// Bolsos de ímã na face de encontro (press-fit), 4 cantos + 2 no meio dos
// lados longos. Fundo a mag_floor da face externa -> não fura pro outro lado;
// mag_wall de parede de cada lado -> não invade a cavidade do slab.
module magnet_pockets() {
    for (p = mag_pos)
        translate([p[0], p[1], mag_floor]) {
            cylinder(h = mag_pocket_z + 0.1, d = mag_pocket_d);
            // alívio de cola: a cola tem pra onde ir em vez de levantar o disco
            translate([0, 0, -magnet_relief_h])
                cylinder(h = magnet_relief_h + 0.01, d = magnet_relief_d);
        }
}

// ---------------------------------------------------------------------
// Degrau perimetral
// ---------------------------------------------------------------------
// Faixa (anel) de largura w correndo a linha do meio do aro. Cantos retos: o
// canto da faixa é sempre engolido pelo keep-out do ímã de canto (que fica
// exatamente na quina da linha do meio), então não sobra bico nenhum.
module band_2d(w) {
    difference() {
        square([2 * mx + w, 2 * my + w], center = true);
        square([2 * mx - w, 2 * my - w], center = true);
    }
}

// Quadrantes 1 e 3, recuados step_end_gap dos dois eixos — é o vão das 4
// transições ressalto->rebaixo, que caem no meio de cada aro. No lado CURTO a
// transição cai dentro do keep-out do ímã do meio e o vão vem de graça; no lado
// LONGO não tem ímã em (±mx, 0) desde o layout de 10, então quem abre o vão ali
// é o step_end_gap mesmo.
module ridge_2d() {
    intersection() {
        band_2d(step_w);
        union() {
            translate([step_end_gap, step_end_gap]) square(big);
            translate([-step_end_gap - big, -step_end_gap - big]) square(big);
        }
    }
}

// Quadrantes 2 e 4, indo até os eixos (o rebaixo é sempre o mais generoso)
module groove_2d() {
    intersection() {
        band_2d(groove_w);
        union() {
            translate([-big, 0]) square(big);
            translate([0, -big]) square(big);
        }
    }
}

// `extra` = 0 pro rebaixo, step_fit pro ressalto (o ressalto recua mais).
module step_keep_cyls(extra) {
    h = groove_z + step_h + 2.1;
    z = half_h - groove_z - 1;
    for (p = mag_pos)
        translate([p[0], p[1], z]) cylinder(h = h, r = groove_keep + extra);
    for (p = pry_pos)
        translate([p[0], p[1], z]) cylinder(h = h, r = pry_groove_keep + extra);
}

module step_ridge() {
    difference() {
        union() {
            // corpo, do embed até o começo da entrada guiada
            translate([0, 0, half_h - step_embed])
                linear_extrude(step_embed + step_h - step_lead) ridge_2d();
            // topo afinado (entrada guiada)
            translate([0, 0, half_h + step_h - step_lead])
                linear_extrude(step_lead) offset(delta = -step_lead) ridge_2d();
        }
        step_keep_cyls(step_fit);
    }
}

module step_groove() {
    difference() {
        union() {
            // corpo do rebaixo (é ele que faz o alinhamento: 0.25/lado)
            translate([0, 0, half_h - groove_z])
                linear_extrude(groove_z - step_mouth) groove_2d();
            // boca alargada (funil de entrada + alívio da raiz do ressalto)
            translate([0, 0, half_h - step_mouth])
                linear_extrude(step_mouth + 0.1) offset(delta = step_mouth) groove_2d();
        }
        step_keep_cyls(0);
    }
}

// Meia-lua de dedo (4: duas por lado curto, flanqueando o ímã do meio).
// Atravessa a altura da metade e só morde pry_depth da borda externa, então não
// chega no degrau, que corre a rim/2 = 6mm da borda. O cone no topo é o chanfro
// de 45° na aresta da FACE DE ENCONTRO: sem ele a costura fecha com 0mm de vão
// e não tem por onde entrar unha.
module pry_notches() {
    for (p = pry_pos) {
        translate([p[0], p[1], -0.1])
            cylinder(h = half_h + 0.2, d = pry_d);
        translate([p[0], p[1], half_h - pry_chamfer])
            cylinder(h = pry_chamfer + 0.1,
                     r1 = pry_d / 2,
                     r2 = pry_d / 2 + pry_chamfer + 0.1);
    }
}

// Textura de colmeia em baixo relevo na face visível, uma fileira correndo na
// linha do meio de cada um dos 4 aros. Hexágonos de ponta pra cima.
module hex_texture() {
    for (s = [1, -1]) {
        for (y = hex_cy) if (hex_ok(s * mx, y)) hex_cell(s * mx, y);
        for (x = hex_cx) if (hex_ok(x, s * my)) hex_cell(x, s * my);
    }
}

module hex_cell(x, y) {
    translate([x, y, -0.1])
        rotate([0, 0, 30]) // ponta pra cima
            cylinder(h = hex_depth + 0.1, r = hex_R, $fn = 6);
}

// ---------------------------------------------------------------------
// A segunda cópia, virada e posta em cima da primeira (é a MESMA peça).
// dz > 0 abre uma fenda de ar entre as faces, pra checagem de interferência.
// ---------------------------------------------------------------------
module mated(dz = 0) {
    translate([0, 0, shut_h + dz])
        rotate(mate_flip == "y" ? [0, 180, 0] : [180, 0, 0])
            frame();
}

// ---------------------------------------------------------------------
// Gabarito de MEDIÇÃO (gauge) — 3 estações de escada em Z numa peça só:
//   ALT   142 (topo) -> 133 (fundo), passo 1.0
//   LARG   87.0 -> 83.0, passo 0.5
//   ESP     8.00 -> 7.00, passo 0.25 (entra a ARESTA do slab)
// COMO USA: encosta a aresta do slab no pilar LISO (referência), desce entre os
// dois pilares e para de descer quando travar. O número gravado na face externa
// do pilar em escada, na altura onde o slab parou, é o limite INFERIOR; o degrau
// de cima, que ele passou, é o superior. Ex.: passa 85.0 e trava em 84.5 ->
// largura entre 84.5 e 85.0.
//   openscad -o 3mf/psa-bumper-01-gauge.3mf -D 'part="gauge"' psa-bumper-01.scad
// ---------------------------------------------------------------------
gw_max = gw_min + (gw_n - 1) * gw_step;  // 87.0
gh_max = gh_min + (gh_n - 1) * gh_step;  // 142.0
gt_max = gt_min + (gt_n - 1) * gt_step;  // 8.0
function gz_h(n) = n * gz_step_h;        // altura da escada

// posição das estações. ALT mede em Y (a maior), LARG e ESP medem em X.
gh_x = 0;              // pilar de referência da ALT
gw_y = 24;             // pilar de referência da LARG
gt_y = 44;             // pilar de referência da ESP

// Uma estação: pilar de referência (face interna em u = 0), pilar em escada
// (face interna em u = umin + i*ustep no degrau i) e a base ligando os dois.
// swap = false mede em X; true mede em Y.
module g_station(v0, umin, ustep, n, dec, swap) {
    uout = umin + (n - 1) * ustep + gz_thick;
    // base
    if (swap) translate([v0, -gz_thick, 0]) cube([gz_base_w, uout + gz_thick, gz_base_t]);
    else      translate([-gz_thick, v0, 0]) cube([uout + gz_thick, gz_base_w, gz_base_t]);
    // pilar de referência (face lisa em u=0)
    if (swap) translate([v0, -gz_thick, 0]) cube([gz_len, gz_thick, gz_base_t + gz_h(n)]);
    else      translate([-gz_thick, v0, 0]) cube([gz_thick, gz_len, gz_base_t + gz_h(n)]);
    // pilar em escada: degrau i vai de u = umin + i*ustep até uout,
    // em z de base + i*h a base + (i+1)*h. Vão MAIOR no topo -> cada degrau
    // se apoia inteiro no de baixo, sem balanço.
    for (i = [0 : n - 1]) {
        ui = umin + i * ustep;
        if (swap)
            translate([v0, ui, gz_base_t + i * gz_step_h])
                cube([gz_len, uout - ui, gz_step_h]);
        else
            translate([ui, v0, gz_base_t + i * gz_step_h])
                cube([uout - ui, gz_len, gz_step_h]);
    }
}

// Números gravados na face EXTERNA do pilar em escada, na altura de cada degrau.
module g_station_text(v0, umin, ustep, n, dec, swap) {
    uout = umin + (n - 1) * ustep + gz_thick;
    for (i = [0 : n - 1]) {
        val = umin + (n - 1 - i) * ustep;   // topo = maior
        txt = dec ? str(val) : str(round(val));
        zc = gz_base_t + (n - 1 - i) * gz_step_h + gz_step_h / 2;
        // ATENÇÃO: rotate([90,0,0]) e rotate([90,0,90]) extrudam pra DENTRO (-Y e
        // -X). A âncora tem que ficar NA superfície (uout), não recuada: com ela
        // recuada o corte virava um vazio ENTERRADO 0.5mm sob a pele, e o miolo
        // fechado de cada dígito (o buraco do 8, do 0, do 4) soltava como ilha —
        // 30 sólidos separados no Nef, e nada legível na peça impressa.
        // Duas armadilhas de orientação, as duas pegas OLHANDO o render:
        //  1. a âncora fica NA superfície (uout) e a extrusão tem que ir pra
        //     DENTRO. rotate([90,0,0]) extruda em -Y (ok pra face +Y);
        //     rotate([90,0,90]) extruda em +X, ou seja pra FORA — engravava o ar
        //     e a face saía LISA. Pra face +X o certo é rotate([90,0,-90]).
        //  2. visto de fora, o texto sai ESPELHADO se não levar o mirror.
        if (swap)
            translate([v0 + gz_len / 2, uout + 0.01, zc])
                rotate([90, 0, 0]) mirror([1, 0, 0])
                    linear_extrude(gauge_text_d + 0.02)
                        text(txt, size = gauge_text, halign = "center", valign = "center",
                             font = "Liberation Sans:style=Bold");
        else
            translate([uout + 0.01, v0 + gz_len / 2, zc])
                rotate([90, 0, -90]) mirror([1, 0, 0])
                    linear_extrude(gauge_text_d + 0.02)
                        text(txt, size = gauge_text, halign = "center", valign = "center",
                             font = "Liberation Sans:style=Bold");
    }
}

module gauge_sem_texto() {
    union() {
        g_station(gh_x, gh_min, gh_step, gh_n, false, true);
        g_station(gw_y, gw_min, gw_step, gw_n, true,  false);
        g_station(gt_y, gt_min, gt_step, gt_n, true,  false);
        translate([-gz_thick, -gz_thick, 0])
            cube([gz_base_w + gz_thick, gt_y + gz_base_w + gz_thick, gz_base_t]);
    }
}

module gauge() {
    difference() {
        union() {
            g_station(gh_x, gh_min, gh_step, gh_n, false, true);  // ALT (mede em Y)
            g_station(gw_y, gw_min, gw_step, gw_n, true,  false); // LARG (mede em X)
            g_station(gt_y, gt_min, gt_step, gt_n, true,  false); // ESP (mede em X)
            // espinha ligando as bases das três estações
            translate([-gz_thick, -gz_thick, 0])
                cube([gz_base_w + gz_thick, gt_y + gz_base_w + gz_thick, gz_base_t]);
        }
        g_station_text(gh_x, gh_min, gh_step, gh_n, false, true);
        g_station_text(gw_y, gw_min, gw_step, gw_n, true,  false);
        g_station_text(gt_y, gt_min, gt_step, gt_n, true,  false);
        // rótulos das estações, gravados na base
        translate([0, 0, gz_base_t - gauge_text_d]) linear_extrude(gauge_text_d + 0.01) {
            translate([1.0, gh_min - 8])    text("ALT",  size = gauge_text, font = "Liberation Sans:style=Bold");
            translate([28, gw_y + 3.5])     text("LARG", size = gauge_text, font = "Liberation Sans:style=Bold");
            translate([28, gt_y + 3.5])     text("ESP",  size = gauge_text, font = "Liberation Sans:style=Bold");
        }
    }
}

// Disquinho no plano de encontro, no centro de cada bolso de ímã: a
// interseção dos disquinhos das duas metades mostra quais pares realmente se
// encontram.
module mag_probes() {
    for (p = mag_pos)
        translate([p[0], p[1], half_h - 0.2])
            cylinder(h = 0.4, d = mag_pocket_d);
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "frame") {
    frame();
} else if (part == "gauge") {
    // gabarito de MEDIÇÃO — job de impressão de verdade (3mf/psa-bumper-01-gauge.3mf)
    gauge();
} else if (part == "plate") {
    // chapa da A1 mini: UMA moldura, de boca pra cima, sem suporte.
    // Duas não cabem juntas -> imprimir esta mesma chapa 2x.
    translate([out_w / 2, out_h / 2, 0]) frame();
} else if (part == "closed") {
    frame();
    mated(preview_gap);
} else if (part == "fit") {
    // DEBUG: tem que sair VAZIO (nenhuma colisão entre as metades)
    intersection() {
        frame();
        mated(0.02);
    }
} else if (part == "pairs") {
    // DEBUG: tem que sair 10 discos (os 10 pares de ímã se encontrando)
    intersection() {
        mag_probes();
        translate([0, 0, shut_h])
            rotate(mate_flip == "y" ? [0, 180, 0] : [180, 0, 0])
                mag_probes();
    }
} else if (part == "column") {
    // DEBUG de ENTREFERRO (teste da re-auditoria): coluna de ar no eixo de cada
    // ímã, atravessando a costura. TEM QUE SAIR 10 COLUNAS, cada uma com
    // 2*mag_pocket_z = 4.2mm de altura contínua — é o que prova que os bolsos se
    // encontram em Z e que nada (degrau, chanfro) invade o caminho do disco.
    // O part="pairs" só prova alinhamento em XY; este prova em Z.
    // Controle POSITIVO: com -D step_keepout=-2 o degrau invade a coluna e o
    // teste tem que ACUSAR (colunas partidas ou mais curtas que 4.2).
    difference() {
        union()
            for (p = mag_pos)
                translate([p[0], p[1], mag_floor - 0.5])
                    cylinder(h = 2 * mag_pocket_z + 1, d = mag_pocket_d - 0.02);
        frame();
        mated(0);
    }
} else if (part == "grip") {
    // DEBUG de ENGATE: o ressalto desta metade dentro do rebaixo da outra.
    // TEM QUE SAIR 6 SEGMENTOS (Volumes: 7). É o teste que impede o part="fit"
    // de passar por vacuidade: ressalto de altura zero, ou fora de posição,
    // não colide com nada e o fit sai vazio do mesmo jeito.
    // O corte em z = half_h + grip_probe é ESSENCIAL: sem ele o teste passa
    // pelo embed do ressalto e pelo overshoot de 0.1 do rebaixo (medido: com
    // ressalto de 0.001mm de altura ainda saía Volumes: 5). Com o corte, só
    // conta material que sobe de verdade acima da costura.
    intersection() {
        step_ridge();
        translate([0, 0, shut_h])
            rotate(mate_flip == "y" ? [0, 180, 0] : [180, 0, 0])
                step_groove();
        translate([-out_w, -out_h, half_h + grip_probe])
            cube([2 * out_w, 2 * out_h, tall_h]);
    }
} else {
    frame();
}
