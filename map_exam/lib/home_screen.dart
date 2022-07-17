import 'package:flutter/material.dart';
import 'package:map_exam/edit_screen.dart';
import 'package:map_exam/note_notifier.dart';
import 'package:provider/provider.dart';

import 'api.dart';
import 'note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.email=''}) : super(key: key);
  final String email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  bool _isVisible=true;
  bool _isVisible1=true;
  bool _isVisible2=true;

  @override
  void initState(){
    NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: false);
    getNote(noteNotifier,widget.email);
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
  void showSubtitle() {
  setState(() {
    _isVisible = !_isVisible;
  }
  );
  
  }
  Future deleteNote(Note currentNote) async {
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context, listen: false);
    await deleteCurrentNote(currentNote);
    getNote(noteNotifier,widget.email);
  }

  void showIcon() {
  setState(() {
    _isVisible1 = !_isVisible1;
  }
  );
  
  }
  void showBothIcon() {
  setState(() {
    _isVisible2 = !_isVisible2;
  }
  );
  
  }

  @override
  Widget build(BuildContext context) {
    NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: false);
        //Note currentNote = noteNotifier.currentNote;
  

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
      body: ListView.separated(
        itemCount: noteNotifier.noteList.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) => ListTile(
          trailing: SizedBox(
            width: 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ Visibility(
                visible: _isVisible2,
                child: 
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(nid: noteNotifier.noteList[index].id.toString(), email: widget.email, option:'EDIT')));
                  },
                ),),
                Visibility(
                visible: _isVisible2,
                child:
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    // deleteNote(currentNote).then((value) =>{
                    //   Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()))
                    // } );
                  },
                ),)
                
              ],
            ),
          ),
          title:  Text('${noteNotifier.noteList[index].title}'),
          subtitle:Visibility(
                visible: _isVisible,
                child: Text('${noteNotifier.noteList[index].content}')
                ),
          onTap: () {},
          onLongPress: () {
            showBothIcon();
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: _isVisible1==true? Icon(Icons.arrow_drop_up):Icon(Icons.menu),
              tooltip: 'Show less. Hide notes content',
              onPressed: () {
                  showSubtitle();
                  showIcon();
              }),

          /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(nid: '', email: widget.email, option:'ADD')));
            },
          ),
        ],
      ),
    );
  }
}
