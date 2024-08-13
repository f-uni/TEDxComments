import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/comment.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.comments});

  final List<Comment?> comments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            Comment comment = comments[index]!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: const Color.fromARGB(255, 87, 87, 87),
                          ),
                          child: const Icon(
                            Icons.person,
                          )),
                          const SizedBox(width: 10,),
                      Text(comment.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(comment.body),
                  )

                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.transparent,),
          ),
          itemCount: comments.length),
    );
  }
}
