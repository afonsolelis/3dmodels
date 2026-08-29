// preview-4cores.scad -- SO PARA OLHAR, nao e' peca.
// Remonta as 6 pecas do 3MF multicolor com as cores sugeridas, pra conferir a
// olho que a cor casa com o relevo. Renderizar em PREVIEW (sem --render): o
// --render passa por CGAL e joga a cor fora.
P = "pokemon-filler-card-01";
A = "pokemon-filler-card-01-armarouge";
color("#f2ede3") import(str("stl/", P, "-body.stl"));
color("#3b2c2b") import(str("stl/", P, "-trim.stl"));
color("#f2ede3") import(str("stl/", A, "-vao.stl"));
color("#e5cd2c") import(str("stl/", A, "-cor1.stl"));
color("#cd321f") import(str("stl/", A, "-cor2.stl"));
color("#3b2c2b") import(str("stl/", A, "-cor3.stl"));
