/// Utility functions for validation
class Validators {
  /// Private constructor to prevent instantiation
  Validators._();

  /// Validates an email address
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validates a phone number
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'\s'), ''));
  }

  /// Validates a password with minimum requirements
  /// At least 8 characters, 1 uppercase, 1 lowercase, 1 number
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp('[A-Z]'))) return false;
    if (!password.contains(RegExp('[a-z]'))) return false;
    if (!password.contains(RegExp('[0-9]'))) return false;
    return true;
  }

  /// Validates a URL
  static bool isValidUrl(String url) {
    if (url.isEmpty) return false;
    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return urlRegex.hasMatch(url);
  }

  /// Validates a numeric string
  static bool isNumeric(String str) {
    if (str.isEmpty) return false;
    return double.tryParse(str) != null;
  }

  /// Validates an integer string
  static bool isInteger(String str) {
    if (str.isEmpty) return false;
    return int.tryParse(str) != null;
  }

  /// Validates a required field (non-empty)
  static bool isRequired(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validates minimum length
  static bool hasMinLength(String value, int minLength) {
    return value.length >= minLength;
  }

  /// Validates maximum length
  static bool hasMaxLength(String value, int maxLength) {
    return value.length <= maxLength;
  }

  /// Validates that a value is within a range
  static bool isInRange(num value, num min, num max) {
    return value >= min && value <= max;
  }

  /// Validates that two values match (e.g., password confirmation)
  static bool doMatch(String value1, String value2) {
    return value1 == value2;
  }

  /// Validates an Indian phone number specifically
  static bool isValidIndianPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s'), '');
    // +91 prefix or 0 prefix for Indian numbers
    final regex = RegExp(r'^(\+91|0)?[6-9]\d{9}$');
    return regex.hasMatch(cleaned);
  }

  /// Validates a PIN code (6 digits)
  static bool isValidPin(String pin) {
    return pin.length == 6 && isInteger(pin);
  }

  /// Validates an Aadhaar number (12 digits)
  static bool isValidAadhaar(String aadhaar) {
    final cleaned = aadhaar.replaceAll(RegExp(r'\s'), '');
    return cleaned.length == 12 && isInteger(cleaned);
  }
}
