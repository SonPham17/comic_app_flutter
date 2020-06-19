
class Category{
  Category({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  static List<Category> parseCategoryList(map) {
    var list = map['categories'] as List;
    return list.map((category) => Category.fromJson(category)).toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}