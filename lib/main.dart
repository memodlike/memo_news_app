import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart' as prefix0;
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeMo News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MeMo News Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  List<int> _items = List.generate(20, (i) => i);

  bool is_true = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _items.addAll(List.generate(20, (i) => i + _items.length));
        });
      }
    });
  }

  Widget _buildItemList(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://picsum.photos/id/${Random().nextInt(100)}/200/300'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'News $index',
          ),
        ],
      ),
    );
  }

  Widget _buildItemHorizan(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(generateWordPairs().first.asPascalCase),
          SizedBox(height: 10),
          Image.network(
            'https://picsum.photos/id/${Random().nextInt(100)}/200/300',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 144, 5),
        title: const Text('MeMo News'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return is_true
              ? _buildItemHorizan(index)
              : _buildItemList(index); //_buildItemList(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            is_true = !is_true;
          });
        },
        child: is_true ? Icon(Icons.view_module) : Icon(Icons.list),
      ),
    );
  }
}
