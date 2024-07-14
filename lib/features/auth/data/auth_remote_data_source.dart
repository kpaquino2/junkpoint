import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/exceptions.dart';
import 'package:junkpoint/features/auth/data/models/client_model.dart';
import 'package:junkpoint/features/auth/data/models/shop_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<ClientModel, ShopModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String role,
  });

  Future<Either<ClientModel, ShopModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<Either<ClientModel, ShopModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'role': role,
        },
      );

      if (response.user == null) {
        throw const ServerException("User is null!");
      }

      if (role == 'client')
        return left(ClientModel.fromJSON(response.user!.toJson()));
      return right(ShopModel.fromJSON(response.user!.toJson()));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Either<ClientModel, ShopModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }
}
