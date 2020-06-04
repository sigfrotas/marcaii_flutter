import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/branch_view/branch_view.dart';
import 'package:marcaii_flutter/strings.dart';

import 'src/views/view_empregos/view_empregos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final manager = Vault();
  final token = await manager.getToken();

  runApp(Marcaii(token: token));
}

class Marcaii extends StatelessWidget {
  const Marcaii({Key key, this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('pt', 'BR')],
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        fontFamily: "Montserrat",
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 2,
          brightness: Brightness.light,
          iconTheme: ThemeData.light().iconTheme,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.black45,
        ),
      ),
      routes: {
        Routes.routeEmpregos: (_) => ViewEmpregos(),
      },
      home: BranchView(token: token),
    );
  }
}

ThemeData customTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 2,
    brightness: Brightness.light,
    iconTheme: ThemeData.light().iconTheme,
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            color: Colors.black,
          ),
        ),
    // textTheme: customTheme.textTheme,
  ),
  primarySwatch: Colors.deepOrange,
  primaryColor: Colors.deepOrange,
  accentColor: Colors.deepPurple,
  fontFamily: "Montserrat",
);
