class CategoriesModel {
  final List<String> items;

  CategoriesModel({required this.items});

  factory CategoriesModel.fromJson(List<String> list) {
    return CategoriesModel(items: list);
  }
}

