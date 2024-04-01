import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> mylist = ["name1", "name2", "name3"];
  List<bool> workDoneList = [false, false, false];
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }

  addNewtask(String newValue) {
    setState(() {
      if (newValue.isNotEmpty) {
        mylist.add(newValue);
        workDoneList.add(false);
      }
    });
    Navigator.pop(context);
  }

  newaddlist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add new Task"),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(labelText: "Task to complete"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                addNewtask(_textController.text);
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "ToDo List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: mylist.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        workDoneList[index] = !workDoneList[index];
                      });
                    },
                    icon: Icon(
                      Icons.done,
                      color: workDoneList[index] == true
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                  title: Text(
                    mylist[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: workDoneList[index] == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          mylist.removeAt(index);
                          workDoneList.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete)),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newaddlist,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
