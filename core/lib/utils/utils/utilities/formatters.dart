import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Utility functions for formatting data
class Formatters {
  /// Private constructor to prevent instantiation
  Formatters._();

  /// Formats a phone number to a readable format
  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 3)} '
          '${cleaned.substring(3, 6)} '
          '${cleaned.substring(6)}';
    } else if (cleaned.length == 12 && cleaned.startsWith('91')) {
      return '+91 ${cleaned.substring(2, 5)} '
          '${cleaned.substring(5, 8)} '
          '${cleaned.substring(8)}';
    }
    return phone;
  }

  /// Formats an Indian phone number with +91 prefix
  static String formatIndianPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length == 10) {
      return '+91 $cleaned';
    } else if (cleaned.length == 12 && cleaned.startsWith('91')) {
      return '+91 ${cleaned.substring(2)}';
    }
    return phone;
  }

  /// Formats a date to a readable string
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return format
        .replaceAll('dd', day)
        .replaceAll('MM', month)
        .replaceAll('yyyy', year);
  }

  /// Formats a DateTime to a time string
  static String formatTime(DateTime time, {bool use24HourFormat = false}) {
    final hour = use24HourFormat
        ? time.hour
        : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = use24HourFormat ? '' : (time.hour >= 12 ? ' PM' : ' AM');
    return '$hour:$minute$period';
  }

  /// Formats a date-time to a full timestamp
  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} ${formatTime(dateTime)}';
  }

  /// Formats a number with commas as thousand separators
  static String formatNumber(num number, {int decimalPlaces = 0}) {
    if (decimalPlaces > 0) {
      return number
          .toStringAsFixed(decimalPlaces)
          .replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (match) => '${match.group(1)},',
          );
    }
    return number.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }

  /// Formats currency (Indian Rupees)
  static String formatCurrency(num amount, {int decimalPlaces = 2}) {
    final formatted = formatNumber(amount, decimalPlaces: decimalPlaces);
    return '₹$formatted';
  }

  /// Formats percentage
  static String formatPercentage(double value, {int decimalPlaces = 1}) {
    return '${value.toStringAsFixed(decimalPlaces)}%';
  }

  /// Formats a duration to a readable string (e.g., \"2h 30m\")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 && hours == 0) parts.add('${seconds}s');

    return parts.join(' ');
  }

  /// Formats file size in human readable format
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = bytes.toDouble();
    var suffixIndex = 0;

    while (size >= 1024 && suffixIndex < suffixes.length - 1) {
      size /= 1024;
      suffixIndex++;
    }

    final fixed = size.toStringAsFixed(suffixIndex == 0 ? 0 : 2);
    return '$fixed ${suffixes[suffixIndex]}';
  }

  /// Formats a name with proper capitalization
  static String formatName(String name) {
    return name.split(' ').map((word) => word.capitalize).join(' ');
  }
}
