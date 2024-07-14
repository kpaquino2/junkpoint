import 'package:junkpoint/features/auth/domain/entities/shop.dart';

class ShopModel extends Shop {
  ShopModel({
    required super.id,
    required super.email,
    required super.address,
    required super.name,
  });

  factory ShopModel.fromJSON(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
