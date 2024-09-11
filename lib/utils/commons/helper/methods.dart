import 'package:intl/intl.dart';

extension StrExt on String {
  String rp() => double.tryParse(this) != null
      ? NumberFormat.currency(name: 'Rp. ', decimalDigits: 0, locale: 'id')
          .format(double.tryParse(this) ?? 0)
      : 'Rp. 0';

  String nominal() => double.tryParse(this) != null
      ? NumberFormat.currency(name: '', decimalDigits: 0, locale: 'id')
          .format(double.tryParse(this) ?? 0)
      : '0';

  String clearNom() =>
      replaceAll("Rp. ", "").replaceAll(".", "").replaceAll(",", "").trim();
}
