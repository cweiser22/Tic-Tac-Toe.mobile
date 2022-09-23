import 'dart:math';

import 'package:tic_tac_toe/ai/board_utils.dart';

// scores a move
int minimaxScore(
  List<String> boardData,
  int depth,
  String ai,
  String human,
) {
  // check wins
  GameResult status = checkGameStatus(boardData);

  if (status == GameResult.x) {
    if (ai == 'X') {
      return 10 - depth;
    } else {
      return depth - 10;
    }
  } else if (status == GameResult.o) {
    if (ai == 'O') {
      return 10 - depth;
    } else {
      return depth - 10;
    }
  } else {
    return 0;
  }
}

int minimax(
    List<String> boardData, bool isMax, int depth, String ai, String human) {
  // get the score of the move we're evaluating
  int score = minimaxScore([...boardData], depth, ai, human);

  // return the score if this move ends the game
  if (score != 0) {
    return score;
  }
  if (!emptyTilesRemaining(boardData)) {
    return 0;
  }

  if (isMax) {
    int best = -1000;
    for (int i = 0; i < 9; i++) {
      if (boardData[i] == '') {
        boardData[i] = ai;
        best = max(best, minimax([...boardData], false, depth + 1, ai, human));

        boardData[i] = '';
      }
    }
    return best;
  } else {
    int best = 1000;

    for (int i = 0; i < 9; i++) {
      if (boardData[i] == '') {
        boardData[i] = human;
        best = min(best, minimax([...boardData], true, depth + 1, ai, human));

        boardData[i] = '';
      }
    }
    return best;
  }
}

int findBestMove(List<String> boardData, String ai, String human) {
  int bestValue = -1000;
  int bestMove = -1;

  for (int i = 0; i < 9; i++) {
    if (boardData[i] == '') {
      boardData[i] = ai;
      int moveVal = minimax([...boardData], false, 0, ai, human);
      boardData[i] = '';

      if (moveVal > bestValue) {
        bestMove = i;
        bestValue = moveVal;
      }
    }
  }
  return bestMove;
}
