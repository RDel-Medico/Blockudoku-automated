final int SIDE = 9;

class Board {
  public boolean [][] board;
  private boolean [][] lineCleanedBoard;
  private boolean [][] colonneCleanedBoard;
  private boolean [][] squareCleanedBoard;
  
  
  Board() {
    this.board = new boolean [9][9];
    this.resetBoard();
    this.lineCleanedBoard = this.board;
    this.colonneCleanedBoard = this.board;
    this.squareCleanedBoard = this.board;
  }
  
  
  public void resetBoard() {
    for (int i = 0; i < SIDE; i++) { //Colone
      for (int j = 0; j < SIDE; j++) { //Ligne
        this.board[i][j] = false;
      }
    }
  }
  
  public boolean checkLigne (int i) { // True if the line is full
    boolean ligneOk = true;
    for (int j = 0; j < SIDE; j++) {
      ligneOk &= this.board[i][j];
    }
    return ligneOk;
  }
  
  public void cleanLigne (int i) {
    for (int j = 0; j < SIDE; j++) {
      this.lineCleanedBoard[i][j] = false;
    }
  }
  
  public boolean checkColonne (int j) { // True if the line is full
    boolean colonneOk = true;
    for (int i = 0; i < SIDE; i++) {
      colonneOk &= this.board[i][j];
    }
    return colonneOk;
  }
  
  public void cleanColone (int j) {
    for (int i = 0; i < SIDE; i++) {
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
        println("(" + i + ", " + j + ")");
        squareOk &= this.board[i][j];
      }
    }
    return squareOk;
  }
  
  public void cleanSquare (int s) {
    for (int i = s - (s % 3); i < s - (s % 3) + 3; i++) {
      for (int j = (s % 3) * 3; j < ((s % 3) * 3) + 3; j++) {
        println("(" + i + ", " + j + ")");
        this.squareCleanedBoard[i][j] = false;
      }
    }
  }
  
  public void cleanBoard () {
    this.lineCleanedBoard = this.board;
    this.lineCleanedBoard = this.board;
    this.lineCleanedBoard = this.board;
    for (int i = 0; i < SIDE; i++) {
      this.cleanLigne(i);
    }
    for (int i = 0; i < SIDE; i++) {
      this.cleanColone(i);
    }
    for (int i = 0; i < SIDE; i++) {
      this.cleanSquare(i);
    }
  }
  
  public void step () {
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j < SIDE; j++) {
        this.board[i][j] = this.lineCleanedBoard[i][j] && this.colonneCleanedBoard[i][j] && this.squareCleanedBoard[i][j];
      }
    }
  }
  
  
  public void printBoard () {
    for (int i = 0; i < SIDE; i++) {
      for (int j = 0; j < SIDE; j++) {
        print("| " + this.board[i][j] + " |");
      }
      println();
    }
  }
}
