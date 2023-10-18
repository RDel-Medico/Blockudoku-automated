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
      ligneOk &= this.board[i][j];
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
      colonneOk &= this.board[i][j];
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
    this.lineCleanedBoard = this.board;
    this.colonneCleanedBoard = this.board;
    this.squareCleanedBoard = this.board;
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

  public boolean placementDiago2Possible (int i, int j) {
    if (i < this.side - 1 && j < this.side - 1) {
      return !this.board[i][j] && !this.board[i+1][j+1];
    }
    return false;
  }

  public void placeDiago2 (int i, int j) {
    this.board[i][j] = true;
    this.board[i+1][j+1] = true;
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

  public boolean placePiece (enumPiece p) {
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
