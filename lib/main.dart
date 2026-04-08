import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MyAiFriendApp()),
  );
}

class MyAiFriendApp extends StatefulWidget {
  const MyAiFriendApp({super.key});

  @override
  State<MyAiFriendApp> createState() => _MyAiFriendAppState();
}

class _MyAiFriendAppState extends State<MyAiFriendApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Loading progress
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://ais-pre-finhub3g6xkvtkfqsek3x3-692138362537.asia-east1.run.app',
        ),
      );
  }

  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
