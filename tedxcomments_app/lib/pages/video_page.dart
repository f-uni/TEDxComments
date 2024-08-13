import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/comment.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/widgets/comment_preview.dart';
import 'package:tedxcomments_app/widgets/comments_list.dart';
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

  List<Comment?> comments = [];

  Comment? comment;

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

    comments += talk.comments["info"]
        .map<Comment?>((model) => Comment.fromJSON(model))
        .toList();
    comments += talk.comments["disc"]
        .map<Comment?>((model) => Comment.fromJSON(model))
        .toList();
    comments += talk.comments["extra"]
        .map<Comment?>((model) => Comment.fromJSON(model))
        .toList();

    comments.sort((a, b) => a!.timestamp.compareTo(b!.timestamp));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

   bool _showModal = false;

  void _openModal() {
    setState(() {
      _showModal = true;
    });
  }

  void _closeModal() {
    setState(() {
      _showModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: WebViewWidget(controller: controller),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                  child: Text(widget.talk.title, style: const TextStyle(fontSize: 22)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                  child: Text(
                    "${widget.talk.speakers} - ${widget.talk.views} views",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                CommentPreview(comment: comment, callback: _openModal),
                RelatedVideosList(talk: widget.talk),
              ],
            ),
            if (_showModal)
              NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent == notification.minExtent) {
                    _closeModal();
                  }
                  return true;
                },
                child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.3,
                  maxChildSize: 0.9,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Handle bar for dragging
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [IconButton(onPressed: (){}, icon: const Icon(Icons.add_comment))],
                          ),
                          CommentsList(comments:comments),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  _readTiming() async {
    String timeStr = await controller.runJavaScriptReturningResult(
            "document.getElementsByClassName('Embeddable__controls__current')[0].innerHTML")
        as String;

    final ms = timeStr.replaceAll("\"", "").split(":");
    int time = int.parse(ms[0]) * 60 + int.parse(ms[1]);

    Comment? res = comments.firstWhere((element) => element?.timestamp == time,
        orElse: () => null);
    setState(() {
      if (res != null) {
        comment = res;
      }
    });
  }

}
