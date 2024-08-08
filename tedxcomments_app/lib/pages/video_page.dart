import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/widgets/related_videos_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.talk});
  final Talk talk;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final Talk talk;
  late final String videoUrl;
  late final WebViewController controller;
  late final Timer timer;

  late List<dynamic> comments;

  @override
  void initState() {
    super.initState();
    talk = widget.talk;
    videoUrl = talk.url.replaceFirst("https://www", "https://embed");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            controller.runJavaScript(
                "document.getElementsByClassName('Embeddable__button Embeddable__controls__outbound')[0].style.display='none'");
            timer = Timer.periodic(
                const Duration(seconds: 1), (Timer t) => _readTiming());
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(videoUrl));

      comments = talk.comments["info"] + talk.comments["disc"]+ talk.comments["extra"];
      print(comments);
      comments.sort((a,b)=> a["timestamp"].compareTo(b["timestamp"]));
      print(comments);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: WebViewWidget(controller: controller))),
              Text(talk.title, style: const TextStyle(fontSize: 22)),
              Text(
                "${talk.speakers} - ${talk.views} views",
                style: const TextStyle(fontSize: 14),
              ),

              RelatedVideosList(talk: talk)
            ],
          ),
        ));
  }

  _readTiming() async {
    String timeStr = await controller.runJavaScriptReturningResult(
            "document.getElementsByClassName('Embeddable__controls__current')[0].innerHTML")
        as String;

    final ms = timeStr.replaceAll("\"", "").split(":");
    int time = int.parse(ms[0]) * 60 + int.parse(ms[1]);
    
    dynamic res = comments.firstWhere((element)=> element["timestamp"] == time, orElse: ()=>null);
    print(res);
  }
}
