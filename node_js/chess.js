const Chess = require('chess.js').Chess;
const readline = require('readline');

// Initialize the chess game
const game = new Chess();

// Create a readline interface for user input
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Function to display the chessboard
function displayBoard() {
  console.log(game.ascii());
}

// Function to handle player moves
function playerMove() {
  if (game.isGameOver()) {
    console.log("Game Over!");
    console.log(game.isCheckmate() ? "Checkmate!" : "Draw!");
    rl.close();
    return;
  }

  rl.question("Enter your move (e.g., e2 e4): ", (move) => {
    const result = game.move(move, { sloppy: true });
    if (result) {
      console.log(`Move played: ${move}`);
      displayBoard();
      playerMove();
    } else {
      console.log("Invalid move. Try again.");
      playerMove();
    }
  });
}

// Start the game
console.log("Welcome to Command-Line Chess!");
displayBoard();
playerMove();
