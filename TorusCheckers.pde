byte[][] board;

void setup() {
  size(800,800);
  board = new byte[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      board[i][j] &= (i+j) % 2;
    }
  }
}

void draw() {
  drawBoard();
  
}

void drawBoard() {
  int squareWidth = width / 8;
  int squareHeight = height / 8;
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      fill((i+j) % 2 == 0 ? color(0) : color(255,0,0));
      
      //if ((i+j) % 2 == 0) {
      //  fill(0);
      //} else {
      //  fill(255,0,0);
      //}
      
      rect(
        squareWidth*j,
        squareHeight*i,
        squareWidth,
        squareHeight
      );
    }
  }
}
