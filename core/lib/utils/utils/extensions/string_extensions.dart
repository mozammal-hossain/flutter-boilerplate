/// Extension methods for [String] class
extension StringExtensions on String {
  /// Checks if the string is null or empty
  bool get isNullOrEmpty => trim().isEmpty;

  /// Checks if the string is not null or empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Capitalizes the first letter of the string
  String get capitalize {
    if (isNullOrEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts the string to title case
  String get titleCase {
    if (isNullOrEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Removes all whitespace from the string
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Truncates the string to a maximum length and adds ellipsis if needed
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  /// Validates if the string is a valid email
  bool get isValidEmail {
    if (isNullOrEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  /// Validates if the string is a valid phone number (basic)
  bool get isValidPhone {
    if (isNullOrEmpty) return false;
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    return phoneRegex.hasMatch(removeWhitespace);
  }

  /// Converts the string to camelCase
  String get toCamelCase {
    if (isNullOrEmpty) return this;
    final words = split(RegExp(r'[\s_\-]+'));
    return words
        .asMap()
        .map(
          (index, word) => MapEntry(
            index,
            index == 0 ? word.toLowerCase() : word.capitalize,
          ),
        )
        .values
        .join();
  }

  /// Converts the string to snake_case
  String get toSnakeCase {
    if (isNullOrEmpty) return this;
    return toCamelCase.replaceAllMapped(
      RegExp('[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
  }

  /// Extracts initials from a full name (e.g., "John Doe" -> "JD")
  String get initials {
    if (isNullOrEmpty) return '';
    return split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join();
  }

  /// Removes all HTML tags from the string
  String get stripHtml => replaceAll(RegExp('<[^>]*>'), '');

  /// Converts the string to a safe filename
  String get toSafeFilename {
    return replaceAll(RegExp(r'[^\w\.\-]'), '_');
  }
}
