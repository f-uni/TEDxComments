import 'package:flutter/material.dart';
import 'package:tedxcomments_app/models/talk.dart';
import 'package:tedxcomments_app/util/data_provider.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';
import 'package:tedxcomments_app/widgets/tags.dart';
import 'package:tedxcomments_app/widgets/talk_thumbnail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> tags;
  int selectedTag = 0;

  @override
  void initState() {
    tags = DataProvider.tags;
    tags.shuffle();
    tags = tags.take(20).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomNavigationBar(page: 0),
        body: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Tags(
                tags: tags,
                selectedTag: selectedTag,
                callback: (index) {
                  setState(() {
                    selectedTag = index;
                  });
                },
              ),
            ),
            FutureBuilder(
              future: DataProvider.getTalksByTag(tags[selectedTag], 1),
              builder: (context, snapshot) {
                // Controlla lo stato del Future
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(
                      'Errore: ${snapshot.error}'); 
                } else if (!snapshot.hasData) {
                  return const Text(
                      'Nessun dato disponibile');
                } else {
                  List<Talk> talks = snapshot.data!;
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => TalkThumbnail(
                              talk: talks[index],
                            ),
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                        itemCount: snapshot.data!.length),
                  );
                }
              },
            )
          ],
        ));
  }
}
