class SearchUtil {
  static List<Map<String, String>> searchItems(
      List<Map<String, String>> items,
      String query,
      ) {
    return items
        .where((item) =>
    item['name']!.toLowerCase().contains(query.toLowerCase()) )
        .toList();
  }
}
