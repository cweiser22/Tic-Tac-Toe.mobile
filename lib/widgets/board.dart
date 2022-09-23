import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  List<String> boardData;
  Function tileTapped;

  Board({required this.boardData, required this.tileTapped});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: MediaQuery.of(context).size.width,
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
