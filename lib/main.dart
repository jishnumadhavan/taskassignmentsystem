import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskassignmentsystem/screens/homepage.dart';
import 'package:taskassignmentsystem/screens/showtaskscreen.dart';

import 'homebloc.dart';

void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskCreationApp()));
}


class TaskCreationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      MultiBlocProvider(
          providers: [
      BlocProvider<TaskCreation>(
      create: (BuildContext context) => TaskCreation(),
    ),
      ],
        child: ShowTaskScreen(),
        // child: HomePage(),
      )

      // BlocProvider(
      //   create: (_) => CounterCubit(),
      //   child: HomePage(),
      // ),
    );
  }
}

