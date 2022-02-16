import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _RandomWordState();
  }
}

class _RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _savedSuggestions = <WordPair>[];
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
        // Add from here...
        appBar: AppBar(
          backgroundColor: Colors.orange[100],
          foregroundColor: Colors.black,
          title: const Text('Startup Name Generator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
            ),
          ],
        ),
        body: _buildSuggestions());
  }

  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) {
        return const Divider();
      }

      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedSuggestions.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
          semanticLabel: alreadySaved ? "Remove from saved" : "Save",
        ),
        onTap: () {
          setState(() {
            alreadySaved
                ? _savedSuggestions.remove(pair)
                : _savedSuggestions.add(pair);
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _savedSuggestions.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
              backgroundColor: Colors.orange[100],
              foregroundColor: Colors.black,
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
