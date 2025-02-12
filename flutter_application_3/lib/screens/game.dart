// TODO Implement this library.
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isX = true;
  List<String> displayXO = List.filled(9, " ");
  List<int> selectedIndex = [];
  int xCount = 0;
  int oCount = 0;
  int tieCount = 0;
  String resultDeclaration = "";
  bool isReset = false;

  static const int max_seconds = 30;
  int seconds = max_seconds;
  Timer? timer;

  void _onTap(int index) {
    final isRunning = timer != null && timer!.isActive;

    if (isRunning && displayXO[index] == " ") {
      setState(() {
        displayXO[index] = isX ? "X" : "O";
        isX = !isX;
        tieCount++;
        _checkWin();
      });
    }
  }

  void _checkWin() {
    final List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]  // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (displayXO[pattern[0]] == displayXO[pattern[1]] &&
          displayXO[pattern[0]] == displayXO[pattern[2]] &&
          displayXO[pattern[0]] != " ") {
        setState(() {
          resultDeclaration = "Player " + displayXO[pattern[0]] + " Wins";
          selectedIndex.addAll(pattern);
          _stopTimer();
          _updateScore(displayXO[pattern[0]]);
        });
        return;
      }
    }

    if (tieCount == 9 && resultDeclaration.isEmpty) {
      setState(() {
        resultDeclaration = "TIE!";
        _stopTimer();
      });
    }
  }

  void _updateScore(String player) {
    setState(() {
      if (player == "X") xCount++;
      if (player == "O") oCount++;
      isReset = true;
    });
  }

  void _clearBoard() {
    setState(() {
      displayXO = List.filled(9, " ");
      resultDeclaration = "";
      selectedIndex.clear();
      tieCount = 0;
      isX = true;
    });
    _resetTimer();
  }

  Widget _buildTimer() {
    final isRunning = timer != null && timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / max_seconds,
                  backgroundColor: Color.fromARGB(255, 30, 129, 142),
                  strokeWidth: 8,
                  valueColor:
                      AlwaysStoppedAnimation(Color.fromARGB(255, 148, 43, 17)),
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[900],
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 233, 223, 226),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            ),
            onPressed: () {
              _startTimer();
              _clearBoard();
            },
            child: Text(
              "Start",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _resetTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _resetTimer();
    timer?.cancel();
  }

  void _resetTimer() => seconds = max_seconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: MainColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScoreColumn("Player X", xCount),
                  SizedBox(width: 20),
                  _buildScoreColumn("Player O", oCount),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => _onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 5,
                            color: Color.fromARGB(255, 13, 1, 5),
                          ),
                          color: selectedIndex.contains(index)
                              ? Color.fromARGB(255, 214, 120, 73)
                              : Color.fromARGB(255, 217, 208, 206),
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: TextStyle(
                              fontSize: 50,
                              color: Color.fromARGB(255, 1, 15, 3),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    resultDeclaration,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  _buildTimer(),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    ),
                    onPressed: _clearBoard,
                    child: Text(
                      "Reset",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreColumn(String title, int score) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}