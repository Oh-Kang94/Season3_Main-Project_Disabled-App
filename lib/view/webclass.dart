import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebClass extends StatefulWidget {
  final String site;
  const WebClass({super.key, required this.site});

  @override
  State<WebClass> createState() => _WebClassState();
}



class _WebClassState extends State<WebClass> {
  late WebViewController controller;
  late bool isLoading;
  late String siteName;


  @override
  void initState() {
    super.initState();
    isLoading = true;
    siteName = widget.site;

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) { 
          isLoading = true;
          setState(() {
            
          });
        },
        onPageStarted: (url) { 
          isLoading = true;
          setState(() {
            
          });
        },
        onPageFinished: (url) {
          isLoading = false;
          setState(() {
            
          });
        },
        onWebResourceError: (error) {
          isLoading = false;
          setState(() {
            
          });
        },
      )
    )
    ..loadRequest(Uri.parse("http://$siteName"));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( 
      children: [
        isLoading
        ? const Center( 
        child: CircularProgressIndicator(),
        ) 
    :const SizedBox(),
    WebViewWidget(
      controller: controller)
      ],
      ),
    );
  }










}//END