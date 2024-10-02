class ItemModel {
  final List<Item> items;
  ItemModel({required this.items});
  factory ItemModel.fromJson(List<dynamic> list) {
    return ItemModel(items: List<Item>.from(list.map((e) => Item.fromJson(e))));
  }
}

class Item {
  final int id;
  final String title;
  final num price;
  final String category;
  final String description;
  final String image;

  Item(
      {required this.id,
      required this.title,
      required this.price,
      required this.category,
      required this.description,
      required this.image});

  static const String idKey = "id";
  static const String titleKey = "title";
  static const String priceKey = "price";
  static const String categoryKey = "category";
  static const String descriptionKey = "description";
  static const String imageKey = "image";

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json[idKey],
        title: json[titleKey],
        price: json[priceKey],
        category: json[categoryKey],
        description: json[descriptionKey],
        image: json[imageKey]);
  }
}
