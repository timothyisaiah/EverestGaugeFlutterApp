import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
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
      title: 'EG Learning Center',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(key: UniqueKey(), title: 'EG Learning Center'),
    );
  }
}

// this is the home screen at first index
class HomeMenu extends StatefulWidget {
  // HomeMenu({Key key, this.title}) : super(key: key);
  // final String title;
  // final int selectedindex;
  // final Function onItemTapped;
  // HomeMenu({required this.selectedindex, required this.onItemTapped});
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  static List<Widget> _cardsToDisplay = <Widget>[
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('img/shop.png'),
            height: 100,
            width: 100,
          ),
          Text('Shop'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('img/grades.png'),
            height: 100,
            width: 100,
          ),
          Text('Grader'),
        ],
      ),
      // color: Colors.black45,
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('img/learn.jpg'),
            height: 100,
            width: 100,
          ),
          Text('Learning'),
        ],
      ),
      // color: Colors.black45,
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('img/report.png'),
            height: 100,
            width: 100,
          ),
          Text('Reports'),
        ],
      ),
    ),
  ];
  List<Widget> _classViews = <Widget>[
    Shop(key: UniqueKey(),),
    Grader(key: UniqueKey(),),
    Elearners(key: UniqueKey(),),
    Reports(key: UniqueKey(),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Icon(
          //   Icons.school,
          //   size: 100.0,
          // ),
          Image(
            image: AssetImage('./img/logo.png'),
            height: 180,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '  EG LEARNING CENTER  ',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black45,
                color: Colors.white,
              ),
            ),
          ),

          Expanded(
            child: Card(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(_cardsToDisplay.length, (index) {
                  return InkWell(
                    child: _cardsToDisplay[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _classViews[index]),
                      );
                    },
                  );
                }),
              ),
              color: Colors.black45,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
    );
  }
}

class Elearners extends StatefulWidget {
  Elearners({required Key key}) : super(key: key);

  @override
  _ElearnersState createState() => _ElearnersState();
}

class _ElearnersState extends State<Elearners> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eg Learning Center'),
        backgroundColor: Colors.green,
      ),
      body: WebView(
        key: UniqueKey(),
        initialUrl: 'https://everestgauge.org/courses',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: 'Learning',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class Reports extends StatefulWidget {
  Reports({required Key key}) : super(key: key);

  @override
  ReportsState createState() => ReportsState();
}

class ReportsState extends State<Reports> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    FadeInImage.assetNetwork(
        placeholder: cupertinoActivityIndicator, image: 'img/loader.png');
    return Scaffold(
      appBar: AppBar(
        title: Text('Eg Learning Center'),
        backgroundColor: Colors.green,
      ),
      body: WebView(
        key: UniqueKey(),
        initialUrl: 'https://everestgauge.org/login',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
    );
  }
}

class Grader extends StatefulWidget {
  Grader({required Key key}) : super(key: key);

  @override
  GraderState createState() => GraderState();
}

class GraderState extends State<Grader> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eg Learning Center'),
        backgroundColor: Colors.green,
      ),
      body: WebView(
        key: UniqueKey(),
        initialUrl: 'https://everestgauge.com/grader',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Grader',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class Shop extends StatefulWidget {
  Shop({required Key key}) : super(key: key);

  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<Shop> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eg Learning Center'),
        backgroundColor: Colors.green,
      ),
      body: WebView(
        key: UniqueKey(),
        initialUrl: 'https://www.toweroflove.org/product/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);
  // MyHomePage({});

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

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  static List<Widget> _pages = <Widget>[
    HomeMenu(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
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
      body: (_selectedIndex == 0)
          ? HomeMenu()
          : _pages[
              _selectedIndex], //This displays the webviews based on the selected index
    );
  }
}
