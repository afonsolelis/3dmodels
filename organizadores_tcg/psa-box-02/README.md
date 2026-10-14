# psa-box-02

Caixa de **10 slabs PSA** com **Pokébola gravada na tampa**. É a fonte
OpenSCAD própria do
[Porta carte PSA x10](../terceiros/no-ams-scatola-porta-10-carte-psa-pokemon-pokeball/)
(DAMA_Lab), refeita do zero a partir de medidas tiradas da malha dele e
**dimensionalmente igual à original**. Nenhum triângulo do original foi copiado.

## Histórico: a versão "engrossada" foi desfeita (2026-10-13)

A primeira versão desta fonte engrossava a caixa e abria a folga para o padrão
de deslize do repo (0.5/lado). Ela foi impressa e o **teste físico reprovou**:
a capa ficou um pouco solta, e a original estava muito boa na mão. Por escolha
do usuário, tudo voltou aos números da original:

| | Versão engrossada (desfeita) | Agora = original |
|---|---|---|
| Parede da tampa | 3.0mm | **1.9mm** |
| Teto da tampa / sob a Pokébola | 3.0 / 2.0mm | **1.9 / 0.9mm** |
| Folga tampa ↔ gargalo | 0.5mm/lado | **0.1mm/lado** |
| Entrada | chanfro 1.0 no gargalo, 0.5 na boca da tampa | **raio r1.0** no topo do gargalo e na boca da tampa |
| Cantos do gargalo / vão da tampa | r1.5 / r0.5 | **quina viva** nos dois |
| Cantos verticais externos | r5.0 | **r2.0** |
| Aresta do chão da base / teto da tampa | chanfro 0.6 / 1.5 | **raio r2.0 / r3.0** |
| Parede da base / chão | 6.5 / 4.0mm | **5.0 / 3.5mm** |
| Base / tampa / fechada | 98 × 101.5 × 106 / 71 / 147 | **95 × 98.5 × 105.5 / 70 / 145.5** |

A folga de **0.1mm/lado contraria a regra 6 do CLAUDE.md de propósito**: neste
encaixe de 30mm com tampa de parede fina, a 0.5/lado foi testada e ficou solta.
Não "corrigir" de volta.

O **interior não mudou**: canaleta de 85.0 × 88.5, 10 vagas de 7.5 com
divisória de 1.5 (passo 9.0), nervuras de 7mm saindo das paredes laterais e
140.1mm do chão da vaga ao teto da tampa fechada.

## Peças e jobs

| Job | Conteúdo | Footprint (medido no STL) | Sólido |
|---|---|---|---|
| `3mf/psa-box-02-plate.3mf` | base + tampa lado a lado | 198.0 × 98.5 × 105.5mm | 211.5 + 64.0cm³ |
| `3mf/psa-box-02-lid.3mf` | só a tampa | 95.0 × 98.5 × 70.0mm | 64.0cm³ |

As duas peças imprimem **sem suporte** na orientação exportada: a base com o
chão na cama, a tampa com a Pokébola na cama. Como o gargalo é o mesmo da
original, a tampa sozinha também fecha a base original já impressa.

## Conferido contra a original

Cortes da malha exportada em várias alturas batem com a malha da DAMA_Lab em
~0.05mm (parede, gargalo, vão, raios), e o volume dá 211.5 / 64.0cm³ contra
211.6 / 64.0 da original. Diferenças de sub-milímetro que ficaram: o topo da
nervura é reto até 76.5 com rampa até 80.5 acima do chão da vaga (na original
é curvo e termina a 80.0), o pé da nervura é uma rampa 45° de 3mm (na original
é uma concordância curva) e a Pokébola é centrada (na original está 0.28mm
fora de centro).

## Pokébola

A gravação (1mm) fica na face que vai na cama, então o fundo dela é ponte. No
anel, onde a linha corre paralela à direção da ponte, o vão chega a ~40mm e o
fundo pode sair meio caído — é estético e a original tem o mesmo. Com o IFS
da AD5X dá pra pôr uma troca de cor no primeiro 1mm e preencher a gravação.

## Fatiador

O perfil da original vinha em 0.16mm, 2 paredes e 10% de preenchimento. Com
bico 0.4, 4 perímetros deixam a parede de 1.9 da tampa praticamente maciça.
