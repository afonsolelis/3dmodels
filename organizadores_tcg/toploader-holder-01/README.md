# toploader-holder-01

Dispenser **2-em-1** de **top loader** (em cima) e **penny sleeve** (embaixo),
numa caixa única de **84 × 109 × 150mm**, aberta em cima e com **janela de vão
contínuo na frente**. Colmeia hexagonal passante nas duas laterais e no fundo.

Capacidade estimada: **~92 top loaders** (116mm de curso a 1,25mm cada) e
**~375 penny sleeves** (30mm de bolso a 0,08mm cada).

## O truque: quem separa é a gravidade

Não existe divisória, prateleira, ponte nem peça móvel dentro da caixa. O que
faz o 2-em-1 é um **degrau (ledge) a 34mm do chão**, onde a parede passa de
6,5mm para 3,0mm:

```
          ┌─────────────────────────┐  z=150  boca aberta
          │                         │
          │   câmara TOP LOADER     │  78,0 × 103,0 × 116  (folga 0,9/lado)
          │   ~92 top loaders       │
          │                         │
          ├──┐                   ┌──┤  z=34   ◄── DEGRAU
          │  │  bolso SLEEVE     │  │  71,0 × 99,0 × 30
          │  │  ~375 sleeves     │  │
          ├──┴───────────────────┴──┤  z=4    topo do piso
          │          piso           │
          └─────────────────────────┘  z=0
```

O bolso de baixo tem **71,0mm** de vão. O top loader tem **76,2mm**: não entra,
para em cima do degrau com **2,6mm de apoio de cada lado**. O penny sleeve tem
**66,7mm**: cai livre, com 2,15mm de folga por lado. É só isso — e é por isso
que a peça não tem nenhum ponto frágil.

**Bônus de impressão:** subindo, o material **recua** (parede de 6,5 vira 3,0).
O degrau é uma face virada pra **cima**, então tem **balanço zero**. Auditado na
malha exportada: **100% da área virada pra baixo está exatamente a 45°**, fora a
face que assenta na cama. Imprime **em pé, boca pra cima, sem suporte nenhum**.

## De onde veio

Derivado do [`../2-in-1_Top_Loader___Sleeve_Holder.3mf`](../2-in-1_Top_Loader___Sleeve_Holder.3mf)
— *2-in-1 Top Loader & Sleeve Holder* ("Deck Daddy"), de **HeyHalo**
(MakerWorld, 2025-06-23), **licença CC0** declarada no próprio 3MF.

Este `.scad` é **reconstrução paramétrica própria**: nada da malha foi copiado,
só medidas de engenharia reversa. Medido na malha (1809 vértices / 3614
triângulos, 1 sólido estanque, volume 121,1cm³):

| | Original | Aqui |
|---|---|---|
| envelope | 82,0 × 107,0 × **84,0** | 84,0 × 109,0 × **150,0** |
| parede | 2,5 (bolso 5,5) | 3,0 (bolso 6,5) |
| vão de cima | 77,0 × 102,0 | 78,0 × 103,0 |
| bolso | 71,0 × 99,0 × 30 | 71,0 × 99,0 × 30 (igual) |
| piso | 4,0 maciço | 4,0 maciço (igual) |
| degrau | 3,0 lateral / 3,0 fundo, em z=−8 | 3,5 lateral / 4,0 fundo, em z=34 |
| janela | 60,0 de vão, até a boca | 60,0 de vão, até z=142 |
| curso de top loader | 50mm (~40 peças) | **116mm (~92 peças)** |

A ausência de prateleira foi **confirmada por corte booleano renderizado** na
malha de origem, não deduzida: é uma câmara só, com o degrau na parede.

## ⚠️ Nenhuma medida aqui saiu de régua

`tl_w` × `tl_h` = **76,2 × 101,6mm** (3" × 4") e `sleeve_w` × `sleeve_h` =
**66,7 × 92,1mm** são **catálogo**, e os vãos vieram da **malha de origem**, não
do objeto na mão do usuário. É a mesma ressalva do
[`penny-holder-01`](../penny-holder-01/) e do
[`sleeve-tower-01`](../../cardholders/sleeve-tower-01/) — ver [o bloco de alerta
da categoria](../README.md).

O atenuante é que a caixa de origem **foi impressa e aprovada por terceiros**
com esses vãos. O risco real está no **bolso**, que só funciona enquanto
`pocket_w` ficar **entre** a largura do sleeve e a do top loader. As duas folgas
estão ecoadas nos derivados — confira antes de imprimir:

```
bolso 71,0 → sleeve entra com 2,15/lado   |   top loader para com 2,6/lado
```

Quando a régua chegar, um include conserta o modelo inteiro:

```scad
// toploader-holder-01-medido.scad
pocket_w_override = 72.5;
cav_w_override    = 79.0;
include <toploader-holder-01.scad>
```

## O que mudou em relação ao original, e por quê

1. **Altura 84 → 150** (pedido do usuário). Os 66mm extras vão **inteiros** pra
   câmara de top loader: 50 → 116mm, de ~40 pra ~92 peças. Piso e bolso ficam
   como estavam — mexer neles mudaria a função, não a capacidade pedida.
2. **Parede 2,5 → 3,0**, crescendo **pra fora** (82×107 → 84×109), nunca comendo
   o vão. Lição já paga do `sleeve-tower-01`: a 150mm de altura, parede de 2mm
   empena. Aqui ainda por cima a quarta parede é um rasgo de 138mm.
3. **Vão de cima 77,0 → 78,0** (folga do top loader de 0,4 → **0,9/lado**).
   Regra 6 do repo na versão aprendida no `deckbox-02`: quanto mais alto o tubo
   impresso em pé, mais a parede entra de barriga e mais subdimensionada sai a
   cavidade em XY. 0,4/lado passa numa parede de 84mm e vira sorteio numa de
   150mm. O fundo (Y) sobe junto, 102 → 103.
4. **Cinta de 8mm** fechando a volta no topo, com a janela morrendo em duas
   águas de 45°. O original não tem — a janela dele vai até a boca. A 84mm isso
   passa; a 150mm o montante da frente vira coluna esbelta. Mesmo remédio do
   `penny-holder-01`: a cinta trabalha em **tração** ao longo de X, seção
   3,0 × 8,0 = 24mm², ~720N em PLA a 30MPa, contra um empurrão de pilha que não
   chega a 1% disso.
5. **Colmeia passante** nas duas laterais e no fundo (regra 5 do repo), com
   **bico de 45°** — não o hexágono regular, cujo bico fica a 30° da horizontal,
   que é exatamente o limiar de suporte do Flash Studio (o usuário fatia com
   suporte ligado). **Célula de 18mm**, e não os 24 do `penny-holder-01`: aqui a
   célula tem que caber **inteira** na faixa útil, e com 24 sobravam 3 fileiras
   com vazio morto em cima e embaixo.
   A colmeia só existe **acima do degrau** — o bolso de sleeve inteiro fica
   **maciço**, e não é estética: penny sleeve é mole e largo demais pra 71mm de
   bolso, e com furo passante ele faz barriga pra fora e enrosca na hora de
   puxar. De quebra, os 34mm de baixo maciços são o lastro contra tombamento.
6. **Chanfro de 1,2 na boca** (o original tem só o aro arredondado): guia o top
   loader na entrada. Material que **recua** subindo, não custa balanço nenhum.

## Jobs de impressão

| Job | Conteúdo | Footprint (medido com `bbox.py`) | Material |
|---|---|---|---|
| `3mf/toploader-holder-01-plate.3mf` | 1 caixa | 84,0 × 109,0 × 150,0mm → **ok** | 158,8cm³ (~197g) |
| `3mf/toploader-holder-01-par.3mf` | 2 caixas, vão de 6mm | 174,0 × 109,0 × 150,0mm → **ok** | 317,6cm³ (~394g) |

Nos dois casos a caixa vai com os **109 no eixo Y**, que é o eixo que a cama da
AD5X balança: base maior contra a inércia de uma torre de 150mm.

**Sem suporte** (auditado: 5.096mm² de face virada pra baixo, **toda** a 45°).
**Brim não é necessário** — a primeira camada é o piso inteiro, 9.154mm² maciços
—, mas um skirt ajuda a estabilizar 150mm de torre com a frente aberta.

`stl/toploader-holder-01-box.stl` é a peça avulsa, de referência.

## Como se manuseia

1. A caixa fica **de pé na mesa**, janela virada pra você. Não tem tampa.
2. **Guardar top loader:** pela **boca**, em cima. Ele entra deitado (76,2 no X,
   101,6 no Y) e a pilha cresce em Z, assentando no degrau.
3. **Tirar top loader:** pela boca também, puxando o de cima. São 116mm de curso
   útil; o de baixo fica a 34mm da mesa, altura confortável de pinça.
4. **Guardar penny sleeve:** pela **janela**, na altura do piso. Com a caixa
   ainda vazia de top loader dá pra guardar por cima também, deixando o sleeve
   cair pelo vão do bolso; com a caixa cheia, só pela janela.
5. **Tirar penny sleeve:** dois dedos pela janela na altura do piso, pinça e
   puxa pra frente. O peitoril está **rente ao topo do piso** (z=4), sem degrau
   nenhum pra enroscar, e a pilha de top loader **não desce no lugar** — ela
   está apoiada no degrau, 30mm acima.
6. **Nada cai pela janela:** 60mm de vão contra 66,7 de sleeve (3,35/lado de
   mordida) e 76,2 de top loader (8,1/lado).

## Parâmetros que valem a pena mexer

Sempre por **include**, nunca por `-D` — o `-D` entra no fim do escopo de topo,
depois do `is_undef()`, e cai no default calado (armadilha registrada no
`CLAUDE.md`). Por CLI, mirar a variável **final** (`-D box_z=110`).

| Parâmetro | Padrão | Efeito |
|---|---|---|
| `box_z_override` | 150,0 | altura total; o curso de top loader absorve tudo |
| `cav_w_override` / `cav_d_override` | 78,0 / 103,0 | vão da câmara de cima |
| `pocket_w_override` / `pocket_d_override` | 71,0 / 99,0 | vão do bolso — **é ele que faz o 2-em-1** |
| `hex_d_override` | 18,0 | célula da colmeia |
| `hex_walls` | `true` | `false` deixa as três paredes maciças |

Os `assert` cobrem o que quebra a peça: altura/footprint fora da AD5X, top
loader que deixa de parar no degrau (`bite_tl_x < 2,0`), sleeve que não cabe no
bolso, conteúdo que não cabe na câmara de cima, sleeve escapando pela janela e
parede sem altura pra uma fileira de colmeia.

## Diagnóstico (não exportar pra `3mf/`)

```
-D 'part="content"'   caixa + as duas pilhas, pra conferir no render
-D 'part="cut"'       meia caixa, pra olhar o degrau por dentro
```
