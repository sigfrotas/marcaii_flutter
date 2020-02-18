import 'package:flutter/material.dart';

class CalendarioHeaderItem extends StatelessWidget {
  const CalendarioHeaderItem({
    @required this.weekDay,
    Key key,
  }) : super(key: key);
  final String weekDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        weekDay,
        style: const TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}