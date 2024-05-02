import 'dart:convert';

class AddFoodModel {
  String name;
  String restaurantUID;
  String foodID;
  DateTime uploadTime;
  String description;
  String foodImageURL;
  bool isVegetarian;
  String price;
  AddFoodModel(
      {required this.name,
      required this.restaurantUID,
      required this.foodID,
      required this.uploadTime,
      required this.description,
      required this.foodImageURL,
      required this.isVegetarian,
      required this.price});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'restaurantUID': restaurantUID,
      'foodID': foodID,
      'uploadTime': uploadTime,
      'description': description,
      'foodImageURL': foodImageURL,
      'isVegetarian': isVegetarian,
      'price': price,
    };
  }

  factory AddFoodModel.fromMap(Map<String, dynamic> map) {
    return AddFoodModel(
      name: map['name'] != null ? map['name'] as String : '',
      restaurantUID:
          map['restaurantUID'] != null ? map['restaurantUID'] as String : '',
      foodID: map['foodID'] != null ? map['foodID'] as String : '',
      uploadTime: map['uploadTime'] != null
          ? DateTime.parse(map['uploadTime'] as String)
          : DateTime.now(),
      description:
          map['description'] != null ? map['description'] as String : '',
      foodImageURL:
          map['foodImageURL'] != null ? map['foodImageURL'] as String : '',
      isVegetarian:
          map['isVegetarian'] != null ? map['isVegetarian'] as bool : false,
      price: map['price'] != null ? map['price'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());
  factory AddFoodModel.fromJson(String source) =>
      AddFoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
