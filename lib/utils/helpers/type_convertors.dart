int? convertToInt(dynamic valArg, {int defValue = 0}) {
  if (valArg == null) return null;

  if (valArg is int) return valArg;
  if (valArg is double) return valArg.toInt();
  if (valArg is String) {
    if (valArg.isEmpty) return null;
    return int.tryParse(valArg) ?? defValue;
  }

  return null;
}

double? convertToDouble(dynamic valArg, {double defValue = 0.0}) {
  if (valArg == null) return null;

  if (valArg is double) return valArg;
  if (valArg is int) return valArg.toDouble();
  if (valArg is String) {
    if (valArg.isEmpty) return null;
    return double.tryParse(valArg) ?? defValue;
  }

  return null;
}

String? convertToString(dynamic valArg) {
  if (valArg == null) return null;

  if (valArg is String) {
    final trimmed = valArg.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'null') return null;
    return trimmed;
  }

  try {
    final str = valArg.toString().trim();
    return str.toLowerCase() == 'null' ? null : str;
  } catch (_) {
    return null;
  }
}

bool? convertToBool(dynamic val) {
  if (val == null) return null;
  if (val is bool) return val;
  if (val is String) return val.toLowerCase() == 'true';
  if (val is num) return val != 0;
  return null;
}

Map<String, dynamic> convertToMap(dynamic valArg) {
  if (valArg is Map<String, dynamic>) return valArg;
  if (valArg is Map) {
    try {
      return valArg.map((key, value) => MapEntry(key.toString(), value));
    } catch (_) {
      return {};
    }
  }
  return {};
}

List<T> convertToList<T>(dynamic valArg) {
  if (valArg is List) {
    try {
      return valArg.cast<T>();
    } catch (_) {
      return [];
    }
  }
  return [];
}
