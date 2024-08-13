import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/comment.dart';

class CommentPreview extends StatelessWidget {
  final Comment? comment;
  final Function callback;
  const CommentPreview({super.key, required this.comment, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: const Color.fromARGB(255, 33, 31, 38),
          ),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: const Color.fromARGB(255, 87, 87, 87),
                  ),
                  child: const Icon(Icons.person,)),
              const SizedBox(
                width: 10,
              ),
              Text(
                comment?.title ?? "No comment",
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )),
        const SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: const Color.fromARGB(255, 33, 31, 38)),
          child: IconButton(
            icon: const Icon(Icons.comment),
            onPressed: ()=>callback(),
          ),
        )
      ],
    );
  }
}
