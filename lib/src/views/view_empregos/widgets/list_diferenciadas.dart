import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/views/shared/list_separator.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ListDiferenciadas extends StatelessWidget {
  const ListDiferenciadas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);

    return MergedStreamObserver(
      streams: [b.bancoHoras, b.outDiferenciadas],
      onSuccess: (_, List<Object> streamResult) {
        final bancoHoras = streamResult[0] as bool;
        final List<Diferenciadas> diferenciadas = streamResult[1] as List<Diferenciadas>;
        if (!bancoHoras) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListSeparator(label: Strings.diferenciadas),
              for (Diferenciadas dif in diferenciadas)
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.calendar_plus_o,
                    color: Consts.weekdayColors[dif.weekday],
                  ),
                  title: Text(Consts.weekDayExtenso[dif.weekday]),
                  subtitle: Text( dif.porc != 0 ? "${dif.porc} %" : "-"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final bool r = await showConfirmationDialog(
                        context: context,
                        message: "Deseja remover o valor diferencial?",
                        negativeCaption: Strings.cancelar,
                        positiveCaption: Strings.remover,
                      );

                      if (r != null && r) {
                        b.setDiferenciada(dif, 0);
                      }
                    },
                  ),
                  onTap: () async {
                    final int result = await showIntegerPickerDialog(
                      context: context,
                      label: Strings.porcDifer,
                      title: Consts.weekDayExtenso[dif.weekday],
                      confirmButton: Strings.salvar,
                      initValue: dif.porc,
                    );

                    if (result != null && result is int) {
                      b.setDiferenciada(dif, result);
                    }
                  },
                ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
