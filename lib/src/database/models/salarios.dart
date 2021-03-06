import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:marcaii_flutter/src/database/models/model.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';

part 'salarios.g.dart';

@immutable
@JsonSerializable(nullable: true)
class Salarios implements Model<Salarios> {
  const Salarios({
    this.id,
    this.emprego_id,
    this.valor,
    this.vigencia,
    this.ativo,
  });

  final int id, emprego_id;
  final double valor;
  final String vigencia;
  @JsonKey(toJson: boolToInt, fromJson: intToBool)
  final bool ativo;

  static const String ID = "id";
  static const String EMPREGO_ID = "emprego_id";
  static const String VALOR = "valor";
  static const String VIGENCIA = "vigencia";
  static const String ATIVO = "ativo";

  Salarios copyWith({
    int id,
    int emprego_id,
    double valor = 900,
    String vigencia = "01/2020",
    bool ativo = true,
  }) {
    return Salarios(
      id: id ?? this.id,
      emprego_id: emprego_id ?? this.emprego_id,
      valor: valor ?? this.valor,
      vigencia: vigencia ?? this.vigencia,
      ativo: ativo ?? this.ativo,
    );
  }

  /// Vigencia é a data inicial a qual um salário se torna válido
  /// Supondo que o fechamento do mês é dia 25, e houve um aumento de salário no mês de maio,
  /// a vigencia desse novo salário é a partir 26/04/ano
  DateTime vigenciaAsDate(int fechamento) {
    final splitVigencia = vigencia.split("/").map(int.parse).toList();
    final dt = DateTime(splitVigencia[1], fechamento + 1, splitVigencia[0]);
    return Jiffy(dt).subtract(months: 1);
  }

  ///Retorna valor do salário formatado
  String valorAsString() {
    return NumberFormat.simpleCurrency(locale: "pt_Br").format(this.valor);
  }

  static const String tableName = "salarios";

  static const List<String> columns = [ID, EMPREGO_ID, VALOR, VIGENCIA, ATIVO];

  @override
  String get createSQL {
    return SqliteTable(tableName, columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      EMPREGO_ID: SqliteColumn(ColumnTypes.INTEGER),
      VALOR: SqliteColumn(ColumnTypes.REAL),
      VIGENCIA: SqliteColumn(ColumnTypes.TEXT),
      ATIVO: SqliteColumn(ColumnTypes.INTEGER),
    }).generateCreateQuery();
  }

  static Salarios fromJson(Map<String, Object> json) {
    return _$SalariosFromJson(json);
  }

  Map<String, Object> toJson() {
    return _$SalariosToJson(this);
  }
}
