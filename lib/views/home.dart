import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ai/board_utils.dart';
import 'package:tic_tac_toe/ai/minimax.dart';
import 'package:tic_tac_toe/widgets/board.dart';
import 'package:tic_tac_toe/widgets/status_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> _boardData = ['', '', '', '', '', '', '', '', '', ''];
  String _player = 'X';
  bool _live = false;
  bool _won = false;
  GameResult _result = GameResult.none;

  // helper function to wipe the board
  void _resetBoard() {
    setState(() {
      _boardData = ['', '', '', '', '', '', '', '', '', ''];
    });
  }

  // helper function to set a tile
  void _setTile(int index, String c) {
    setState(() {
      _boardData[index] = c;
    });
  }

  void _setResult(GameResult r) {
    setState(() {
      _result = r;
    });
  }

  // handle tile being tapped
  void _tapped(int index) {
    if (_live && _boardData[index] == '') {
      // set the tile
      _setTile(index, _player);

      _setResult(
          checkGameStatus(_boardData, _player == 'X' ? 'O' : 'X', _player));

      if (_result == GameResult.human || _result == GameResult.draw) {
        _live = false;
        return;
      }

      int bestMove =
          findBestMove(_boardData, _player == 'X' ? 'O' : 'X', _player);

      _setTile(bestMove, _player == 'X' ? 'O' : 'X');

      _setResult(
          checkGameStatus(_boardData, _player == 'X' ? 'O' : 'X', _player));

      if (_result == GameResult.ai || _result == GameResult.draw) {
        _live = false;
        return;
      }
    }
  }

  void _startGame() {
    _resetBoard();
    setState(() {
      //_result = GameResult.none;
      _live = true;
    });
    if (_player == 'O') {
      var bestMove = findBestMove(_boardData, 'X', 'O');
      _setTile(bestMove, 'X');
    }
  }

  void _setPlayer(String c) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          title: const Text("Tic Tac Toe"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            StatusBar(result: _result, live: _live),
            Board(
              boardData: _boardData,
              tileTapped: (index) => _tapped(index),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (!_live) {
                    _startGame();
                  } else {
                    setState(() {
                      _live = false;
                    });
                    _resetBoard();
                    _setResult(GameResult.none);
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    elevation: 0,
                    backgroundColor: !_live ? Colors.blue : Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: Text(!_live ? "Start a game" : "Quit Game"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleSwitch(
                minWidth: 130,
                changeOnTap: !_live,
                //minHeight: 5,
                initialLabelIndex: _player == 'X' ? 0 : 1,
                icons: [Icons.close, Icons.radio_button_unchecked],
                iconSize: 60,
                customIcons: [
                  Icon(Icons.close, color: Colors.red),
                  Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.blue,
                  )
                ],
                onToggle: (index) {
                  if (!_live) {
                    setState(() {
                      _player = index == 0 ? 'X' : 'O';
                    });
                  }
                },
              ),
            )
          ]),
        ));
  }
}
