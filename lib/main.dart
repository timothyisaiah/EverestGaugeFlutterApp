import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:eg_learning_center/Screens/Elearners.dart';
import 'package:eg_learning_center/Screens/Grader.dart';
import 'package:eg_learning_center/Screens/Reports.dart';
import 'package:eg_learning_center/Screens/Shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide WebView;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
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
            height: 150,
            width: 150,
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
            height: 150,
            width: 150,
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
            height: 150,
            width: 150,
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
            height: 150,
            width: 150,
          ),
          Text('Reports'),
        ],
      ),
    ),
  ];
  List<Widget> _classViews = <Widget>[
    Shop(
      key: UniqueKey(),
    ),
    Grader(
      key: UniqueKey(),
    ),
    Elearners(
      key: UniqueKey(),
    ),
    Reports(
      key: UniqueKey(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Icon(
          //   Icons.school,
          //   size: 150.0,
          // ),
          Image(
            image: AssetImage('./img/logo.png'),
            height: 180,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              ' Welcome, Select option ',
              style: const TextStyle(
                fontSize: 22,
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

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);
  // MyHomePage({});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; //index of selected tab on bottom navigation
  ReceivePort _port = ReceivePort();

  //Selecting active tab on bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  List<Widget> _pages = <Widget>[
    HomeMenu(),
    InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse('https://www.toweroflove.org/product/'),
          headers: {},
          method: 'POST'),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true, useOnDownloadStart: true),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        // webView = controller;
      },
      onLoadStart: (InAppWebViewController controller, Uri? url) {},
      onLoadStop: (InAppWebViewController controller, Uri? url) {},
      onDownloadStart: (controller, url) async {
        if (await Permission.storage.request().isGranted) {
          print("onDownloadStart $url");
          final taskId = await FlutterDownloader.enqueue(
            url: url.path,
            savedDir: (await getExternalStorageDirectory())!.path,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );
        } else if (await Permission.storage.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.storage.request().isDenied) {
          await openAppSettings();
        }
      },
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'https://everestgauge.com/grader',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse('https://everestgauge.org/courses'),
          headers: {},
          method: 'POST'),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true, useOnDownloadStart: true),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        // webView = controller;
      },
      onLoadStart: (InAppWebViewController controller, Uri? url) {},
      onLoadStop: (InAppWebViewController controller, Uri? url) {},
      onDownloadStart: (controller, url) async {
        if (await Permission.storage.request().isGranted) {
          print("onDownloadStart $url");
          final taskId = await FlutterDownloader.enqueue(
            url: 'https://www.toweroflove.org' + url.path,
            savedDir: (await getExternalStorageDirectory())!.path,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );
        } else if (await Permission.storage.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.storage.request().isDenied) {
          await openAppSettings();
        }
      },
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
