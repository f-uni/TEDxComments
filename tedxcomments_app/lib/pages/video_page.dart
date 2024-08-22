import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedxcomments_app/models/comment.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/util/data_provider.dart';
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
  late Talk talk;
  late final String videoUrl;
  late final WebViewController controller;
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  late final SharedPreferences prefs;

  late final Timer timer;

  final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();

  List<Comment?> comments = [];

  Comment? comment;
  String username = "";

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username")!;
    });
  }

  void updateTalk() {
    DataProvider.getCommentsById(talk.id).then((value) {
      setState(() {
        comments = [];
        comments += value["info"]
            .map<Comment?>((model) => Comment.fromJSON(model))
            .toList();
        comments += value["disc"]
            .map<Comment?>((model) => Comment.fromJSON(model))
            .toList();
        comments += value["extra"]
            .map<Comment?>((model) => Comment.fromJSON(model))
            .toList();

        comments.sort((a, b) => a!.timestamp.compareTo(b!.timestamp));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
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
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: WebViewWidget(controller: controller),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color.fromARGB(255, 74, 68, 88),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child:
                  Text(widget.talk.title, style: const TextStyle(fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Text(
                "${widget.talk.speakers} - ${widget.talk.views} views",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommentPreview(comment: comment, callback: _openModal),
                        RelatedVideosList(talk: widget.talk),
                      ],
                    ),
                  ),
                  if (_showModal)
                    NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        if (notification.extent < 0.5) {
                          _closeModal();
                        }
                        return true;
                      },
                      child: DraggableScrollableSheet(
                        initialChildSize: 1,
                        snap: true,
                        controller: sheetController,
                        builder: (BuildContext context, scrollController) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 33, 31, 38),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                SliverAppBar(
                                  primary: false,
                                  backgroundColor:
                                      const Color.fromARGB(255, 33, 31, 38),
                                  floating: true,
                                  scrolledUnderElevation: 0,
                                  leading: Container(),
                                  title: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).hintColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      height: 4,
                                      width: 40,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                    ),
                                  ),
                                  pinned: true,
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          onPressed: () async {
                                            String timeStr = await controller
                                                    .runJavaScriptReturningResult(
                                                        "document.getElementsByClassName('Embeddable__controls__current')[0].innerHTML")
                                                as String;
                                            final ms = timeStr
                                                .replaceAll("\"", "")
                                                .split(":");
                                            int time = int.parse(ms[0]) * 60 +
                                                int.parse(ms[1]);
                                            
                                            if(!context.mounted) return;
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    _commentPopUp(
                                                        context,
                                                        timeStr.replaceAll(
                                                            "\"", ""),
                                                        time));
                                          },
                                          icon: const Icon(Icons.add_comment)),
                                    )
                                  ],
                                ),
                                CommentsList(comments: comments)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
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

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Widget _commentPopUp(BuildContext context, String timeStr, int time) {
    return AlertDialog(
      title: Text("New Comment $timeStr"),
      content: SingleChildScrollView(
        child: Form(
            key: _commentFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Title"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Comment title can't be empty";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(hintText: "Body"),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Comment body can't be empty";
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                OutlinedButton(
                    onPressed: () {
                      if (_commentFormKey.currentState!.validate()) {
                        String title = titleController.text;
                        String body = bodyController.text;
                        DataProvider.insertComment(
                                talk.id, title, body, time, username)
                            .then((value) {
                          updateTalk();
                        });
                        titleController.clear();
                        bodyController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Insert"))
              ],
            )),
      ),
    );
  }
}
