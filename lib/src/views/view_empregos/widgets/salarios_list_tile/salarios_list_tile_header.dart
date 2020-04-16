import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_section_decorator.dart';
import 'package:marcaii_flutter/strings.dart';

class SalariosListTileHeader extends StatelessWidget {
  const SalariosListTileHeader({
    @required this.onAddTap,
    Key key,
  }) : super(key: key);
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 0),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListSectionDecorator(label: Strings.salarios),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: onAddTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
