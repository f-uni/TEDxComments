import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/util/data_provider.dart';
import 'package:tedxcomments_app/widgets/related_talk.dart';

class RelatedVideosList extends StatefulWidget {
  const RelatedVideosList({
    super.key,
    required this.talk,
  });

  final Talk talk;

  @override
  State<RelatedVideosList> createState() => _RelatedVideosListState();
}

class _RelatedVideosListState extends State<RelatedVideosList> {
  late Future<List<Talk>> realatedVideos;

  @override
  void initState() {
    super.initState();
    realatedVideos = DataProvider.getRelatedTalksById(widget.talk.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: realatedVideos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Errore: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('Nessun dato disponibile');
        } else {
          List<Talk> talks = snapshot.data!;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) => RelatedTalk(
                        talk: talks[index],
                      ),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Divider(
                          color: Colors.grey.shade700,
                        ),
                      ),
                  itemCount: snapshot.data!.length),
            ),
          );
        }
      },
    );
  }
}
