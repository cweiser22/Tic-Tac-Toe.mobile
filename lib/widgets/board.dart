import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  final List<String> boardData;
  final Function tileTapped;

  const Board({super.key, required this.boardData, required this.tileTapped});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      //flex: 3,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          //padding: const EdgeInsets.all(8.0),
          //shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                tileTapped(index);
              },
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(boardData[index],
                        style: TextStyle(
                            fontSize: 60,
                            color: boardData[index] == 'X'
                                ? Colors.red
                                : Colors.blue)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
