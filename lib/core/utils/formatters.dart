import 'package:intl/intl.dart';

class Formatters {

static String maskPhone(String phone) {
  if (phone.length < 6) return phone;

  final first = phone.substring(0, 4);
  final last = phone.substring(phone.length - 2);

  return "$first****$last";
}



  static DateTime? _parse(String? date) {
    if (date == null || date.isEmpty) return null;

    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  static String formatToDDMMYYYY(String? date) {
    final parsed = _parse(date);
    if (parsed == null) return "";

    return DateFormat("dd/MM/yyyy").format(parsed);
  }

  static String formatToReadable(String? date) {
    final parsed = _parse(date);
    if (parsed == null) return "";

    return DateFormat("dd MMM yyyy").format(parsed);
  }

  static bool isToday(String? date) {
    final parsed = _parse(date);
    if (parsed == null) return false;

    final now = DateTime.now();

    return parsed.year == now.year &&
        parsed.month == now.month &&
        parsed.day == now.day;
  }

  static bool isYesterday(String? date) {
    final parsed = _parse(date);
    if (parsed == null) return false;

    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    return parsed.year == yesterday.year &&
        parsed.month == yesterday.month &&
        parsed.day == yesterday.day;
  }

  static bool isThisWeek(String? date) {
    final parsed = _parse(date);
    if (parsed == null) return false;

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    return parsed.isAfter(startOfWeek) && parsed.isBefore(endOfWeek);
  }
}
