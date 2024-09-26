public enum enumPiece {
 SINGLE,
 DIAGONALE2,
 DIAGONALE2R,
 DIAGONALE3,
 DIAGONALE3R,
 LIGNE2V,
 LIGNE3V,
 LIGNE4V,
 LIGNE5V,
 LIGNE2H,
 LIGNE3H,
 LIGNE4H,
 LIGNE5H,
 LITTLE_L,
 LITTLE_L90,
 LITTLE_L180,
 LITTLE_L270,
 MIDDLE_L,
 MIDDLE_L90,
 MIDDLE_L180,
 MIDDLE_L270,
 BIG_L,
 BIG_L90,
 BIG_L180,
 BIG_L270,
 LITTLE_T,
 LITTLE_T90,
 LITTLE_T180,
 LITTLE_T270,
 BIG_T,
 BIG_T90,
 BIG_T180,
 BIG_T270,
 CROIX,
 C,
 C90,
 C180,
 C270,
 CARRE,
 Z,
 Z90,
 ZR,
 ZR90;
}

class Piece {
 
  enumPiece type;
  int index;
  
  Piece(int i) {
    this.type = getRandomPiece();
    this.index = i;  
  }
  
  Piece(enumPiece p, int i) {
    this.type = p;
    this.index = i;
  }
  
  public void display () {
  }
}
