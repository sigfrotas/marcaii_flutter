import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:provider/provider.dart';

class CalendarioNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          StreamObserver<String>(
            stream: b.outVigencia,
            onSuccess: (_, vig) => FlatButton.icon(
              icon: Icon(LineAwesomeIcons.calendar),
              label: Text(vig),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: b.decMes,
          ),
          IconButton(
            icon: Icon(LineAwesomeIcons.angle_right),
            onPressed: b.incMes,
          ),
        ],
      ),
    );
  }
}