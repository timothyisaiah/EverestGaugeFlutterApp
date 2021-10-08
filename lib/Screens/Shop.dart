// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';

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
  late InAppWebViewController webView;

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eg Learning Center'),
        backgroundColor: Colors.green,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://www.toweroflove.org/product/'),
            headers: {},
            method: 'POST'),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true, useOnDownloadStart: true),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
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
