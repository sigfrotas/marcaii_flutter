import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/form_view.dart';
import 'package:marcaii_flutter/src/views/widgets/appbar_save_button.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/banco_horas_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/carga_horaria_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/emprego_ativo_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/fechamento_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/horas_saida_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_diferenciadas.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/nome_emprego_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/porcentagens/porcentagens.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salario_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salarios_list_tile/salarios_list_tile.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewEmpregos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Empregos emprego = ModalRoute.of(context).settings.arguments;
    return Provider<BlocEmprego>(
      create: (_) => BlocEmprego(
        emprego: emprego,
      ),
      dispose: (_, b) => b.dispose(),
      child: _ViewEmpregos(),
    );
  }
}

class _ViewEmpregos extends StatefulWidget {
  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<_ViewEmpregos> with WillPopForm {
  GlobalKey<FormState> _formKey;
  BlocEmprego blocEmpregos;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blocEmpregos = Provider.of<BlocEmprego>(context);

    return WillPopScope(
      onWillPop: () => willPop(
        context: context,
        formState: _formKey.currentState,
        hasChanged: blocEmpregos.didChange(),
        isCreating: blocEmpregos.isCreating,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text(Strings.empregos),
          actions: <Widget>[
            AppbarSaveButton(
              // onPressed: doSave,
              onPressed: () {
                final result = blocEmpregos.provideResult();
                result.salarios.forEach(print);
                doSave(
                  context: context,
                  formState: _formKey.currentState,
                  resultData: result,
                );
              },
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const NomeEmpregoTile(),
              const Divider(indent: 16, endIndent: 16),
              const ViewPorcentagens(),
              const Divider(indent: 16, endIndent: 16),
              const CargaHorariaTile(),
              const Divider(indent: 16, endIndent: 16),
              const FechamentoTile(),
              const _ItemDivider(),
              const HorarioSaidaTile(),
              const _ItemDivider(),
              const EmpregoAtivoTile(),
              const _ItemDivider(),
              const BancoHorasTile(),
              const Divider(indent: 16, endIndent: 16),
              blocEmpregos.isCreating ? SalarioTile() : const SalariosListTile(),
              const ListDiferenciadas(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemDivider extends StatelessWidget {
  const _ItemDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(indent: 64, endIndent: 16);
  }
}
