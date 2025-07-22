import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smca/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// firestore
  final FirestoreService firestoreService = FirestoreService();

// text controller to access what user typed in the box
  final TextEditingController textcontroller = TextEditingController();

// open a dialog box when plus button is clicked to add a note
  void openNoteBox(String? docID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textcontroller,
        ),
        actions: [
          // button to save
          ElevatedButton(
            onPressed: () {
              // add a new note
              if (docID == null) {
                firestoreService.addNote(textcontroller.text);
              }

              // update an existing note
              else {
                firestoreService.updateNote(
                  docID,
                  textcontroller.text,
                );
              }
              // clear the text controller
              textcontroller.clear();

              // close the box
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(null), // not same as in tutorial
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          // check if we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as a List
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // get note from each doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];
                // display as a list tile
                return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // update button
                        IconButton(
                          onPressed: () => openNoteBox(docID), // a little diff
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => firestoreService
                              .deleteNote(docID), // a little diff
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ));
              },
            );
          }

          // if there is no data return nothing
          else {
            return const Text('No notes...');
          }
        },
      ),
    );
  }
}
