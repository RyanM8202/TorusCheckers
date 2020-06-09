import static java.lang.Math.floorMod;

static byte BLANK = 0;
static byte BLACK = 1;
static byte RED = 2;

static byte NONE = 0;
static byte SINGLE = 1;
static byte DOUBLE = 2;


byte[][] board;

boolean alreadySelected = false;
boolean doubleExists = false;
boolean blackTurn = true;
boolean jumpedAlready = false;
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
          board[i][j] = BLACK;
        } else if (i >4) {
          board[i][j] = RED;
        } else {
          board[i][j] = BLANK;
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
      // Checkerboard
      fill((i+j) % 2 == 0 ? color(0) : color(255,0,0));
      stroke(0);
      rect(
        squareWidth*j,
        squareHeight*i,
        squareWidth,
        squareHeight
      );
      
      // Pieces
      boolean hasPiece = board[i][j] != BLANK;
      if (hasPiece) {
        if (board[i][j] == BLACK) {
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
  
  if (alreadySelected) {
    //doubleExists = validMove(floorMod(xSel-2, 8), doubleY) || validMove(floorMod(xSel+2, 8), doubleY);
    int xDiff = doubleExists ? 2 : 1;
    int yDiff = xDiff * (blackTurn ? 1 : -1);
    fill(0, 251, 255, 50);
    noStroke();
    if (validMove(floorMod(xSel+xDiff, 8), floorMod(ySel+yDiff, 8))) {
      rect(
        squareWidth*floorMod(xSel+xDiff, 8),
        squareHeight*floorMod(ySel+yDiff, 8),
        squareWidth,
        squareHeight
      );
    }
    if (validMove(floorMod(xSel-xDiff, 8), floorMod(ySel+yDiff, 8))) {
      rect(
        squareWidth*floorMod(xSel-xDiff, 8),
        squareHeight*floorMod(ySel+yDiff, 8),
        squareWidth,
        squareHeight
      );
    }
  }
}

void keyReleased() {
  if (key == ' ') {
    //println("Selected: " + alreadySelected + ", (" + xSel + ", " + ySel + ")");
    //println("Jump:     " + doubleExists);
    //println("Turn:     " + (blackTurn ? "BLACK" : "RED"));
    //println("JumpNo:   " + (jumpedAlready ? 2 : 1));
  }
}
void mouseReleased() {
  int newXSel = floorMod(mouseX / squareWidth, 8);
  int newYSel = floorMod(mouseY / squareHeight, 8);
  if (!alreadySelected) {
    // Select a chip to move
    if (
      (blackTurn && board[newYSel][newXSel] == BLACK) ||
      (!blackTurn && board[newYSel][newXSel] == RED)
    ) {
      
      xSel = newXSel;
      ySel = newYSel;
      
      int doubleY = floorMod(ySel + (blackTurn ? 2 : -2), 8);
      boolean hasDouble = validMove(floorMod(xSel-2, 8), doubleY) || validMove(floorMod(xSel+2, 8), doubleY);
      
      alreadySelected = !doubleExists || hasDouble;
    }
  } else if (xSel == newXSel && ySel == newYSel) {
    // Deselect a chip before moving
    if (!jumpedAlready) {
      alreadySelected = false;
    }
  } else if (validMove(newXSel, newYSel)) {
    move(newXSel, newYSel);
    //println("a: " + doubleExists);
    if (doubleExists) {
      int doubleY = floorMod(ySel + (blackTurn ? 2 : -2), 8);
      doubleExists = validMove(floorMod(xSel-2, 8), doubleY) || validMove(floorMod(xSel+2, 8), doubleY);
    }
    // This cannot be an else statement. This says,
    // if the jump was a (single jump) or a (double jump with no further double jumps) then it is the next turn
    //println("b: " + doubleExists);
    if (!doubleExists) {
      alreadySelected = false;
      blackTurn = !blackTurn;
      jumpedAlready = false;
      
      for (int i=0; i<8; i++) {
        ySel = i;
        int doubleY = floorMod(ySel + (blackTurn ? 2 : -2), 8);
        for (int j=0; j<8; j++) {
          xSel = j;
          if (
            (board[i][j] == BLACK && blackTurn) ||
            (board[i][j] == RED && !blackTurn)
          ) {
            //println(
            if (validMove(floorMod(xSel-2, 8), doubleY) || validMove(floorMod(xSel+2, 8), doubleY)) {
              doubleExists = true;
              break;
            }
          }
        }
        if (doubleExists) {
          break;
        }
      }
    } else {
      jumpedAlready = true;
    }
    
    //println("c: " + doubleExists);
  }
}

boolean validMove(int x, int y) {
  // Positive y is downward,
  // So on Black's turn, (black goes down) the 
  // direction is positive. And vice versa.
  int jump = jumpType(x, y);
  
  if (jump == NONE) {
    return false;
  }
  // Check if the destination is open
  if (board[y][x] != NONE) {
    return false;
  }
  if (jump == SINGLE) {
    return !doubleExists;
  }
  // Finally, if the jump is double
  
  int midX;
  if (abs(xSel - x) == 2) {
    midX = (xSel + x)/2;
  } else if (xSel < 2) {
    midX = floorMod(xSel - 1, 8);
  } else {
    midX = floorMod(xSel + 1, 8);
  }
  int direction = blackTurn ? 1 : -1;
  int midY = floorMod(ySel + direction, 8);
  return board[midY][midX] == (blackTurn ? RED : BLACK);
}

void move(int x, int y) {
  int jump = jumpType(x, y);
  
  if (jump == DOUBLE) {
    int midX;
    if (abs(xSel - x) == 2) {
      midX = (xSel + x)/2;
    } else if (xSel < 2) {
      midX = floorMod(xSel - 1, 8);
    } else {
      midX = floorMod(xSel + 1, 8);
    }
    int direction = blackTurn ? 1 : -1;
    int midY = floorMod(ySel + direction, 8);
    board[midY][midX] = BLANK;
  }
  
  board[y][x] = board[ySel][xSel];
  board[ySel][xSel] = BLANK;
  xSel = x;
  ySel = y;
}

int jumpType(int x, int y) {
  int direction = blackTurn ? 1 : -1;
  
  int retVal;
  int xDiff = abs(x-xSel);
  if (xDiff == 1 || xDiff == 7) {
    retVal = SINGLE;
  } else if (xDiff == 2 || xDiff == 6) {
    retVal = DOUBLE;
  } else {
    return NONE;
  }
  
  // if the y jump doesn't match the x jump, we didn't make a real jump; return NONE;
  int yDiff = direction * (y-ySel);
  if (!(
    (retVal == SINGLE && (yDiff == 1 || yDiff == -7)) ||
    (retVal == DOUBLE && (yDiff == 2 || yDiff == -6))
  )) {
    return NONE;
  }
  
  return retVal;
}
