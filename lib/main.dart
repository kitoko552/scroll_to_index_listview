import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
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
  final _indexedScrollController = IndexedScrollController();
  final _itemScrollController = ItemScrollController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _ScrollToIndexList(_autoScrollController),
      _IndexedListViewList(_indexedScrollController),
      _ScrollablePositionedList(_itemScrollController),
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
              final index = Random().nextInt(_maxItemCount);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(index.toString()),
                  duration: const Duration(milliseconds: 300),
                ),
              );

              if (_selectedIndex == 0) {
                _autoScrollController.scrollToIndex(
                  index,
                  preferPosition: AutoScrollPosition.begin,
                );
              } else if (_selectedIndex == 1) {
                _indexedScrollController.jumpToIndex(index);
              } else if (_selectedIndex == 2) {
                _itemScrollController.jumpTo(index: index);
              }
            },
            child: Icon(Icons.arrow_downward),
          );
        },
      ),
    );
  }
}

const int _maxItemCount = 300;

class _ScrollToIndexList extends StatelessWidget {
  _ScrollToIndexList(this.controller);

  final AutoScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _maxItemCount,
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
  const _IndexedListViewList(this.controller);

  final IndexedScrollController controller;

  @override
  Widget build(BuildContext context) {
    return IndexedListView.builder(
      controller: controller,
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
  const _ScrollablePositionedList(this.controller);

  final ItemScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: _maxItemCount,
      itemScrollController: controller,
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
