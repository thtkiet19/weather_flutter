class CitiesService {
  static List<String> getSuggestions(String query, citiesdata) {
    assert(citiesdata != null);
    List<String> matches = <String>[];
    matches.addAll(citiesdata);
    print('${citiesdata[1]}');

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
