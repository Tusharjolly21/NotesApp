import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  String des;
  bool edit = false;
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['descripption'];
    return SafeArea(
        child: Scaffold(
      floatingActionButton: edit
          ? FloatingActionButton(
              onPressed: () => save(),
              child: Icon(
                Icons.save_rounded,
                color: Colors.white70,
              ),
              backgroundColor: Colors.grey[700],
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple)),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        child: Icon(
                          Icons.edit,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[600])),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: delete,
                        child: Icon(Icons.delete),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[300])),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLines: 2,
                    decoration: InputDecoration.collapsed(hintText: "Title"),
                    style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    initialValue: widget.data['title'],
                    enabled: edit,
                    onChanged: (_val) {
                      title = _val;
                    },
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return 'Cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Text(
                      widget.time,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.grey),
                    ),
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration.collapsed(hintText: "Note description"),
                    style: TextStyle(
                        fontSize: 20.0, fontFamily: "lato", color: Colors.grey),
                    initialValue: widget.data['description'],
                    enabled: edit,
                    onChanged: (_val) {
                      des = _val;
                    },
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return 'Cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void delete() async {
    await widget.ref.delete();

    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}
