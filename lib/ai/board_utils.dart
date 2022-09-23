bool emptyTilesRemaining(List<String> boardData) {
  return boardData.contains('');
}

enum GameResult { x, o, draw, none }

GameResult checkGameStatus(List<String> boardData) {
  // check for wins along each row
  for (var i = 0; i < 3; i++) {
    if ((boardData[i * 3] == boardData[i * 3 + 1]) &&
        boardData[i * 3 + 1] == boardData[i * 3 + 2]) {
      if (boardData[i * 3] == 'X') {
        return GameResult.x;
      } else if (boardData[i * 3] == 'O') {
        return GameResult.o;
      }
    }
  }

  // check for wins along each column
  for (var j = 0; j < 3; j++) {
    if (boardData[j] == boardData[j + 3] &&
        boardData[j + 3] == boardData[j + 6]) {
      if (boardData[j] == 'X') {
        return GameResult.x;
      } else if (boardData[j] == 'O') {
        return GameResult.o;
      }
    }
  }

  // check the first diagonal for wins
  if (boardData[0] == boardData[4] && boardData[4] == boardData[8]) {
    if (boardData[0] == 'X') {
      return GameResult.x;
    } else if (boardData[0] == 'O') {
      return GameResult.o;
    }
  }

  // check the second diagonal for wins
  if (boardData[2] == boardData[4] && boardData[4] == boardData[6]) {
    if (boardData[2] == 'X') {
      return GameResult.x;
    } else if (boardData[2] == 'O') {
      return GameResult.o;
    }
  }

  return emptyTilesRemaining(boardData) ? GameResult.none : GameResult.draw;
}
