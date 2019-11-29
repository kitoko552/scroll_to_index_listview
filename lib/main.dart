import 'dart:math';

import 'package:flutter/material.dart';

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
  int _selectedIndex = 0;
  int _scrollIndex = 0;

  static const List<String> _titles = [
    'scroll_to_index',
    'indexed_list_view',
    'scrollable_positioned_list',
  ];
  static const List<Widget> _pages = [
    _ScrollToIndexList(),
    _ScrollToIndexList(),
    _ScrollToIndexList(),
  ];
  static const List<IconData> _icons = [
    Icons.home,
    Icons.notifications,
    Icons.search,
  ];

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _scrollIndex = Random().nextInt(300);
          });
        },
        child: Icon(Icons.arrow_downward),
      ),
    );
  }
}

class _ScrollToIndexList extends StatelessWidget {
  const _ScrollToIndexList();

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
