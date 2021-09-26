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

  static List<Widget> _pages = <Widget>[
    Column(
      children: <Widget>[
        Icon(
          Icons.school,
          size: 150.0,
        ),
        Text('EG LEARNING CENTER',style: const TextStyle(fontSize:30, fontWeight: FontWeight.bold),),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(_cardsToDisplay.length, (index) {
              return Center(
                child: _cardsToDisplay[index],
              );
            }),
          ),
        ),
      ],
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://www.toweroflove.org/product/',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://everestgauge.com/grader',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://everestgauge.org/courses',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://everestgauge.org/login',
      javascriptMode: JavascriptMode.unrestricted,
    ),
  ];

  static List<Widget> _cardsToDisplay = <Widget>[
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Icon(
            Icons.shopping_bag,
            color: Colors.black,
            size: 150.0,
          ),
          Text('Shop'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Icon(
            Icons.bar_chart,
            color: Colors.black,
            size: 150.0,
          ),
          Text('Grader'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Icon(
            Icons.stacked_line_chart,
            color: Colors.black,
            size: 150.0,
          ),
          Text('Learning'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Icon(
            Icons.list,
            color: Colors.black,
            size: 150.0,
          ),
          Text('Reports'),
        ],
      ),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Grader',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Reports',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: _pages[
          _selectedIndex], //This displays the webviews based on the selected index
    );
  }
}
