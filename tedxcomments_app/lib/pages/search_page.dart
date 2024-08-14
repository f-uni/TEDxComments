import 'package:flutter/material.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// class GenerateTalks extends StatelessWidget {
//   const GenerateTalks({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> textBlocks = [];
//     int i = 0;

//     while (i < 5) {
//       // Adjust the condition as needed
//       textBlocks.add(Text('Text block $i'));
//       i++;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter While Loop Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: textBlocks,
//         ),
//       ),
//     );
//   }
// }

Widget generateText() {
  List<Widget> textWidgets = [];

  for (int i = 1; i <= 9; i++) {
    textWidgets.add(Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          const Icon(Icons.history),
          const Padding(padding: EdgeInsets.only(left: 7)),
          Text("Ted Talk #$i"),
          //   generateText(),
        ],
      ),
    ));
  }

  return Column(
    children: textWidgets,
  );
}

class _SearchPageState extends State<SearchPage> {
  final _commentFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const CustomNavigationBar(page: 1),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    labelText: "Search"),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: generateText()),
            FloatingActionButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContextm) =>
                      _commentPopUp(context, _commentFormKey));
            })
          ],
        ));
  }
}

Widget _commentPopUp(BuildContext context, commentFormKey) {
  return AlertDialog(
    title: const Text("New Comment"),
    content: SingleChildScrollView(
      child: Form(
          key: commentFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Comment can't be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Body"),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Comment can't be empty";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  SizedBox(
                      width: 30,
                      child: TextFormField(
                          decoration: InputDecoration(hintText: "min"),
                          keyboardType: TextInputType.number)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(":",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                      width: 30,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "sec"),
                      )),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              OutlinedButton(
                  onPressed: () {
                    // if(commentFormKey.currontState.validate())
                  },
                  child: const Text("Insert"))
            ],
          )),
    ),
  );
}
