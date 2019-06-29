class Item {
  final String plan;
  final String name;
  final String date;

  Item({this.plan, this.name, this.date});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      plan: json["item_food_plan"],
      name: json["item_name"],
      date: json["item_date"],
    );
  }
}

class ItemsList {
  final List<Item> items;

  ItemsList({
    this.items,
  });

  factory ItemsList.fromJson(List<dynamic> parsedJson) {
    List<Item> items = new List<Item>();
    items = parsedJson.map((i) => Item.fromJson(i)).toList();

    return new ItemsList(
      items: items,
    );
  }
}
