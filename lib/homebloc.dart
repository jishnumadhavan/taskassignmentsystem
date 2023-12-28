
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCreation extends Cubit<List<Map<String, dynamic>>> {
  TaskCreation() : super([]);
  
  List tasks=[];
  int id=1;
  int pendingtasks=0;
  List taskcategory=[
    {
      "name": "IT",
      "icon": "assets/taskicons/app-development.png"
    },
    {
      "name": "Accounts",
      "icon": "assets/taskicons/accounting.png"
    },
    {
      "name": "Sales",
      "icon": "assets/taskicons/sales.png"
    }
  ];
  List Duration=[
    "1 hours", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours", "7 hours", "8 hours"
  ];

  addtask(var name, description, employee, category, duration ){
    print("task name is: $name");
    print("task desc is: $description");
    print("assigned employee name is: $employee");

    //adding task details to a list
    tasks.add({
      "taskid": id,
      "taskcategory": category.toString(),
      "taskduration":  duration.toString(),
      "taskicon": category == "Accounts"? "assets/taskicons/accounting.png" :  category == "Sales"? "assets/taskicons/sales.png" : "assets/taskicons/app-development.png",
      "createdat": DateTime.now(),
      "taskname": name,
      "description": description,
      "assignemployee": employee == null ? "Employee 1" :employee,
      "status": "Pending"
    });

    emit(List.from(tasks));
    id++; // id auto increment

    print("all task is ${tasks.length}");
    print("all task is ${tasks}");


  }
}