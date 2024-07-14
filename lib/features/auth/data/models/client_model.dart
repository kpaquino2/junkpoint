import 'package:junkpoint/features/auth/domain/entities/Client.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.points,
    required super.address,
    required super.name,
  });
}
