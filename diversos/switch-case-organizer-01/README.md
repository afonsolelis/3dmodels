# switch-case-organizer-01

Organizador aberto para 12 caixas físicas de jogos Nintendo Switch / Switch 2.
As medidas de encaixe foram reconstruídas da malha de referência
`../switch_game_tray_12.3mf`: 12 canais de 11,25 mm, passo de 13 mm e apoio
de 110,1 mm. A geometria foi refeita do zero em OpenSCAD.

Em relação à referência, cada divisória cresce de aproximadamente 14,4 para
30 mm de altura e passa a guiar 28 mm em cada ponta. Isso segura cada caixa em
quatro regiões, enquanto a abertura central de 54,1 mm facilita a retirada.
As longarinas laterais de 3 mm ficam completamente fora da interface de
158,25 mm: inclusive o primeiro e o último canal mantêm os 11,25 mm livres.
O corpo continua com 164,25 × 110,1 × 32,4 mm. Agora, dois pares de
rabos-de-andorinha verticais tornam o organizador modular: cada unidade tem
receptores fêmea à esquerda e machos à direita, portanto unidades idênticas
podem ser repetidas lado a lado. A folga de deslizamento é 0,5 mm por lado,
com chanfro inferior de 1,2 mm e afastamento do macho em relação à primeira
camada para tolerar pé de elefante. O envelope de impressão com conectores é
176,25 × 112,5 × 32,4 mm.

Para montar, alinhe os dois pares e baixe uma unidade paralela à outra por
todo o curso vertical de 28 mm. Para desmontar, segure as bases e levante
uma unidade pelo mesmo curso. Os conectores ficam perto das duas pontas para
resistir à torção sem ocupar os canais; os 12 vãos continuam com 11,25 mm.
O passo entre corpos acoplados é 171,75 mm. O negativo da fêmea é derivado
diretamente do perfil macho na posição da unidade vizinha, com abertura de
aproximadamente 9,4 mm contra cabeça macho de 12 mm, preservando cerca de
1,3 mm de retenção lateral em cada lado.
As paredes externas da fêmea começam diretamente em `z=0`, apoiadas na cama,
sem anel suspenso. No primeiro 1,2 mm de altura, o canal recebe 0,3 mm extra
por face e converge para a folga nominal, compensando pé de elefante.

Duas cintas externas de 1,2 × 4 mm percorrem a frente e o fundo junto ao
topo das guias, estabilizando todas as divisórias sem entrar nos canais. A
faixa contínua usa três linhas de bico 0,4; aberturas triangulares sob ela
substituem pontes retas por diagonais autoportantes. O acesso central e a
inserção vertical das caixas permanecem livres. Com as cintas, a profundidade
total de impressão passa a 112,5 mm.

## Jobs de impressão

| Arquivo | Conteúdo | Footprint |
|---|---|---|
| `3mf/switch-case-organizer-01.3mf` | unidade **modular**, com os dois pares de rabos-de-andorinha | 176,25 × 112,5 × 32,4 mm |
| `3mf/sem-encaixe.3mf` | unidade **avulsa**, mesma geometria sem os conectores — para quem vai imprimir uma só | 164,25 × 112,5 × 32,4 mm |

Imprima o arquivo em `3mf/` na orientação em que ele abre no Flash Studio,
sem suporte. O teste físico com as caixas do usuário ainda é necessário.
