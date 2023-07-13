# 
# EightQ.sl -- Eight queens problem:  Place 8 queens on a chess board so none
#              is under attack from the others.
# 
# Mosur Ravishankar (rkm@cs.cmu.edu)
# 


# SL doesn't have comments.  To remove these comment lines for running the program,
# do this:
#   sed 's/#.*$/ /' SLprogramfilename | java Proj4


# Use the arbitrary precision arithmetic in SL to represent an 8x8 board (64 digits):
#   row r, col c corresponds to digit position r*8 + c (call it board[r,c]);
#   if board[r,c] is 0, that position is unoccupied, and not under attack;
#   if board[r,c] is 1, that position is occupied by a queen;
#   if board[r,c] is 2, that position is under attack by at least one queen.
# Basically, try a depth first search of all possible queen placements in successsive
# rows.  (More efficient solutions exist; but this one is a good test of the SL
# interpreter.)
# 
# To DEBUG the program/SL-interpreter, you can get detailed output after each queen
# placement.  Just uncomment the call to showBoard() in function setPiece() below.


# Return 10^exp.
#
function getPow (exp)
{
  let i = 0;
  let pow = 1;
  
  while (< i exp) {
    let i = (+ i 1);
    let pow = (* pow 10);
  }

  return pow;
}


# Return digit value corresponding to board[row, col]
# 
function getDigit (board, row, col)
{
  let pow = call getPow ((+ (* row 8) col));
  return (/ (% board (* pow 10))
            pow);
}


# Set board[row, col] to newDigit
# 
function setDigit (board, row, col, newDigit)
{
  let pow = call getPow ((+ (* row 8) col));
  let curDigit = (/ (% board (* pow 10))
                    pow);

  return (+ board
            (* (+ (~ curDigit) newDigit)
               pow));
}


# Print the given row,col values as a number.  Internally, row and col values range
# from 0..7.  Externally, for printing, they range from 1..8.
# 
function writeRowCol (row, col)
{
  write (+ (* 10 (+ row 1)) (+ col 1));		# 2 digit value for row,col
}


# Print a the contents of a given row of the board.  Format:
#   Each board position can be a 0, 1, or 2 (for empty, occupied, attacked).
#
function writeRow (board, row)
{
  let col = 0;
  let k = 0;

  while (< col 8) {
    let p = call getDigit (board, row, col);
    let k = (+ (* 10 k) p);
    let col = (+ col 1);
  }

  write (+ (* 100000000 (+ row 1)) k);
}


# Print the current board configuration.  Each row is written in one line
# Format of row: rcccccccc, where r is the row# (starting from 1), c = board value
# in that column (1 for occupied, 2 for attacked, 0 otherwise).  See writeRow() above.
# 
function showBoard (board)
{
  let row = 0;
  while (< row 8) {
    call writeRow (board, row);
    let row = (+ row 1);
  }
}


# Show the queen positions (row,col coordinates, origin at 1,1)
function showQueens (board)
{
  let row = 0;

  while (< row 8) {
    let col = 0;

    while (< col 8) {-
      let p = call getDigit (board, row, col);

      if (== p 1) {
        call writeRowCol (row, col);
        break;
      }

      let col = (+ col 1);
    }

    if (>= col 8) {
      call writeRowCol (row, (~1));	# Indicate no queen in this row
    }

    let row = (+ row 1);
  }
}


# Place a queen at [row, col], marking board[row, col] appropriately.
# Also, mark all attacked positions as a result (mark only rows > row).
# 
function setPiece (board, row, col)
{
  let board = call setDigit (board, row, col, 1);

  # Print the coordinates of the position at which a queen is being placed
  call writeRowCol(row, col);
  
  let row = (+ row 1);
  let j = 1;
  
  while (< row 8) {
    let k = (- col j);

    while (<= k (+ col j)) {
      if (& (>= k 0) (< k 8)) {
	let board = call setDigit (board, row, k, 2);
      }

      let k = (+ k j);
    }

    let row = (+ row 1);
    let j = (+ j 1);
  }
  
  # Uncomment the following line if you want to see the board after each move (slow!)
  # call showBoard (board);
  
  return board;
}


# Place queens on the current board from row onwards.
# Return board representation if successful, 0 otherwise.
# 
function placeQ (board, row)
{
  let col = 0;

  while (< col 8) {
    let p = call getDigit (board, row, col);
    
    if (== p 0) {
      let newBoard = call setPiece (board, row, col);

      if (< row 7) {
	let newBoard = call placeQ(newBoard, (+ row 1));

	if (> newBoard 0) {
          return newBoard;
        }
      } else {
        return newBoard;
      }
    }

    let col = (+ col 1);
  }
  
  return (0);
}


{
  let board = call placeQ (0, 0);

  write 99999999;	# Signal end of search

  call showQueens (board);
}