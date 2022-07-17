import 'package:flutter/material.dart';
import 'package:map_exam/note_notifier.dart';
import 'package:provider/provider.dart';

import 'api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());

  @override
  void initState(){
    NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: false);
    getNote(noteNotifier);
    super.initState();
  }

  List<String> getNoteList() {
    NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: false);
    List<String> noteList = [];
    for (int i = 0; i < noteNotifier.noteList.length; i++) {
      noteList.add(noteNotifier.noteList.toString());
    }
    return noteList;
  }

  @override
  Widget build(BuildContext context) {
    NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child:  Text(
              noteNotifier.noteList.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: FutureBuilder(
            future: getNoteFuture(noteNotifier),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return Consumer<NoteNotifier>(
                builder: (context, value, child) => ListView.separated(
                  itemCount: noteNotifier.noteList.length,
                  separatorBuilder: (context, index) => const Divider(
                  color: Colors.blueGrey,
                ),
                  child: noteNotifier.noteList
                  .map((e) => ListTile(
                    trailing: SizedBox(
                      width: 110.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    title: Text('${e.title}'),
                    subtitle: const Text('Note content'),
                    onTap: () {},
                    onLongPress: () {},
                  ),).toList(),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.menu),
              tooltip: 'Show less. Hide notes content',
              onPressed: () {}),

          /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
