import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/pages/video_page.dart';
import 'package:tedxcomments_app/widgets/shimmer_image.dart';

class TalkThumbnail extends StatelessWidget {
  const TalkThumbnail({super.key, required this.talk});

  final Talk talk;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPage(talk: talk)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerImage(url: talk.imageUrl),
            const SizedBox(
              height: 8,
            ),
            Text(
              talk. title,
              style: const TextStyle(fontSize: 22),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${talk.speakers} - ${talk.views} views",
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
