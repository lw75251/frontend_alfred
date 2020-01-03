class Category {
  final String title;
  final List<Item> items;

   Category({
    this.title,
    this.items
  });
}

class Item {
  final String name;
  final String image;
  final String description;
  final double price;

  const Item({
    this.name,
    this.image,
    this.description,
    this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json["name"],
      image: json["image"],
      description: json["description"],
      price: json["price"]
    );
  }
}