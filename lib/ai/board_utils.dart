bool emptyTilesRemaining(List<String> boardData) {
  return boardData.contains('');
}

enum GameResult { ai, human, draw, none }

GameResult checkGameStatus(List<String> boardData, String ai, String human) {
  // check for wins along each row
  for (var i = 0; i < 3; i++) {
    if ((boardData[i * 3] == boardData[i * 3 + 1]) &&
        boardData[i * 3 + 1] == boardData[i * 3 + 2]) {
      if (boardData[i * 3] == ai) {
        return GameResult.ai;
      } else if (boardData[i * 3] == human) {
        return GameResult.human;
      }
    }
  }

  // check for wins along each column
  for (var j = 0; j < 3; j++) {
    if (boardData[j] == boardData[j + 3] &&
        boardData[j + 3] == boardData[j + 6]) {
      if (boardData[j] == ai) {
        return GameResult.ai;
      } else if (boardData[j] == human) {
        return GameResult.human;
      }
    }
  }

  // check the first diagonal for wins
  if (boardData[0] == boardData[4] && boardData[4] == boardData[8]) {
    if (boardData[0] == ai) {
      return GameResult.ai;
    } else if (boardData[0] == human) {
      return GameResult.human;
    }
  }

  // check the second diagonal for wins
  if (boardData[2] == boardData[4] && boardData[4] == boardData[6]) {
    if (boardData[2] == ai) {
      return GameResult.ai;
    } else if (boardData[2] == human) {
      return GameResult.human;
    }
  }

  if (emptyTilesRemaining(boardData)) {
    return GameResult.none;
  } else {
    return GameResult.draw;
  }
}
