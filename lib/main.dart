import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: const MainApp()));
}

List<Task> tasks = [];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void initState() {
    super.initState();
  }

  bool ischucked = false;
  TextEditingController addtaskcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.white,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Add A New Task :',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextField(
                              controller: addtaskcontroller,
                              decoration: InputDecoration(
                                  hintText: 'Write your task here',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 78, 168, 243),
                                          width: 1)),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    tasks.add(
                                        Task(label: addtaskcontroller.text));
                                    addtaskcontroller.clear();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Add'))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 78, 168, 243),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 60),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.list),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 40, top: 10, bottom: 10),
                        child: Text(
                          'Todoey',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        child: Text(
                          'Make your day productive',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 10),
                        child: Text(
                          '${tasks.length} Tasks To Do',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Tasks :',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              tasks = [];
                            });
                          },
                          child: Text(
                            'clear',
                            style: TextStyle(fontSize: 15),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: tasks.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: tasks)
                      : Column(
                          children: [Text('You have not added any task yet')],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Task extends StatefulWidget {
  Task({required this.label});
  final String label;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ischecked ? Colors.black26 : Colors.black,
                decoration: ischecked ? TextDecoration.lineThrough : null),
          ),
          Checkbox(
              value: ischecked,
              onChanged: (newValue) {
                setState(() {
                  ischecked = newValue!;
                });
              }),
        ],
      ),
    );
  }
}
