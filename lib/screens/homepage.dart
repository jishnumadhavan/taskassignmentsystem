import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskassignmentsystem/screens/showtaskscreen.dart';

import '../homebloc.dart';
import 'formscreen.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Task Assignment System'),
        centerTitle: true,
        ),
        body: BlocBuilder<TaskCreation, List<Map<String, dynamic>>>(
          builder: (context, count) => Center(child: Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormScreen();
                    }),);
              },
                  child: Text("Create a Task")),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ShowTaskScreen();
                  }),);
              },
                  child: Text("Show Tasks"))
            ],
          )),
        ),
      ),
    );
  }
}
