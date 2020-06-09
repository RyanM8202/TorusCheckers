# Torus Checkers

Play Checkers on a Torus. This implies that there are no longer kings, pieces just continue around the board.
PLEASE report any issues - I had a bug I've been unable to reproduce, so any information you can provide would be great.

### Instructions
On your turn (Black goes first) click to select a checker of your color. Then click where you want to move it.
* You can only select checkers with viable moves
* In Checkers, when you have the opportunity to jump the opponent's piece, you must take it.
* If you jump an opponents piece, and that piece can continue to jump the opponent's pieces, it must.
* If you deselect a checker without moving it, you can change your selection.

### What does it mean to be on a torus?
A torus is the geometric name for the shape of a donut. As it applies here, the essence of a torus is that a plane can be folded into a torus by connecting its opposite edges, top to bottom and side to side. So, all I mean by "Checkers on a Torus" is that pieces can move off the left side of the board and come back on the right side and vice versa, as well as proceeding across the entire board, leaving the far side of the board and returning to their own side.

![Animation of a checkerboard being folded into a torus](https://plus.maths.org/content/sites/plus.maths.org/files/news/2015/abel/torus_from_rectangle.gif "Checkers on a Torus")

In the original game of checkers, a piece that advances to the far side of the board would become stuck if not for 'crowning' the piece. On a torus, a piece cannot be stuck at the far side of the board, as that piece can simply advance further and end up back around the front. Therefore there is no crowning, only movement forward.

### End of Game
I make no guarantees that the game will end in anything but a perpetual stalemate, as your pieces and your opponents could avoid each other on a torus forever. It could be that with some advance planning you avoid that situation, but that is on you. Good luck!
