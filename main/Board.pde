final int SIDE = 9;
final int PIECE_SIDE = 5;

class Board {
  public boolean [][] board;
  private boolean [][] lineCleanedBoard;
  private boolean [][] colonneCleanedBoard;
  private boolean [][] squareCleanedBoard;

  private boolean isBoard;

  private int displayX;
  private int displayY;
  private int cellWidth;
  private int cellHeight;

  private int side;


  Board() {
    this.board = new boolean [SIDE][SIDE];
    this.resetBoard();
    this.lineCleanedBoard = this.board;
    this.colonneCleanedBoard = this.board;
    this.squareCleanedBoard = this.board;

    this.isBoard = true;

    this.displayX = 150;
    this.displayY = 100;
    this. cellWidth = (height - 296) / 9;
    this. cellHeight = (height - 296) / 9;
    this.side = SIDE;
  }

  Board(boolean piece) {
    this.board = new boolean [PIECE_SIDE][PIECE_SIDE];
    this.resetBoard();
    this.lineCleanedBoard = this.board;
    this.colonneCleanedBoard = this.board;
    this.squareCleanedBoard = this.board;

    this.isBoard = false;

    this.displayX = 0;
    this.displayY = 0;
    this. cellWidth = 25;
    this. cellHeight = 25;
    this.side = PIECE_SIDE;
  }


  public void resetBoard() {
    for (int i = 0; i < this.side; i++) { //Colone
      for (int j = 0; j < this.side; j++) { //Ligne
        this.board[i][j] = false;
      }
    }
  }

  public boolean checkLigne (int i) { // True if the line is full
    boolean ligneOk = true;
    for (int j = 0; j < this.side; j++) {
      ligneOk = ligneOk && this.board[i][j];
    }
    return ligneOk;
  }

  public void cleanLigne (int i) {
    for (int j = 0; j < this.side; j++) {
      this.lineCleanedBoard[i][j] = false;
    }
  }

  public boolean checkColonne (int j) { // True if the line is full
    boolean colonneOk = true;
    for (int i = 0; i < this.side; i++) {
      colonneOk = colonneOk && this.board[i][j];
    }
    return colonneOk;
  }

  public void cleanColone (int j) {
    for (int i = 0; i < this.side; i++) {
      this.colonneCleanedBoard[i][j] = false;
    }
  }

  public void setCell (int i, int j) {
    this.board[i][j] = true;
  }

  public boolean checkSquare (int s) {
    boolean squareOk = true;
    for (int i = s - (s % 3); i < s - (s % 3) + 3; i++) {
      for (int j = (s % 3) * 3; j < ((s % 3) * 3) + 3; j++) {
        squareOk &= this.board[i][j];
      }
    }
    return squareOk;
  }

  public void cleanSquare (int s) {
    for (int i = s - (s % 3); i < s - (s % 3) + 3; i++) {
      for (int j = (s % 3) * 3; j < ((s % 3) * 3) + 3; j++) {
        this.squareCleanedBoard[i][j] = false;
      }
    }
  }

  public void cleanBoard () {
    
        arrayCopy(this.board, this.lineCleanedBoard);
        arrayCopy(this.board, this.colonneCleanedBoard);
        arrayCopy(this.board, this.squareCleanedBoard);
    
    for (int i = 0; i < this.side; i++) {
      if (checkLigne(i)) {
        this.cleanLigne(i);
      }
    }
    for (int i = 0; i < this.side; i++) {
      if (checkColonne(i)) {
        this.cleanColone(i);
      }
    }
    for (int i = 0; i < this.side; i++) {
      if (checkSquare(i)) {
        this.cleanSquare(i);
      }
    }
    
    step();
  }

  public void step () {
    for (int i = 0; i < this.side; i++) {
      for (int j = 0; j < this.side; j++) {
        this.board[i][j] = this.lineCleanedBoard[i][j] && this.colonneCleanedBoard[i][j] && this.squareCleanedBoard[i][j];
      }
    }
  }


  public void printBoard () {
    for (int i = 0; i < this.side; i++) {
      for (int j = 0; j < this.side; j++) {
        print("| " + this.board[i][j] + " |");
      }
      println();
    }
  }

  public int getCell (int i, int j) {
    return (j - j%3) + (i - i%3) * 3;
  }

  public boolean placementSinglePossible (int i, int j) {
    return !this.board[i][j];
  }

  public void placeSingle (int i, int j) {
    this.board[i][j] = true;
  }

  public boolean placeBestSingle () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementSinglePossible(i, j)) {
          scoreAct = scoreSingle(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeSingle(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreSingle (int i, int j) {
    int score = 0;
    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 1) { //pas coller en bas ni en haut
        score += this.board[i+1][j] ? 1 : 0;
        score += this.board[i-1][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += this.board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += this.board[i+1][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 1) { //Coller en bas
        score += this.board[i][j+1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      } else {  //pas coller en bas ni en haut
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += this.board[i][j+1] ? 1 : 0;
    }
    return score;
  }

  public boolean placeBestDiago2 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementDiago2Possible(i, j)) {
          scoreAct = scoreDiago2(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeDiago2(iMax, jMax);
    }

    return iMax != -1;
  }

  public boolean placementDiago2Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j+1];
    }
    return false;
  }

  public int scoreDiago2 (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 2 : 0;
    score += board[i+1][j] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+2][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public void placeDiago2 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j+1] = true;
  }

  public boolean placeBestDiago2R () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementDiago2RPossible(i, j)) {
          scoreAct = scoreDiago2R(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeDiago2R(iMax, jMax);
    }

    return iMax != -1;
  }

  public boolean placementDiago2RPossible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j+1] && !this.board[i+1][j];
    }
    return false;
  }

  public void placeDiago2R (int i, int j) {
    this.board[i][j+1] = true;
    this.board[i+1][j] = true;
  }

  public int scoreDiago2R (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i+1][j+1] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+2][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i][j+2] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementDiago3RPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j+2] && !this.board[i+1][j+1] && !this.board[i+2][j];
    }
    return false;
  }

  public void placeDiago3R (int i, int j) {
    this.board[i][j+2] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j] = true;
  }

  public boolean placeBestDiago3R () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementDiago3RPossible(i, j)) {
          scoreAct = scoreDiago3R(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeDiago3R(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreDiago3R (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 2 : 0;
    score += board[i+1][j] ? 2 : 0;
    score += board[i+2][j+1] ? 2 : 0;
    score += board[i+1][j+2] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i+3][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementDiago3Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j+1] && !this.board[i+2][j+2];
    }
    return false;
  }

  public void placeDiago3 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+2] = true;
  }

  public boolean placeBestDiago3 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementDiago3Possible(i, j)) {
          scoreAct = scoreDiago3(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeDiago3(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreDiago3 (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 2 : 0;
    score += board[i+1][j] ? 2 : 0;
    score += board[i+2][j+1] ? 2 : 0;
    score += board[i+1][j+2] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+3][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+2][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i+2][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne2VPossible (int i, int j) {
    if (i < this.side - 1 && j < this.side) {
      return !this.board[i][j] && !this.board[i+1][j];
    }
    return false;
  }

  public void placeLigne2V (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
  }

  public boolean placeBestLigne2V () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne2VPossible(i, j)) {
          scoreAct = scoreLigne2V(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne2V(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne2V (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+2][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 1) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i][j+1] ? 1 : 0;
        score += this.board[i+1][j+1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+1] ? 1 : 0;
      score += this.board[i+1][j+1] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne2HPossible (int i, int j) {
    if (i < this.side && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i][j+1];
    }
    return false;
  }

  public void placeLigne2H (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
  }

  public boolean placeBestLigne2H () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne2HPossible(i, j)) {
          scoreAct = scoreLigne2H(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne2H(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne2H (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 1) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+1][j] ? 1 : 0;
        score += board[i+1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+1][j] ? 1 : 0;
      score += board[i+1][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i][j+2] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne3VPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j];
    }
    return false;
  }

  public void placeLigne3V (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
  }

  public boolean placeBestLigne3V () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne3VPossible(i, j)) {
          scoreAct = scoreLigne3V(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne3V(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne3V (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+3][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 1) { //Pas coller a droite ni a gauche
        score += this.board[i][j+1] ? 1 : 0;
        score += this.board[i+1][j+1] ? 1 : 0;
        score += this.board[i+2][j+1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i][j+1] ? 1 : 0;
      score += this.board[i+1][j+1] ? 1 : 0;
      score += this.board[i+2][j+1] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne3HPossible (int i, int j) {
    if (i < this.side && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeLigne3H (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
  }

  public boolean placeBestLigne3H () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne3HPossible(i, j)) {
          scoreAct = scoreLigne3H(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne3H(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne3H (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 1) { //pas coller en bas ni en haut
        score += board[i+1][j] ? 1 : 0;
        score += board[i+1][j+1] ? 1 : 0;
        score += board[i+1][j+2] ? 1 : 0;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+1][j] ? 1 : 0;
      score += board[i+1][j+1] ? 1 : 0;
      score += board[i+1][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne4VPossible (int i, int j) {
    if (i < this.side - 3 && j < this.side) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+3][j];
    }
    return false;
  }

  public void placeLigne4V (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+3][j] = true;
  }

  public boolean placeBestLigne4V () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne4VPossible(i, j)) {
          scoreAct = scoreLigne4V(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne4V(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne4V (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 4) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+4][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+4][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 1) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i+3][j-1] ? 1 : 0;
        score += this.board[i][j+1] ? 1 : 0;
        score += this.board[i+1][j+1] ? 1 : 0;
        score += this.board[i+2][j+1] ? 1 : 0;
        score += this.board[i+3][j+1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i+3][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score++;
      score += this.board[i][j+1] ? 1 : 0;
      score += this.board[i+1][j+1] ? 1 : 0;
      score += this.board[i+2][j+1] ? 1 : 0;
      score += this.board[i+3][j+1] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne4HPossible (int i, int j) {
    if (i < this.side && j < this.side - 3) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i][j+2] && !this.board[i][j+3];
    }
    return false;
  }

  public void placeLigne4H (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
    this.board[i][j+3] = true;
  }

  public boolean placeBestLigne4H () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne4HPossible(i, j)) {
          scoreAct = scoreLigne4H(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne4H(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne4H (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 1) { //pas coller en bas ni en haut
        score += board[i+1][j] ? 1 : 0;
        score += board[i+1][j+1] ? 1 : 0;
        score += board[i+1][j+2] ? 1 : 0;
        score += board[i+1][j+3] ? 1 : 0;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i-1][j+3] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i-1][j+3] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score++;
      score += board[i+1][j] ? 1 : 0;
      score += board[i+1][j+1] ? 1 : 0;
      score += board[i+1][j+2] ? 1 : 0;
      score += board[i+1][j+3] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 4) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i][j+4] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+4] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne5VPossible (int i, int j) {
    if (i < this.side - 4 && j < this.side) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+3][j] && !this.board[i+4][j];
    }
    return false;
  }

  public void placeLigne5V (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+3][j] = true;
    this.board[i+4][j] = true;
  }

  public boolean placeBestLigne5V () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne5VPossible(i, j)) {
          scoreAct = scoreLigne5V(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne5V(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLigne5V (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 5) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+5][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+5][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 1) { //Pas coller a droite ni a gauche
        score += this.board[i][j+1] ? 1 : 0;
        score += this.board[i+1][j+1] ? 1 : 0;
        score += this.board[i+2][j+1] ? 1 : 0;
        score += this.board[i+3][j+1] ? 1 : 0;
        score += this.board[i+4][j+1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i+3][j-1] ? 1 : 0;
        score += this.board[i+4][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i+3][j-1] ? 1 : 0;
        score += this.board[i+4][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score++;
      score++;
      score += this.board[i][j+1] ? 1 : 0;
      score += this.board[i+1][j+1] ? 1 : 0;
      score += this.board[i+2][j+1] ? 1 : 0;
      score += this.board[i+3][j+1] ? 1 : 0;
      score += this.board[i+4][j+1] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLigne5HPossible (int i, int j) {
    if (i < this.side && j < this.side - 4) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i][j+2] && !this.board[i][j+3] && !this.board[i][j+4];
    }
    return false;
  }

  public void placeLigne5H (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
    this.board[i][j+3] = true;
    this.board[i][j+4] = true;
  }

  public boolean placeBestLigne5H () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLigne5HPossible(i, j)) {
          scoreAct = scoreLigne5H(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLigne5H(iMax, jMax);
    }
    return iMax != -1;
  }

  public int scoreLigne5H (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 1) { //pas coller en bas ni en haut
        score += board[i+1][j] ? 1 : 0;
        score += board[i+1][j+1] ? 1 : 0;
        score += board[i+1][j+2] ? 1 : 0;
        score += board[i+1][j+3] ? 1 : 0;
        score += board[i+1][j+4] ? 1 : 0;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i-1][j+3] ? 1 : 0;
        score += board[i-1][j+4] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i-1][j+3] ? 1 : 0;
        score += board[i-1][j+4] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score++;
      score++;
      score += board[i+1][j] ? 1 : 0;
      score += board[i+1][j+1] ? 1 : 0;
      score += board[i+1][j+2] ? 1 : 0;
      score += board[i+1][j+3] ? 1 : 0;
      score += board[i+1][j+4] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 5) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i][j+5] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+5] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleLPossible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i][j+1];
    }
    return false;
  }

  public void placeLittleL (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i][j+1] = true;
  }

  public boolean placeBestLittleL () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleLPossible(i, j)) {
          scoreAct = scoreLittleL(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleL(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleL (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+2][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+2][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleL90Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j+1] && !this.board[i][j+1];
    }
    return false;
  }

  public void placeLittleL90 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i][j+1] = true;
  }

  public boolean placeBestLittleL90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleL90Possible(i, j)) {
          scoreAct = scoreLittleL90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleL90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleL90 (int i, int j) {
    int score = 0;

    score += board[i+1][j] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+2][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleL180Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i][j+1];
    }
    return false;
  }

  public void placeLittleL180 (int i, int j) {
    this.board[i+1][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
  }

  public boolean placeBestLittleL180 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleL180Possible(i, j)) {
          scoreAct = scoreLittleL180(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleL180(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleL180 (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i+1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+2][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleL270Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+1][j+1];
    }
    return false;
  }

  public void placeLittleL270 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
  }

  public boolean placeBestLittleL270 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleL270Possible(i, j)) {
          scoreAct = scoreLittleL270(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleL270(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleL270 (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+2][j] ? 1 : 0;
        score += board[i+2][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementMiddleLPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+2][j+1];
    }
    return false;
  }

  public void placeMiddleL (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+2][j+1] = true;
  }

  public boolean placeBestMiddleL () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementMiddleLPossible(i, j)) {
          scoreAct = scoreMiddleL(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeMiddleL(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreMiddleL (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 1 : 0;
    score += board[i+1][j+1] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+3][j] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
      score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i+2][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementMiddleL90Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i][j+1] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeMiddleL90 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
  }

  public boolean placeBestMiddleL90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementMiddleL90Possible(i, j)) {
          scoreAct = scoreMiddleL90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeMiddleL90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreMiddleL90 (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 2 : 0;
    score += board[i+1][j+2] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i+2][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+2][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementMiddleL180Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+2][j+1];
    }
    return false;
  }

  public void placeMiddleL180 (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+1] = true;
  }

  public boolean placeBestMiddleL270 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementMiddleL270Possible(i, j)) {
          scoreAct = scoreMiddleL270(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeMiddleL270(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreMiddleL270 (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i][j+1] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i+2][j] ? 1 : 0;
        score += board[i+2][j+1] ? 1 : 0;
        score += board[i+2][j+2] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementMiddleL270Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i+1][j+2] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeMiddleL270 (int i, int j) {
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j+2] = true;
    this.board[i][j+2] = true;
  }

  public boolean placeBestMiddleL180 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementMiddleL180Possible(i, j)) {
          scoreAct = scoreMiddleL180(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeMiddleL180(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreMiddleL180 (int i, int j) {
    int score = 0;

    score += board[i+1][j] ? 2 : 0;
    score += board[i+2][j] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+2][j+2] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+1][j+2] ? 1 : 0;
      score += this.board[i+2][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigLPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i][j+1] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeBigL (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
  }
  
  public boolean placeBestBigL () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigLPossible(i, j)) {
          scoreAct = scoreBigL(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigL(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigL (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 2 : 0;
    score += board[i+2][j+1] ? 1 : 0;
    score += board[i+1][j+2] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i+3][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigL90Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i][j+2] && !this.board[i+1][j+2] && !this.board[i+2][j+2];
    }
    return false;
  }

  public void placeBigL90 (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
    this.board[i+1][j+2] = true;
    this.board[i+2][j+2] = true;
  }
  
    public boolean placeBestBigL90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigL90Possible(i, j)) {
          scoreAct = scoreBigL90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigL90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigL90 (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 2 : 0;
    score += board[i+1][j] ? 1 : 0;
    score += board[i+2][j+1] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i+3][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+3][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
      score += this.board[i+2][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
      score += this.board[i+2][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigL180Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i+2][j] && !this.board[i+2][j+1] && !this.board[i+2][j+2] && !this.board[i+1][j+2] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeBigL180 (int i, int j) {
    this.board[i+2][j] = true;
    this.board[i+2][j+1] = true;
    this.board[i+2][j+2] = true;
    this.board[i+1][j+2] = true;
    this.board[i][j+2] = true;
  }
  
  public boolean placeBestBigL180 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigL180Possible(i, j)) {
          scoreAct = scoreBigL180(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigL180(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigL180 (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 2 : 0;
    score += board[i+1][j] ? 1 : 0;
    score += board[i][j+1] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
       score += board[i+3][j+1] ? 1 : 0;
      score += board[i+3][j+2] ? 1 : 0;
      score += board[i+3][j] ? 1 : 0;
      score += board[i-1][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+1] ? 1 : 0;
      score += board[i+3][j+2] ? 1 : 0;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
      score += this.board[i+2][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
      score += this.board[i+2][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigL270Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+2][j+1] && !this.board[i+2][j+2];
    }
    return false;
  }

  public void placeBigL270 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+2][j+1] = true;
    this.board[i+2][j+2] = true;
  }
  
    public boolean placeBestBigL270 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigL270Possible(i, j)) {
          scoreAct = scoreBigL270(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigL270(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigL270 (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 2 : 0;
    score += board[i][j+1] ? 1 : 0;
    score += board[i+1][j+2] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
       score += board[i+3][j+1] ? 1 : 0;
      score += board[i+3][j+2] ? 1 : 0;
      score += board[i+3][j] ? 1 : 0;
      score += board[i-1][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+1] ? 1 : 0;
      score += board[i+3][j+2] ? 1 : 0;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+2][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i+2][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleTPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+1][j+1];
    }
    return false;
  }

  public void placeLittleT (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+1][j+1] = true;
  }
  
  public boolean placeBestLittleT () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleTPossible(i, j)) {
          scoreAct = scoreLittleT(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleT(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleT (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 2 : 0;
    score += board[i+2][j+1] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
       score += board[i+3][j] ? 1 : 0;
       score += board[i-1][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleT90Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i][j+2] && !this.board[i+1][j+1];
    }
    return false;
  }

  public void placeLittleT90 (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
    this.board[i+1][j+1] = true;
  }
  
  public boolean placeBestLittleT90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleT90Possible(i, j)) {
          scoreAct = scoreLittleT90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleT90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleT90 (int i, int j) {
    int score = 0;

    score += board[i+1][j] ? 2 : 0;
    score += board[i+1][j+2] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
       score += board[i+2][j+1] ? 1 : 0;
       score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleT180Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i+1][j] && !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+2][j+1];
    }
    return false;
  }

  public void placeLittleT180 (int i, int j) {
    this.board[i+1][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+1] = true;
  }
  
  public boolean placeBestLittleT180 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleT180Possible(i, j)) {
          scoreAct = scoreLittleT180(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleT180(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleT180 (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i+2][j] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
       score += board[i+3][j+1] ? 1 : 0;
       score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+2][j+2] ? 1 : 0;
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
      score++;
      score++;
      score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+2][j+2] ? 1 : 0;
        score += this.board[i][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementLittleT270Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j+1] && !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i+1][j+2];
    }
    return false;
  }

  public void placeLittleT270 (int i, int j) {
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j] = true;
    this.board[i+1][j+2] = true;
  }
  
  public boolean placeBestLittleT270 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementLittleT270Possible(i, j)) {
          scoreAct = scoreLittleT270(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeLittleT270(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreLittleT270 (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i][j+2] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
      score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigTPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+2][j+1] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeBigT (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+1] = true;
    this.board[i][j+2] = true;
  }
  
  public boolean placeBestBigT () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigTPossible(i, j)) {
          scoreAct = scoreBigT(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigT(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigT (int i, int j) {
    int score = 0;

    score += board[i+1][j] ? 2 : 0;
    score += board[i+2][j] ? 1 : 0;
    score += board[i+1][j+2] ? 2 : 0;
    score += board[i+2][j+2] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
      score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      score += board[i+3][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigT90Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i+1][j+2] && !this.board[i][j+2] && !this.board[i+2][j+2];
    }
    return false;
  }

  public void placeBigT90 (int i, int j) {
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j+2] = true;
    this.board[i][j+2] = true;
    this.board[i+2][j+2] = true;
  }
  
  public boolean placeBestBigT90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigT90Possible(i, j)) {
          scoreAct = scoreBigT90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigT90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigT90 (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i][j+1] ? 1 : 0;
    score += board[i+2][j] ? 2 : 0;
    score += board[i+2][j+1] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i+3][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
      score += this.board[i+2][j+3] ? 1 : 0;
      score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i][j+3] ? 1 : 0;
      score += this.board[i+1][j+3] ? 1 : 0;
      score += this.board[i+2][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigT180Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+2][j+1] && !this.board[i+2][j+2] && !this.board[i+2][j];
    }
    return false;
  }

  public void placeBigT180 (int i, int j) {
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+1] = true;
    this.board[i+2][j+2] = true;
    this.board[i+2][j] = true;
  }
  
  public boolean placeBestBigT180 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigT180Possible(i, j)) {
          scoreAct = scoreBigT180(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigT180(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigT180 (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i+1][j] ? 1 : 0;
    score += board[i][j+2] ? 2 : 0;
    score += board[i+1][j+2] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i+3][j] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
        score += board[i+3][j+2] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
      score += board[i+3][j+1] ? 1 : 0;
      score += board[i+3][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+2][j+3] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i+2][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementBigT270Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+1][j+1] && !this.board[i+1][j+2];
    }
    return false;
  }

  public void placeBigT270 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j+2] = true;
  }
  
  public boolean placeBestBigT270 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementBigT270Possible(i, j)) {
          scoreAct = scoreBigT270(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeBigT270(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreBigT270 (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 2 : 0;
    score += board[i][j+2] ? 1 : 0;
    score += board[i+2][j+1] ? 2 : 0;
    score += board[i+2][j+2] ? 1 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i+3][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementCroixPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 2) {
      return !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i+1][j+2] && !this.board[i][j+1] && !this.board[i+2][j+1];
    }
    return false;
  }

  public void placeCroix (int i, int j) {
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j+2] = true;
    this.board[i][j+1] = true;
    this.board[i+2][j+1] = true;
  }
  
  public boolean placeBestCroix () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementCroixPossible(i, j)) {
          scoreAct = scoreCroix(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeCroix(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreCroix (int i, int j) {
    int score = 0;

    score += board[i][j] ? 2 : 0;
    score += board[i][j+2] ? 2 : 0;
    score += board[i+2][j] ? 2 : 0;
    score += board[i+2][j+2] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementCPossible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i+1][j] && !this.board[i+2][j] && !this.board[i+2][j+1];
    }
    return false;
  }

  public void placeC (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
    this.board[i+2][j+1] = true;
  }
  
  public boolean placeBestC () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementCPossible(i, j)) {
          scoreAct = scoreC(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeC(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreC (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 3 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i+3][j] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
        score++;
        score += board[i+3][j] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
        score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+2][j+2] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score++;
      score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+2][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementC90Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i][j+1] && !this.board[i][j+2] && !this.board[i+1][j+2];
    }
    return false;
  }

  public void placeC90 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i][j+1] = true;
    this.board[i][j+2] = true;
    this.board[i+1][j+2] = true;
  }
  
  public boolean placeBestC90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementC90Possible(i, j)) {
          scoreAct = scoreC90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeC90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreC90 (int i, int j) {
    int score = 0;

    score += board[i+1][j+1] ? 3 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
        score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementC180Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+2][j+1] && !this.board[i+2][j];
    }
    return false;
  }

  public void placeC180 (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+1] = true;
    this.board[i+2][j] = true;
  }
  
  public boolean placeBestC180 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementC180Possible(i, j)) {
          scoreAct = scoreC180(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeC180(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreC180 (int i, int j) {
    int score = 0;

    score += board[i+1][j] ? 3 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i+3][j] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
        score++;
        score += board[i+3][j] ? 1 : 0;
        score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+1][j+2] ? 1 : 0;
      score += this.board[i+2][j+2] ? 1 : 0;
      score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+2] ? 1 : 0;
      score += this.board[i+1][j+2] ? 1 : 0;
      score += this.board[i+2][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementC270Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i+1][j+2] && !this.board[i][j+2];
    }
    return false;
  }

  public void placeC270 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j+2] = true;
    this.board[i][j+2] = true;
  }
  
  public boolean placeBestC270 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementC270Possible(i, j)) {
          scoreAct = scoreC270(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeC270(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreC270 (int i, int j) {
    int score = 0;

    score += board[i][j+1] ? 3 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
      score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementCarrePossible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i+1][j] && !this.board[i+1][j+1];
    }
    return false;
  }

  public void placeCarre (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
  }
  
  public boolean placeBestCarre () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementCarrePossible(i, j)) {
          scoreAct = scoreCarre(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeCarre(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreCarre (int i, int j) {
    int score = 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
      score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementZPossible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j] && !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+1][j+2];
    }
    return false;
  }

  public void placeZ (int i, int j) {
    this.board[i][j] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j+2] = true;
  }
  
  public boolean placeBestZ () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementZPossible(i, j)) {
          scoreAct = scoreZ(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeZ(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreZ (int i, int j) {
    int score = 0;
    
    score += board[i][j+2] ? 2 : 0;
    score += board[i+1][j] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
      score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i+2][j+2] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j+3] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
        score += this.board[i+1][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementZ90Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+1][j] && !this.board[i+2][j];
    }
    return false;
  }

  public void placeZ90 (int i, int j) {
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j] = true;
    this.board[i+2][j] = true;
  }
  
  public boolean placeBestZ90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementZ90Possible(i, j)) {
          scoreAct = scoreZ90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeZ90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreZ90 (int i, int j) {
    int score = 0;
    
    score += board[i][j] ? 2 : 0;
    score += board[i+2][j+1] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i+3][j] ? 1 : 0;
        score += board[i-1][j+1] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j+1] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
        score += this.board[i+2][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
        score += this.board[i][j+2] ? 1 : 0;
        score += this.board[i+1][j+2] ? 1 : 0;
    }
    return score;
  }

  public boolean placementZRPossible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 2) {
      return !this.board[i][j+2] && !this.board[i][j+1] && !this.board[i+1][j+1] && !this.board[i+1][j];
    }
    return false;
  }

  public void placeZR (int i, int j) {
    this.board[i][j+2] = true;
    this.board[i][j+1] = true;
    this.board[i+1][j+1] = true;
    this.board[i+1][j] = true;
  }
  
  public boolean placeBestZR () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementZRPossible(i, j)) {
          scoreAct = scoreZR(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeZR(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreZR (int i, int j) {
    int score = 0;
    
    score += board[i][j] ? 2 : 0;
    score += board[i+1][j+2] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 2) { //pas coller en bas ni en haut
        score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
      score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score++;
        score += board[i-1][j+1] ? 1 : 0;
        score += board[i-1][j+2] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score++;
      score += board[i+2][j] ? 1 : 0;
      score += board[i+2][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 3) { //Pas coller a droite ni a gauche
        score += this.board[i][j+3] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
        score += this.board[i][j+3] ? 1 : 0;
    }
    return score;
  }

  public boolean placementZR90Possible (int i, int j) {
    if (i < this.side - 2 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j] && !this.board[i+1][j+1] && !this.board[i+2][j+1];
    }
    return false;
  }

  public void placeZR90 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j] = true;
    this.board[i+1][j+1] = true;
    this.board[i+2][j+1] = true;
  }
  
  public boolean placeBestZR90 () {
    int scoreMax = 0;
    int scoreAct = 0;
    int iMax = -1;
    int jMax = -1;
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j< SIDE; j++) {
        if (placementZR90Possible(i, j)) {
          scoreAct = scoreZR90(i, j);
          if (scoreAct > scoreMax) {
            scoreMax = scoreAct;
            iMax = i;
            jMax = j;
          }
        }
      }
    }
    if (iMax != -1) {
      placeZR90(iMax, jMax);
    }

    return iMax != -1;
  }

  public int scoreZR90 (int i, int j) {
    int score = 0;
    
    score += board[i][j+1] ? 2 : 0;
    score += board[i+2][j] ? 2 : 0;

    if (i > 0) { //Pas coller en haut
      if (i < SIDE - 3) { //pas coller en bas ni en haut
        score += board[i+3][j+1] ? 1 : 0;
        score += board[i-1][j] ? 1 : 0;
      } else {  //Coller en bas
        score++;
        score += board[i-1][j] ? 1 : 0;
      }
    } else { //Coller en haut
      score++;
      score += board[i+3][j+1] ? 1 : 0;
    }

    if (j > 0) { //Pas coller a gauche
      if (j < SIDE - 2) { //Pas coller a droite ni a gauche
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+2][j+2] ? 1 : 0;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      } else {  //coller a droite
        score++;
        score++;
        score += this.board[i][j-1] ? 1 : 0;
        score += this.board[i+1][j-1] ? 1 : 0;
      }
    } else { //Coller a gauche
      score++;
      score++;
        score += this.board[i+1][j+2] ? 1 : 0;
        score += this.board[i+2][j+2] ? 1 : 0;
    }
    return score;
  }



  public int scoreFromPlacement (int i, int j, enumPiece p) {
    return 1;
  }

  public boolean placementPossible (int i, int j, enumPiece p) {
    switch (p) {
    case SINGLE:
      return placementSinglePossible(i, j);
    case DIAGONALE2:
      return placementDiago2Possible(i, j);
    case DIAGONALE2R:
      return placementDiago2RPossible(i, j);
    case DIAGONALE3:
      return placementDiago3Possible(i, j);
    case DIAGONALE3R:
      return placementDiago3RPossible(i, j);
    case LIGNE2V:
      return placementLigne2VPossible(i, j);
    case LIGNE3V:
      return placementLigne3VPossible(i, j);
    case LIGNE4V:
      return placementLigne4VPossible(i, j);
    case LIGNE5V:
      return placementLigne5VPossible(i, j);
    case LIGNE2H:
      return placementLigne2HPossible(i, j);
    case LIGNE3H:
      return placementLigne3HPossible(i, j);
    case LIGNE4H:
      return placementLigne4HPossible(i, j);
    case LIGNE5H:
      return placementLigne5HPossible(i, j);
    case LITTLE_L:
      return placementLittleTPossible(i, j);
    case LITTLE_L90:
      return placementLittleT90Possible(i, j);
    case LITTLE_L180:
      return placementLittleT180Possible(i, j);
    case LITTLE_L270:
      return placementLittleT270Possible(i, j);
    case MIDDLE_L:
      return placementMiddleLPossible(i, j);
    case MIDDLE_L90:
      return placementMiddleL90Possible(i, j);
    case MIDDLE_L180:
      return placementMiddleL180Possible(i, j);
    case MIDDLE_L270:
      return placementMiddleL270Possible(i, j);
    case BIG_L:
      return placementBigLPossible(i, j);
    case BIG_L90:
      return placementBigL90Possible(i, j);
    case BIG_L180:
      return placementBigL180Possible(i, j);
    case BIG_L270:
      return placementBigL270Possible(i, j);
    case LITTLE_T:
      return placementLittleTPossible(i, j);
    case LITTLE_T90:
      return placementLittleT90Possible(i, j);
    case LITTLE_T180:
      return placementLittleT180Possible(i, j);
    case LITTLE_T270:
      return placementLittleT270Possible(i, j);
    case BIG_T:
      return placementBigTPossible(i, j);
    case BIG_T90:
      return placementBigT90Possible(i, j);
    case BIG_T180:
      return placementBigT180Possible(i, j);
    case BIG_T270:
      return placementBigT270Possible(i, j);
    case CROIX:
      return placementCroixPossible(i, j);
    case C:
      return placementCPossible(i, j);
    case C90:
      return placementC90Possible(i, j);
    case C180:
      return placementC180Possible(i, j);
    case C270:
      return placementC270Possible(i, j);
    case CARRE:
      return placementCarrePossible(i, j);
    case Z:
      return placementZPossible(i, j);
    case Z90:
      return placementZ90Possible(i, j);
    case ZR:
      return placementZRPossible(i, j);
    case ZR90:
      return placementZR90Possible(i, j);
    default:
      return false;
    }
  }
  
  
  public boolean placePiece (enumPiece p) {
    boolean res = placePieceWorker(p);
    cleanBoard();
    return res;
  }

  public boolean placePieceWorker (enumPiece p) {
    boolean placed = false;
    switch(p) {
    case SINGLE:
      return placeBestSingle();
    case DIAGONALE2:
      return placeBestDiago2();
    case DIAGONALE2R:
      return placeBestDiago2R();
    case DIAGONALE3:
      return placeBestDiago3();
    case DIAGONALE3R:
      return placeBestDiago3R();
    case LIGNE2V:
      return placeBestLigne2V();
    case LIGNE2H:
      return placeBestLigne2H();
    case LIGNE3V:
      return placeBestLigne3V();
    case LIGNE3H:
      return placeBestLigne3H();
    case LIGNE4V:
      return placeBestLigne4V();
    case LIGNE4H:
      return placeBestLigne4H();
    case LIGNE5V:
      return placeBestLigne5V();
    case LIGNE5H:
      return placeBestLigne5H();
    case LITTLE_L:
      return placeBestLittleL();
    case LITTLE_L90:
      return placeBestLittleL90();
    case LITTLE_L180:
      return placeBestLittleL180();
    case LITTLE_L270:
      return placeBestLittleL270();
    case MIDDLE_L:
      return placeBestMiddleL();
    case MIDDLE_L90:
      return placeBestMiddleL90();
    case MIDDLE_L180:
      return placeBestMiddleL180();
    case MIDDLE_L270:
      return placeBestMiddleL270();
    case BIG_L:
      return placeBestBigL();
    case BIG_L90:
      return placeBestBigL90();
    case BIG_L180:
      return placeBestBigL180();
    case BIG_L270:
      return placeBestBigL270();
    case LITTLE_T:
      return placeBestLittleT();
    case LITTLE_T90:
      return placeBestLittleT90();
    case LITTLE_T180:
      return placeBestLittleT180();
    case LITTLE_T270:
      return placeBestLittleT270();
    case BIG_T:
      return placeBestBigT();
    case BIG_T90:
      return placeBestBigT90();
    case BIG_T180:
      return placeBestBigT180();
    case BIG_T270:
      return placeBestBigT270();
    case CROIX:
      return placeBestCroix();
    case C:
      return placeBestC();
    case C90:
      return placeBestC90();
    case C180:
      return placeBestC180();
    case C270:
      return placeBestC270();
    case CARRE:
      return placeBestCarre();
    case Z:
      return placeBestZ();
    case Z90:
      return placeBestZ90();
    case ZR:
      return placeBestZR();
    case ZR90:
      return placeBestZR90();
    default:
      return placed;
    }
  }

  public boolean placePieceP (enumPiece p) {
    boolean placed = false;
    switch(p) {
    case SINGLE:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementSinglePossible(i, j)) {
            placeSingle(i, j);
            placed = true;
          }
        }
      }
      break;
    case DIAGONALE2:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementDiago2Possible(i, j)) {
            placeDiago2(i, j);
            placed = true;
          }
        }
      }
      break;
    case DIAGONALE2R:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementDiago2RPossible(i, j)) {
            placeDiago2R(i, j);
            placed = true;
          }
        }
      }
      break;
    case DIAGONALE3:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementDiago3Possible(i, j)) {
            placeDiago3(i, j);
            placed = true;
          }
        }
      }
      break;
    case DIAGONALE3R:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementDiago3RPossible(i, j)) {
            placeDiago3R(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE2V:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne2VPossible(i, j)) {
            placeLigne2V(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE2H:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne2HPossible(i, j)) {
            placeLigne2H(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE3V:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne3VPossible(i, j)) {
            placeLigne3V(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE3H:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne3HPossible(i, j)) {
            placeLigne3H(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE4V:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne4VPossible(i, j)) {
            placeLigne4V(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE4H:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne4HPossible(i, j)) {
            placeLigne4H(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE5V:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne5VPossible(i, j)) {
            placeLigne5V(i, j);
            placed = true;
          }
        }
      }
      break;
    case LIGNE5H:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLigne5HPossible(i, j)) {
            placeLigne5H(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_L:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleLPossible(i, j)) {
            placeLittleL(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_L90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleL90Possible(i, j)) {
            placeLittleL90(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_L180:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleL180Possible(i, j)) {
            placeLittleL180(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_L270:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleL270Possible(i, j)) {
            placeLittleL270(i, j);
            placed = true;
          }
        }
      }
      break;
    case MIDDLE_L:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementMiddleLPossible(i, j)) {
            placeMiddleL(i, j);
            placed = true;
          }
        }
      }
      break;
    case MIDDLE_L90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementMiddleL90Possible(i, j)) {
            placeMiddleL90(i, j);
            placed = true;
          }
        }
      }
      break;
    case MIDDLE_L180:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementMiddleL180Possible(i, j)) {
            placeMiddleL180(i, j);
            placed = true;
          }
        }
      }
      break;
    case MIDDLE_L270:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementMiddleL270Possible(i, j)) {
            placeMiddleL270(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_L:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigLPossible(i, j)) {
            placeBigL(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_L90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigL90Possible(i, j)) {
            placeBigL90(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_L180:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigL180Possible(i, j)) {
            placeBigL180(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_L270:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigL270Possible(i, j)) {
            placeBigL270(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_T:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleTPossible(i, j)) {
            placeLittleT(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_T90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleT90Possible(i, j)) {
            placeLittleT90(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_T180:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleT180Possible(i, j)) {
            placeLittleT180(i, j);
            placed = true;
          }
        }
      }
      break;
    case LITTLE_T270:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementLittleT270Possible(i, j)) {
            placeLittleT270(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_T:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigTPossible(i, j)) {
            placeBigT(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_T90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigT90Possible(i, j)) {
            placeBigT90(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_T180:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigT180Possible(i, j)) {
            placeBigT180(i, j);
            placed = true;
          }
        }
      }
      break;
    case BIG_T270:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementBigT270Possible(i, j)) {
            placeBigT270(i, j);
            placed = true;
          }
        }
      }
      break;
    case CROIX:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementCroixPossible(i, j)) {
            placeCroix(i, j);
            placed = true;
          }
        }
      }
      break;
    case C:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementCPossible(i, j)) {
            placeC(i, j);
            placed = true;
          }
        }
      }
      break;
    case C90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementC90Possible(i, j)) {
            placeC90(i, j);
            placed = true;
          }
        }
      }
      break;
    case C180:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementC180Possible(i, j)) {
            placeC180(i, j);
            placed = true;
          }
        }
      }
      break;
    case C270:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementC270Possible(i, j)) {
            placeC270(i, j);
            placed = true;
          }
        }
      }
      break;
    case CARRE:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementCarrePossible(i, j)) {
            placeCarre(i, j);
            placed = true;
          }
        }
      }
      break;
    case Z:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementZPossible(i, j)) {
            placeZ(i, j);
            placed = true;
          }
        }
      }
      break;
    case Z90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementZ90Possible(i, j)) {
            placeZ90(i, j);
            placed = true;
          }
        }
      }
      break;
    case ZR:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementZRPossible(i, j)) {
            placeZR(i, j);
            placed = true;
          }
        }
      }
      break;
    case ZR90:
      for (int i = 0; i < this.side && !placed; i++) {
        for (int j = 0; j < this.side && !placed; j++) {
          if (placementZR90Possible(i, j)) {
            placeZR90(i, j);
            placed = true;
          }
        }
      }
      break;
    default:
      break;
    }

    if (this.side == SIDE) {
      cleanBoard();
    }

    return placed;
  }

  public void display() {
    for (int i = 0; i < this.side; i++) {
      for (int j = 0; j < this.side; j++) {
        if (this. board[i][j]) {
          fill(53, 108, 225);
        } else if (getCell (i, j) % 2 == 0) {
          fill (255);
        } else {
          fill (226, 233, 239);
        }
        stroke(202, 209, 215);
        strokeWeight(3);
        rect(displayX + cellWidth * j, displayY + cellHeight * i, cellWidth, cellHeight);
      }
    }
    stroke(87, 96, 113);
    noFill();
    rect (150, 100, height - 296, height - 296);


    rect (150, 100, height - 296, (height - 296) / 3);
    rect (150, 100 + (height - 296) / 3, height - 296, (height - 296) / 3);
    rect (150, 100, (height - 296) / 3, height - 296);
    rect (150 + (height - 296) / 3, 100, (height - 296) / 3, height - 296);
  }


  public void display(int index) {
    for (int i = 0; i < this.side; i++) {
      for (int j = 0; j < this.side; j++) {
        if (this.isBoard) {
          if (this. board[i][j]) {
            fill(53, 108, 225);
          } else if (getCell (i, j) % 2 == 0) {
            fill (255);
          } else {
            fill (226, 233, 239);
          }
          stroke(202, 209, 215);
          strokeWeight(3);
          rect(index*200 + 140 + cellWidth * j, 650 + cellHeight * i, cellWidth, cellHeight);
        } else {
          if (this. board[i][j]) {
            fill(53, 108, 225);
            stroke(202, 209, 215);
            strokeWeight(3);
            rect(index*200 + 160 + cellWidth * j, 650 + cellHeight * i, cellWidth, cellHeight);
          }
        }
      }
    }
  }
}
