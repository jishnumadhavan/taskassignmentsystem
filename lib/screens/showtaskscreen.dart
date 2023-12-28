import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cutsomminibox.dart';
import '../elements.dart';
import '../homebloc.dart';
import 'formscreen.dart';

class ShowTaskScreen extends StatefulWidget {
  @override
  State<ShowTaskScreen> createState() => _ShowTaskScreenState();
}

class _ShowTaskScreenState extends State<ShowTaskScreen> {

  String greeting="";

  @override
  void initState() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

     greeting = (currentHour >= 6 && currentHour < 12) ? 'Morning' : 'Evening';
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF161A30),
          title: const Text('Show Tasks'),
          centerTitle: true,
        ),
        body: BlocBuilder<TaskCreation, List<Map<String, dynamic>>>(
          builder: (context, count) => Center(
              child: Column(
            children: [

              Container(
                padding: EdgeInsets.only(left: 10,),
                height: 140,
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                    color: boxcolor,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                          color: shadowcolor.withOpacity(.1),
                          offset: Offset(0, 2),
                          blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Good $greeting Welcome Back",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomBoxShape(
                          label: 'Total Tasks',
                          value:
                              context.read<TaskCreation>().tasks.length.toString(),
                        ),
                        CustomBoxShape(
                          label: 'Completed Tasks',
                          value: '0',
                        ),
                        CustomBoxShape(
                          label: 'Pending Tasks',
                          value:
                              context.read<TaskCreation>().tasks.length.toString(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF161A30)
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormScreen();
                    }),);
                },
                child: Text("Add Task"),
              ),
              context.read<TaskCreation>().tasks.isNotEmpty ?
              Container(
                height: MediaQuery.of(context).size.height * .64,
                child: ListView.builder(

                  itemBuilder: (context, index) {
                    //formated dateTime here to display wisely
                    String taskcreateddate = DateFormat('dd MMM yyyy hh:mm a').format(context.read<TaskCreation>().tasks[index]['createdat']);
                    //sorted the list here so the last task will be show up at first
                    context.read<TaskCreation>().tasks.sort((a, b) => DateTime.parse(b["createdat"].toString()).compareTo(DateTime.parse(a["createdat"].toString())));

                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 5),
                      // height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: shadowcolor.withOpacity(.1),
                                offset: Offset(0, 2),
                                blurRadius: 2)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            context.read<TaskCreation>().tasks[index]
                                ['taskicon'],
                            width: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 190,
                                margin: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.read<TaskCreation>().tasks[index]
                                          ['taskname'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      context.read<TaskCreation>().tasks[index]
                                          ['description'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      taskcreateddate.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.read<TaskCreation>().tasks[index]
                                        ['assignemployee'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      context.read<TaskCreation>().tasks[index]
                                          ['status'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    // height: 70,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: context
                                                      .read<TaskCreation>()
                                                      .tasks[index]
                                                  ['status'] ==
                                              "Pending"
                                          ? Colors.orange
                                          : Colors.green,
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: context.read<TaskCreation>().tasks.length,
                ),
              )
                  : Container(
                  margin: EdgeInsets.only(top: 100),
                  child: const Text("Opps no data to show")),

            ],
          )),
        ),
      ),
    );
  }
}
