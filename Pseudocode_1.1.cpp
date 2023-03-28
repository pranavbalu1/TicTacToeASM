.data
   myArray: .byte ' ',' ',' ',' ',' ',' ',' ',' ',' ' 
   
.text

main:
   askUserXorO();              // Ask the user whether they rather play as 'X' or 'O'
                               // $s0 = userChar & $s1 = compChar
   int boardMoves = 0;         // The number of moves done by user and computer
   bool didTieHappen = false;  // Whether a tie existing is true or false.
   
   if(user == 'X') {
      branch to xWhileLoop
   }
   if(user == 'O') {
      branch to oWhileLoop
   }
   
   while() {  // x while loop
      displayBoardMenu();  // Displays the board with numbers (1-9) on board placements
      getUserInput();      // Ask user to input their move on board (1-9) and save into board
      userMoves++;         // Increment number of board moves
      displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
      isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
      
      if(userMoves == 9) {
         branch to exitWhileLoop;
      }
      
      getComputerMove();   // Get the computer to place their move on empty placements
      userMoves++;        // Increment number of board moves
      displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
      isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
   }

   while() {  // o while loop
      getComputerMove();   // Get the computer to place their move on empty placements
      boardMoves++;        // Increment number of board moves
      displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
      isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
      
      displayBoardMenu();  // Displays the board with numbers (1-9) on board placements
      getUserInput();      // Ask user to input their move on board (1-9) and save into board
      boardMoves++;        // Increment number of board moves
      displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
      isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
      
      if(userMoves == 9){
         branch to exitWhileLoop;
      }
      
      displayBoardMenu();  // Displays the board with numbers (1-9) on board placements
      getUserInput();      // Ask user to input their move on board (1-9) and save into board
      boardMoves++;        // Increment number of board moves
      displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
      isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
   }
   
   exitWhileLoop:
   
   didTieHappen = true;    // Getting out while-loop indicates that tie did occur.
   
   if(didTieHappen == true) {
      displayTieMessage(); // Display that there has been a tie.
   }
   else {
      displayWinMessage(); // Display a message saying who won the game.
   }
   
   // Exit the program

/////////////////// END OF MAIN PROGRAM ///////////////////////////////////////

isWinYet()
{
   isWinDiagonally();   // If win found, branch to displayWin();
   isWinVertically();   // If win found, branch to displayWin();
   isWinHorizontally(); // IF win found, branch to displayWin();
}

getComputerMove() {
   // Somewhere in this code you will have to check whether the board placement is free to have the computer move on.
   // So, please make a seperate function like isBoardSpotFree() so it can be used for other parts of the code.
   // Have it return a bool (true or false) on whether the board placement is free or not.
}

isBoardSpotFree() {
   
}
