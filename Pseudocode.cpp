// Problems found within Pseudocode:
// - Haven't found a way to make it so the user goes 1st or 2nd based on whether they chose to play as 'X' or 'O' 
//   because traditionally in tic-tac-toe the player 'X' always goes 1st
// - Haven't found a way to instantly get to displayTieMessage() when the user inputes the 9th board move,
//   making sure that the computer doesn't get the chance to attempt to make a move on a full board

.data
   myArray: .byte ' ',' ',' ',' ',' ',' ',' ',' ',' '
   
.text

main:
    askUserXorO();              // Ask the user whether they rather play as 'X' or 'O' $s0 = userChar & $s1 = compChar
    int boardMoves = 0;         // The number of moves done by user and computer
    bool didTieHappen = false;  // Whether a tie existing is true or false.
   
    while(userMoves < 9) {
        displayBoardMenu();  // Displays the board with numbers (1-9) on board placements
        getUserInput();      // Ask user to input their move on board (1-9) and save into board
        boardMoves++;        // Increment number of board moves
        displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
        isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
          
        getComputerMove();   // Get the computer to place their move on empty placements
        boardMoves++;        // Increment number of board moves
        displayFullBoard();  // Displays the board with 'X', 'O', and ' ' on the board pieces
        isWinYet();          // Check if a win exist diagonally, vertically, or horizontally
    }
    didTieHappen = true;     // Getting out while-loop indicates that tie did occur.
   
    if(didTieHappen == true) {
       displayTieMessage();  // Display that there has been a tie.
    }
    else {
       displayWinMessage();  // Display a message saying who won the game.
    }
   
exit:
    li $v0, 10;            // Exit the program
    syscall;              

/////////////////// END OF MAIN PROGRAM //////////////////////

isWinYet() {
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
