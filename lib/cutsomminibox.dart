import 'package:flutter/material.dart';

class CustomBoxShape extends StatelessWidget {
  final String label;
  final String value;

  CustomBoxShape({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color:label == "Completed Tasks"? Colors.green: label == "Pending Tasks"? Colors.orange:  Colors.white,
        // border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                color: label == "Completed Tasks" || label == "Pending Tasks" ? Colors.white:  Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                color: label == "Completed Tasks" || label == "Pending Tasks" ? Colors.white:  Colors.black87,
                fontSize: 20,
              fontWeight: FontWeight.w700
            ),
          ),
        ],
      ),
    );
  }
}