extension StringExtension on String {
  String capitalize() {
    if (this != "") {
      return "${this[0].toUpperCase()}${substring(1)}";
    } else {
      return this;
    }
  }

  String titleCapitalize() =>
      replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalize()).join(" ");
}