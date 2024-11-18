import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TicTacToe()));

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";

  void _handleTap(int index) {
    if (board[index].isEmpty && !_checkWinner()) {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == "X" ? "O" : "X";
      });
    }
  }

  bool _checkWinner() {
    const patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    return patterns.any((p) =>
        board[p[0]] == board[p[1]] &&
        board[p[1]] == board[p[2]] &&
        board[p[0]].isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final winner = _checkWinner()
        ? "Jogador ${currentPlayer == "X" ? "O" : "X"} venceu!"
        : board.contains("")
            ? "Vez do $currentPlayer"
            : "Empate!";

    return Scaffold(
      appBar: AppBar(title: const Text('Jogo da Velha')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => _handleTap(i),
              child: Container(
                margin: const EdgeInsets.all(4),
                color: Colors.blue[100],
                child: Center(
                  child: Text(
                    board[i],
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(winner, style: const TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () => setState(() {
              board = List.filled(9, "");
              currentPlayer = "X";
            }),
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }
}
