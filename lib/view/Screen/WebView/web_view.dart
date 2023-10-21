
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({super.key,required this.url});

  String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var isProgress=0.0.obs;
  var pageTitle;

  WebViewController? controller;
  @override
  void initState() {
    print(widget.url);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            isProgress.value=progress/100;
            print(isProgress.value);
          },
          onPageStarted: (String url) async{

            if(await controller!.canGoBack()){
            }else{
              print("Back Screen");
            }
          },
          onPageFinished: (String url) {
            print("data finished + $url");

            setAppBarTitle();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://${widget.url}"));
    super.initState();
  }
  void setAppBarTitle() {
    setState(() {
      pageTitle = FutureBuilder(
        future: controller!.getTitle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Text("${snapshot.data}",maxLines: 1,overflow: TextOverflow.ellipsis,);

          } else {
            return const Text("") ;
          }
        },
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(await controller!.canGoBack()){
          controller!.goBack();
          return false;

        }else{
          return true;
        }

      },
      child: Scaffold(
        appBar: AppBar(
          title:pageTitle,
        ),
        body:Obx(()=>
           Stack(
            children: [
              WebViewWidget(controller:controller!),
              if(isProgress.value != 1)
                Obx(()=> LinearProgressIndicator(value:isProgress.value,))
            ],

          ),
        ) ,



      ),
    );
  }
}