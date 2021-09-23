import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KINTU Learning Center',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'KINTU Learning Center'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; //index of selected tab on bottom navigation

  //Selecting active tab on bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static  List<Widget> _pages = <Widget>[
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://everestgauge.com/',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://everestgauge.com/grader',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://toweroflove.org/',
      javascriptMode: JavascriptMode.unrestricted,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Grader',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Learning',
          ),
        ],
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped,
      ),
      body: _pages[_selectedIndex],//This displays the webviews based on the selected index
    );
  }
}
