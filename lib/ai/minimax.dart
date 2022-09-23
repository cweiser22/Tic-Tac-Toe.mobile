import 'dart:math';

import 'package:tic_tac_toe/ai/board_utils.dart';

int minimaxScore(List<String> boardData, String ai, String human, int depth) {
  GameResult status = checkGameStatus(boardData, ai, human);

  if (status == GameResult.ai) {
    return 10 - depth;
  } else if (status == GameResult.human) {
    return depth - 10;
  } else {
    return 0;
  }
}

int minimax(
    List<String> boardData, int depth, bool isMax, String ai, String human) {
  int score = minimaxScore(boardData, ai, human, depth);

  if ((score + depth) == 10 || (score - depth) == -10) {
    return score;
  }
  if (!emptyTilesRemaining(boardData)) {
    return 0;
  }

  // calculating the maximum or minimum score
  if (isMax) {
    var best = -1000;

    // check all empty tiles
    for (int i = 0; i < 9; i++) {
      if (boardData[i] == '') {
        // make the move, reassign best if the move is better, then undo the move
        boardData[i] = ai;
        best = max(best, minimax(boardData, depth + 1, !isMax, ai, human));
        boardData[i] = '';
      }
    }
    return best;
  } else {
    int best = 1000;

    for (int i = 0; i < 9; i++) {
      if (boardData[i] == '') {
        boardData[i] = human;
        best = min(best, minimax(boardData, depth + 1, !isMax, ai, human));
        boardData[i] = '';
      }
    }
    return best;
  }
}

int findBestMove(List<String> boardData, String ai, String human) {
  var bestVal = -1000;
  var bestMove = -1;

  for (int i = 0; i < 9; i++) {
    if (boardData[i] == '') {
      boardData[i] = ai;
      var moveVal = minimax(boardData, 0, true, ai, human);
      boardData[i] = '';

      if (moveVal > bestVal) {
        bestVal = moveVal;
        bestMove = i;
      }
    }
  }
  return bestMove;
}

/*void main() {
  List<String> boardData = ['X', 'X', 'O', 'O', 'X', 'X', '', 'O', 'X'];
  print(findBestMove(boardData, 'O', 'X'));
}
*/