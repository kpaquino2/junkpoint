import 'package:junkpoint/core/common/entities/client.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.email,
    required super.points,
    required super.address,
    required super.name,
  });

  factory ClientModel.fromJSON(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      points: map['points'] ?? 0,
      address: map['address'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
