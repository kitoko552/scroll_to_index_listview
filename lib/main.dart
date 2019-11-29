import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage();

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  static const List<String> _titles = [
    'scroll_to_index',
    'indexed_list_view',
    'scrollable_positioned_list',
  ];
  static const List<IconData> _icons = [
    Icons.home,
    Icons.notifications,
    Icons.search,
  ];

  final _autoScrollController = AutoScrollController(
    axis: Axis.vertical,
    suggestedRowHeight: 210.0,
  );

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _ScrollToIndexList(_autoScrollController),
      _IndexedListViewList(),
      _ScrollablePositionedList(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          for (int i = 0; i < _pages.length; i++)
            BottomNavigationBarItem(
              icon: Icon(_icons[i]),
              title: Text(_titles[i]),
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          for (int i = 0; i < _pages.length; i++)
            Offstage(
              offstage: _selectedIndex != i,
              child: _pages[i],
            ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              final index = Random().nextInt(300);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(index.toString()),
                  duration: const Duration(milliseconds: 200),
                ),
              );
              final oo = await _autoScrollController.scrollToIndex(
                index,
                preferPosition: AutoScrollPosition.begin,
              );
              print(oo);
            },
            child: Icon(Icons.arrow_downward),
          );
        },
      ),
    );
  }
}

class _ScrollToIndexList extends StatelessWidget {
  _ScrollToIndexList(this.controller);

  final AutoScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AutoScrollTag(
          key: ValueKey(index),
          controller: controller,
          index: index,
          child: Container(
            height: (Random().nextInt(400) + 20).toDouble(),
            color: Color.fromRGBO(
              Random().nextInt(256),
              Random().nextInt(256),
              Random().nextInt(256),
              1.0,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IndexedListViewList extends StatelessWidget {
  const _IndexedListViewList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: (Random().nextInt(400) + 20).toDouble(),
          color: Color.fromRGBO(
            Random().nextInt(256),
            Random().nextInt(256),
            Random().nextInt(256),
            1.0,
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScrollablePositionedList extends StatelessWidget {
  const _ScrollablePositionedList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: (Random().nextInt(400) + 20).toDouble(),
          color: Color.fromRGBO(
            Random().nextInt(256),
            Random().nextInt(256),
            Random().nextInt(256),
            1.0,
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
