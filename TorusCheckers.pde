import static java.lang.Math.floorMod;

byte[][] board;

boolean selected = false;
int xSel, ySel;

int squareWidth, squareHeight;

void setup() {
  size(800,800);
  surface.setResizable(true);
  board = new byte[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if ((i+j) % 2 == 0) {
        if (i < 3) {
          board[i][j] = 1;
        } else if (i >4) {
          board[i][j] = 2;
        }
      }
    }
  }
}

void draw() {
  squareWidth = width / 8;
  squareHeight = height / 8;
  drawBoard();
  
}

void drawBoard() {
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
      
      boolean hasPiece = board[i][j] > 0;
      if (hasPiece) {
        if (board[i][j] == 1) {
          fill(color(0));
          stroke(color(255,0,0));
        } else {
          fill(color(255,0,0));
          stroke(color(0));
        }
        ellipse(
          (j+0.5)*squareWidth,
          (i+0.5)*squareHeight,
          squareWidth,
          squareHeight
        );
      }
    }
  }
  
  if (selected) {
    fill(0, 251, 255, 50);
    noStroke();
    rect(
      squareWidth*xSel,
      squareHeight*ySel,
      squareWidth,
      squareHeight
    );
  }
}

void mouseClicked() {
  int newXSel = mouseX / squareWidth;
  int newYSel = mouseY / squareHeight;
  if (!selected) {
    selected = true;
    xSel = newXSel;
    ySel = newYSel;
  } else if (xSel == newXSel && ySel == newYSel) {
    selected = false;
  }
}
