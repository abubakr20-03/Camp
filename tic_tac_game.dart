import 'dart:io';

List<String> board = List.filled(9, ' ');

String currentPlayer = 'X';

// Function to print the board
void printBoard() {
  print('');
  print('${board[0]} | ${board[1]} | ${board[2]}');
  print('--+---+--');
  print('${board[3]} | ${board[4]} | ${board[5]}');
  print('--+---+--');
  print('${board[6]} | ${board[7]} | ${board[8]}');
  print('');
}

// check win
bool checkWin(String p) {
  List win = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ];
  for (var i in win) {
    if (board[i[0]] == p && board[i[1]] == p && board[i[2]] == p) {
      return true;
    }
  }
  return false;
}

// check draw
bool draw() {
  return !board.contains(' ');
}

// switch players
void changePlayer() {
  if (currentPlayer == 'X') {
    currentPlayer = 'O';
  } else {
    currentPlayer = 'X';
  }
}

// get move from user
void getMove() {
  int? m;
  while (true) {
    print('Player $currentPlayer move (1-9): ');
    var input = stdin.readLineSync();
    m = int.tryParse(input ?? '');
    if (m == null || m < 1 || m > 9) {
      print('Invalid input.');
      continue;
    }
    if (board[m - 1] != ' ') {
      print('Already taken!');
      continue;
    }
    break;
  }
  board[m - 1] = currentPlayer;
}

// play again?
void playAgain() {
  print('Play again? y/n');
  var ans = stdin.readLineSync();
  if (ans == 'y') {
    board = List.filled(9, ' ');
    currentPlayer = 'X';
    playGame();
  } else {
    print('Bye!');
  }
}

// main loop
void playGame() {
  while (true) {
    printBoard();
    getMove();
    if (checkWin(currentPlayer)) {
      printBoard();
      print('Player $currentPlayer wins!');
      break;
    } else if (draw()) {
      printBoard();
      print('It\'s a draw.');
      break;
    }
    changePlayer();
  }
  playAgain();
}

// main function
void main() {
  print('Tic-Tac-Toe Game');
  playGame();
}
