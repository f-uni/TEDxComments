import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/pages/video_page.dart';
import 'package:tedxcomments_app/widgets/shimmer_image.dart';

class RelatedTalk extends StatelessWidget {
  const RelatedTalk({super.key, required this.talk});

  final Talk talk;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VideoPage(talk: talk)),
        );
      },
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 150, child: ShimmerImage(url: talk.imageUrl)),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    talk.title,
                    style: const TextStyle(fontSize: 16),
                    //overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${talk.speakers} - ${talk.views} views",
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      
    );
  }
}
