final int NB_PIECE = 3;

Menu currentMenu;
Button[] acceuilButtons;
Boolean[] acceuilButtonsActivated;
Button[] jeuButtons;
Boolean[] jeuButtonsActivated;

Board b;
Piece[] p;
Board[] pieces;

color backgroundTop;
color backgroundBot;

void setup() {
  size (800, 800);
  currentMenu = Menu.ACCEUIL;
  acceuilButtons = new Button[1];
  jeuButtons = new Button[1];
  acceuilButtonsActivated = new Boolean[] {false};
  jeuButtonsActivated = new Boolean[] {false};
  acceuilButtons[0] = new Button (width / 2, height / 2, 200, 50, "Commencer");
  acceuilButtons[0].setColor(116, 255, 247);
  acceuilButtons[0].setTextColor(0);
  acceuilButtons[0].setFontSize(20);
  jeuButtons[0] = new Button (width / 2, 40, 200, 50, "Placer une Pièce");
  jeuButtons[0].setColor(255, 209, 54);
  jeuButtons[0].setTextColor(0);
  jeuButtons[0].setFontSize(20);
  
  backgroundTop = color(116, 255, 247);
  backgroundBot = color(255, 209, 54);
}


void initGame () {
  b = new Board();

  pieces = new Board[NB_PIECE];

  for (int i = 0; i < NB_PIECE; i++) {
    pieces[i] = new Board(true);
  }

  p = new Piece[NB_PIECE];
  generePiece(p);
  for (int i = 0; i < NB_PIECE; i++) {
    pieces[i].placePieceP(p[i].type, false);
  }
}

void draw() {
  setGradient(0, 0, width, height, backgroundTop, backgroundBot, 1);
  
  if (currentMenu == Menu.ACCEUIL) {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(50);
    text("Blockudoku\n(easy mode)", width/2, 200);
    for (int i = 0; i < acceuilButtons.length; i++) {
      acceuilButtons[i].display();
    }
  } else if (currentMenu == Menu.JEU) {
    b.display();

    for (int i = 0; i < NB_PIECE; i++) {
      pieces[i].display(i);
    }

    for (int i = 0; i < jeuButtons.length; i++) {
      jeuButtons[i].display();
    }
  }
}

void mousePressed() {
  if (currentMenu == Menu.ACCEUIL) {
    for (int i = 0; i < acceuilButtons.length; i++) {
      if (acceuilButtons[i].isActivated()) {
        acceuilButtonsActivated[i] = true;
      }
    }
  } else if (currentMenu == Menu.JEU) {
    for (int i = 0; i < jeuButtons.length; i++) {
      if (jeuButtons[i].isActivated()) {
        jeuButtonsActivated[i] = true;
      }
    }
  }
}

void mouseReleased() {
  if (acceuilButtonsActivated[0]) {
    currentMenu = Menu.JEU;
    acceuilButtonsActivated[0] = false;
    initGame();
    
    
  } else if (jeuButtonsActivated[0]) {

    int piecePlaced = b.placePiece(p, false);
    
    if (piecePlaced == -1) {
      currentMenu = Menu.ACCEUIL;
    } else {
      pieces[piecePlaced].resetBoard();
      p[piecePlaced] = null;
    }

    
    if (firstAvaiable(p) == -1) {
      generePiece(p);
      for (int i = 0; i < NB_PIECE; i++) {
        pieces[i].placePieceP(p[i].type, false);
      }
    }
    jeuButtonsActivated[0] = false;
  }
}

void generePiece(Piece[] p) {
  for (int i = 0; i < NB_PIECE; i++) {
    p[i] = new Piece(i);
  }
}

int firstAvaiable(Piece[] p) {
  for (int i = 0; i < p.length; i++) {
    if (p[i] != null) {
      return i;
    }
  }
  return -1;
}

enumPiece getRandomPiece () {
  int rand = (int)random(100);
  if (rand < 4) {
    rand = (int)random(2);
    return rand == 1 ? enumPiece.DIAGONALE3 : enumPiece.DIAGONALE3R;
  } else if (rand < 11) {
    rand = (int)random(2);
    return rand == 1 ? enumPiece.LIGNE4H : enumPiece.LIGNE4V;
  } else if (rand < 18) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.LITTLE_L;
    } else if (rand == 1) {
      return enumPiece.LITTLE_L90;
    } else if (rand == 2) {
      return enumPiece.LITTLE_L180;
    } else {
      return enumPiece.LITTLE_L270;
    }
  } else if (rand < 20) {
    rand = (int)random(2);
    return rand == 1 ? enumPiece.DIAGONALE2 : enumPiece.DIAGONALE2R;
  } else if (rand < 26) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.LITTLE_T;
    } else if (rand == 1) {
      return enumPiece.LITTLE_T90;
    } else if (rand == 2) {
      return enumPiece.LITTLE_T180;
    } else {
      return enumPiece.LITTLE_T270;
    }
  } else if (rand < 32) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.Z;
    } else if (rand == 1) {
      return enumPiece.ZR;
    } else if (rand == 2) {
      return enumPiece.Z90;
    } else {
      return enumPiece.ZR90;
    }
  } else if (rand < 38) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.BIG_T;
    } else if (rand == 1) {
      return enumPiece.BIG_T90;
    } else if (rand == 2) {
      return enumPiece.BIG_T180;
    } else {
      return enumPiece.BIG_T270;
    }
  } else if (rand < 56) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.BIG_L;
    } else if (rand == 1) {
      return enumPiece.BIG_L90;
    } else if (rand == 2) {
      return enumPiece.BIG_L180;
    } else {
      return enumPiece.BIG_L270;
    }
  } else if (rand < 62) {
    return enumPiece.CARRE;
  } else if (rand < 70) {
    rand = (int)random(2);
    return rand == 1 ? enumPiece.LIGNE5V : enumPiece.LIGNE5H;
  } else if (rand < 71) {
    return enumPiece.SINGLE;
  } else if (rand < 79) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.C;
    } else if (rand == 1) {
      return enumPiece.C90;
    } else if (rand == 2) {
      return enumPiece.C180;
    } else {
      return enumPiece.C270;
    }
  } else if (rand < 85) {
    rand = (int)random(4);
    if (rand == 0) {
      return enumPiece.MIDDLE_L;
    } else if (rand == 1) {
      return enumPiece.MIDDLE_L90;
    } else if (rand == 2) {
      return enumPiece.MIDDLE_L180;
    } else {
      return enumPiece.MIDDLE_L270;
    }
  } else if (rand < 86) {
    return enumPiece.CROIX;
  } else if (rand < 90) {
    rand = (int)random(2);
    return rand == 1 ? enumPiece.LIGNE2V : enumPiece.LIGNE2H;
  } else {
    rand = (int)random(2);
    return rand == 1 ? enumPiece.LIGNE3V : enumPiece.LIGNE3H;
  }
}



void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == 2) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
