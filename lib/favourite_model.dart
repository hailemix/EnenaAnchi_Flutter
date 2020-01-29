import 'dart:convert';

FavouriteContent favouriteFromJson(String str) {
  final jsonData = json.decode(str);
  return FavouriteContent.fromMap(jsonData);
}

String favouriteToJson(FavouriteContent data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class FavouriteContent {
  int id;
  String favouriteContent;

  FavouriteContent({
    this.id,
    this.favouriteContent,
  });

  factory FavouriteContent.fromMap(Map<String, dynamic> json) =>
      FavouriteContent(
        id: json["id"],
        favouriteContent: json["favourite_content"],
      );

  Map<String, dynamic> toMap() =>
      {"id": id, "favourite_content": favouriteContent};
}
