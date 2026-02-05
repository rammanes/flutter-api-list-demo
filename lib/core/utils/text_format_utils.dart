/// Text formatting utilities.
extension TextFormatUtils on String {
  /// Returns this string with the first character in upper case.
  /// If the string is empty, returns it unchanged.
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
