import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../other/elements.dart';
import '../homebloc.dart';

class FormScreen extends StatefulWidget {

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var selectedValue="Employee 1";
  var tasknameController= TextEditingController();
  var taskdescriptionController= TextEditingController();
  var assignedEmployee;
  var category;
  int selectedCategoryIndex = -1;
  int selectedDurationIndex = -1;
  var selectedDuration;
  var selectedCategory;
  var duration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor:  Color(0xFF161A30),
          title: const Text('Task Assignment System'),
          centerTitle: true,
        ),
        body: BlocBuilder<TaskCreation, List<Map<String, dynamic>>>(
          builder: (context, count) => Center(child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: tasknameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Task name can't be empty";
                    }
                  },
                  decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                    hintText: "Task Name"
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: taskdescriptionController,
                  minLines: 2,
                  maxLines: 6,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 12), // Adjust the top padding value
                    hintText: "Task Description",
                    border: OutlineInputBorder(),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: DropdownButton<String>(
                  value: selectedValue,
                  onChanged: ( newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      assignedEmployee= newValue!;
                    });
                  },
                  items: <String>['Employee 1', 'Employee 2', 'Employee 3', 'Employee 4']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        selectedDuration= context.read<TaskCreation>().Duration[index];
                        setState(() {
                          selectedDurationIndex =
                          selectedDurationIndex == index ? -1 : index;
                        });

                      },
                      child: Container(
                        // height: 40,
                        padding: EdgeInsets.all(7),
                        margin: EdgeInsets.only(left: 10,bottom: 5),
                        decoration: BoxDecoration(
                            color: selectedDurationIndex == index ? Color(0xFF31304D) : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: shadowcolor.withOpacity(.1),
                                  offset: Offset(0,2),
                                  blurRadius: 2
                              )
                            ]
                        ),
                        child: Row(
                          children: [
                            Text(context.read<TaskCreation>().Duration[index],
                              style: TextStyle(
                                  color: selectedDurationIndex != index ? Color(0xFF31304D) : Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            )

                          ],
                        ),

                      ),
                    );
                  },
                  itemCount: context.read<TaskCreation>().Duration.length,
                ),),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                // width: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    selectedCategory= context.read<TaskCreation>().taskcategory[index]['name'];
                    setState(() {
                      selectedCategoryIndex =
                      selectedCategoryIndex == index ? -1 : index;
                    });

                  },
                  child: Container(
                    // height: 40,
                    padding: EdgeInsets.all(7),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: selectedCategoryIndex == index ? Color(0xFF31304D) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: shadowcolor.withOpacity(.1),
                              offset: Offset(0,2),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Row(
                      children: [
                        Image.asset(context.read<TaskCreation>().taskcategory[index]['icon'],
                        width: 40,
                        ),
                        SizedBox(width: 10),
                        Text(context.read<TaskCreation>().taskcategory[index]['name'],
                        style: TextStyle(
                          color: selectedCategoryIndex != index ? Color(0xFF31304D) : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                        ),
                        )

                      ],
                    ),

                  ),
                );
              },
                itemCount: context.read<TaskCreation>().taskcategory.length,
                ),),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttoncolor
                  ),
                  onPressed: (){
                //calling the function here to add task
                if(tasknameController.text.isNotEmpty) {
                  context.read<TaskCreation>().addtask(tasknameController.text,
                      taskdescriptionController.text,
                      selectedValue, selectedCategory, duration);


                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Task Added'),
                        content: Text('The task was successfully added'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
                else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Provide Task Name'),
                        content: Text("The task name can not be empty"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
                  child: Text("Create a Task")),
            ],
          )),
        ),
      ),
    );
  }
}
