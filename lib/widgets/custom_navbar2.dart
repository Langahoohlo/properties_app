import 'package:flutter/material.dart';

class customNavBar extends StatefulWidget {
  const customNavBar(Key? key) : super(key: key);

  @override
  _CustomBottomNavigationBar createState() => _CustomBottomNavigationBar();
}

class _CustomBottomNavigationBar extends State<customNavBar> {
  @override
  int _selctedIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selctedIndex = index;
    });
  }

  final List<Widget> _children = [
    const Center(child: Text('HOME')),
    const Center(child: Text('SEARCH')),
    const Center(child: Text('CHAT')),
    const Center(child: Text('NOTIFICATION')),
    const Center(child: Text('LOCAL')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selctedIndex,
        onTap: _navigateBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: ''),
        ],
      ),
    );
  }
}
