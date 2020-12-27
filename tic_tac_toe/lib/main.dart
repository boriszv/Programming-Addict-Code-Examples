import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List<List> _matrix;

  _HomePageState() {
    _initMatrix();
  }

  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic tac toe'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(0, 0),
                _buildElement(0, 1),
                _buildElement(0, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(1, 0),
                _buildElement(1, 1),
                _buildElement(1, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(2, 0),
                _buildElement(2, 1),
                _buildElement(2, 2),
              ],
            ),
          ],
        ),
      )
    );
  }

  String _lastChar = 'o';

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);

        if (_checkWinner(i, j)) {
          _showDialog(_matrix[i][j]);
        } else {
          if (_checkDraw()) {
            _showDialog(null);
          }
        }
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.black
          )
        ),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(
              fontSize: 92.0
            ),
          ),
        ),
      ),
    );
  }

  _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == 'O')
          _matrix[i][j] = 'X';

        else
          _matrix[i][j] = 'O';

        _lastChar = _matrix[i][j];
      }
    });
  }

  _checkDraw() {
    var draw = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ')
          draw = false;
      });
    });
    return draw;
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length-1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player)
        col++;
      if (_matrix[i][y] == player)
        row++;
      if (_matrix[i][i] == player)
        diag++;
      if (_matrix[i][n-i] == player)
        rdiag++;
    }
    if (row == n+1 || col == n+1 || diag == n+1 || rdiag == n+1) {
      return true;
    }
    return false;
  }

  _showDialog(String winner) {
    String dialogText;
    if (winner == null) {
      dialogText = 'It\'s a draw';
    } else {
      dialogText = 'Player $winner won';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game over'),
          content: Text(dialogText),
          actions: <Widget>[
            FlatButton(
              child: Text('Reset Game'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initMatrix();
                });
              },
            )
          ],
        );
      }
    );
  }
}