// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListNoResultsFound extends StatelessWidget {
  final String labelText;
  final Color color;


  const ListNoResultsFound({
    Key? key,
    required this.labelText,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          color: color,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            labelText,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
