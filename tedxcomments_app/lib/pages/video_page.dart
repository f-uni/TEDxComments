import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/talk.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.talk});
  final Talk talk;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final Talk talk;
  @override
  void initState() {
    super.initState();
    talk=widget.talk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AspectRatio(
                aspectRatio: 16 / 9,
                child: Placeholder()),
            Text(
              talk.title,
              style: const TextStyle(fontSize: 22)
            ),
            Text(
              "${talk.speakers} - ${talk.views} views",
              style: const TextStyle(fontSize: 14),
            )
          ],
        )
    );
  }
}
