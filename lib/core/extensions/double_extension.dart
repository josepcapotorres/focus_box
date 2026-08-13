extension DoubleExtension on double {
  String formatDouble() {
    return toStringAsFixed(
      1,
    ).replaceAll(RegExp(r'(\.\d*?)0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
