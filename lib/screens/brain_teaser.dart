import 'package:flutter/material.dart';

import '../widgets/bottomNavBar.dart';

void main() {
  runApp(BrainTeaserApp());
}

class BrainTeaserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BrainTeaserScreen(),
    );
  }
}

class BrainTeaserScreen extends StatefulWidget {
  @override
  _BrainTeaserScreenState createState() => _BrainTeaserScreenState();
}

class _BrainTeaserScreenState extends State<BrainTeaserScreen> {
  List<int> tiles = List.generate(16, (index) => index);
  int emptyTileIndex = 15;
  int moves = 0;

  @override
  void initState() {
    super.initState();
    _shuffleTiles();
  }

  void _shuffleTiles() {
    tiles.shuffle();
    setState(() {
      emptyTileIndex = tiles.indexOf(15);
      moves = 0;
    });
  }

  void _swapTiles(int tappedTileIndex) {
    if (_isValidMove(tappedTileIndex)) {
      setState(() {
        final tappedTileValue = tiles[tappedTileIndex];
        tiles[tappedTileIndex] = 15;
        tiles[emptyTileIndex] = tappedTileValue;
        emptyTileIndex = tappedTileIndex;
        moves++;
        _checkPuzzleSolved();
      });
    }
  }

  bool _isValidMove(int tappedTileIndex) {
    final rowDiff = (tappedTileIndex ~/ 4) - (emptyTileIndex ~/ 4);
    final colDiff = (tappedTileIndex % 4) - (emptyTileIndex % 4);
    return (rowDiff.abs() == 1 && colDiff == 0) || (rowDiff == 0 && colDiff.abs() == 1);
  }

  void _checkPuzzleSolved() {
    if (List.generate(15, (index) => index).toString() == tiles.sublist(0, 15).toString()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Puzzle Solved!'),
          content: Text('Congratulations! You solved the puzzle in $moves moves.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _shuffleTiles();
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brain Teaser'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Brain Teaser Puzzle',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Rules:\n'
                  '1. Rearrange the tiles to solve the puzzle.\n'
                  '2. Tap on adjacent tiles to slide them into the empty spot.\n'
                  '3. Arrange tiles in ascending order (0 to 14) to win.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: 16,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _swapTiles(index),
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: tiles[index] != 15 ? Colors.blue : Colors.grey, // Empty spot
                  child: Center(
                    child: tiles[index] != 15
                        ? Text(
                      tiles[index].toString(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                        : Container(), // Empty spot
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffleTiles,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
