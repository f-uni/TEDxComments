import 'package:flutter/material.dart';

class Tags extends StatefulWidget {
  const Tags(
      {super.key,
      required this.tags,
      required this.callback,
      required this.selectedTag});

  final List<String> tags;
  final Function callback;
  final int selectedTag;

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => widget.callback(index),
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromRGBO(147, 143, 153, 1),
                  width: index == widget.selectedTag ? 0 : 1,
                ),
                color: index == widget.selectedTag
                    ? const Color.fromARGB(255, 74, 68, 88)
                    : Colors.transparent,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Center(
                // Aggiunto Center per centrare il testo nel Container
                child: Text(
                  widget.tags[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromRGBO(202, 196, 208, 1),
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    letterSpacing: 0.1,
                    fontWeight: index == widget.selectedTag
                        ? FontWeight.bold
                        : FontWeight.normal,
                    height: 1.43,
                  ),
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 4,
        ),
        itemCount: widget.tags.length,
      ),
    );
  }
}
