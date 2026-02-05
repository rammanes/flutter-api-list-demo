/// Text formatting utilities.
extension TextFormatUtils on String {
  /// Returns this string with the first character in upper case.
  /// If the string is empty, returns it unchanged.
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns this string with the first letter of every word in upper case.
  /// If the string is empty, returns it unchanged.
  String toTitleCase() {
    if (isEmpty) return this;
    return split(RegExp(r'\s+'))
        .map((word) => word.isEmpty ? word : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }
}
