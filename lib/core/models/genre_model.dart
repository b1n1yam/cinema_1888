class GenreModel {
  List<GenreResult> results = [];

  GenreModel.fromJson(Map<String, dynamic> parsedJson) {
    List<GenreResult> temp = [];
    for (var i = 0; i < parsedJson['genres'].length; i++) {
      GenreResult result = GenreResult(parsedJson['genres'][i]);
      temp.add(result);
    }
    temp = temp.toSet().toList();
    results = temp;
  }
  List<GenreResult> get get_results => results;
  String getGenre(List<int> ids) {
    ids = ids.toSet().toList();
    String mygenre = "";
    for (var i = 0; i < ids.length; i++) {
      mygenre += results.where((user) => user.id == ids[i]).first.name + ", ";
    }
    mygenre = mygenre.substring(0, mygenre.length - 2);
    return mygenre;
  }
}

class GenreResult {
  int id;
  String name;
  GenreResult(result) {
    id = result['id'];
    name = result['name'].toString();
  }
  String get get_name => name;
  int get get_id => id;
}
