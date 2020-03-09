import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';

class ViewListEmpregosItem extends StatelessWidget {
  const ViewListEmpregosItem({
    @required this.emprego,
    @required this.onPressed,
    @required this.onDelete,
    Key key,
  }) : super(key: key);

  final Empregos emprego;
  final Function(Empregos emprego, GlobalKey itemKey) onPressed;
  final Function(Empregos emprego) onDelete;

  @override
  Widget build(BuildContext context) {
    final itemKey = GlobalKey();
    return ListTile(
      key: itemKey,
      leading: Icon(Icons.work),
      title: Text(emprego.nome),
      subtitle: Text("${emprego.carga_horaria} | ${emprego.saida} | ${emprego.fechamento}"),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => onDelete(emprego),
      ),
      onTap: () => onPressed(emprego, itemKey),      
    );
  }
}