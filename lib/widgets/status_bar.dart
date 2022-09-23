import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ai/board_utils.dart';

class StatusBar extends StatelessWidget {
  GameResult result;
  bool live;

  StatusBar({super.key, required this.result, required this.live});

  @override
  Widget build(BuildContext context) {
    String statusText;

    if (!live) {
      if (result == GameResult.o) {
        statusText = 'O Wins!';
      } else if (result == GameResult.x) {
        statusText = 'X wins!';
      } else if (result == GameResult.draw) {
        statusText = 'It\'s a draw!';
      } else {
        statusText = 'Let\'s play!';
      }
    } else {
      statusText = 'Game in progress...';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              statusText,
              textAlign: TextAlign.center,
            )),
            height: 40,
          )),
    );
  }
}
