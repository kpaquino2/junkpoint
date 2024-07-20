import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/exceptions.dart';
import 'package:junkpoint/features/auth/data/models/client_model.dart';
import 'package:junkpoint/features/auth/data/models/shop_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<Either<ClientModel, ShopModel>> signUpWithEmailPassword({
    required String name,
    required String credential,
    required String password,
    required String role,
  });

  Future<Either<ClientModel, ShopModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<ClientModel, ShopModel>?> getCurrentUserData();

  Future<void> logOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<Either<ClientModel, ShopModel>> signUpWithEmailPassword({
    required String name,
    required String credential,
    required String password,
    required String role,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: credential.startsWith("+") ? null : credential,
        phone: credential.startsWith("+") ? credential : null,
        password: password,
        data: {
          'name': name,
          'role': role,
        },
      );

      if (response.user == null) {
        throw const ServerException("User is null!");
      }

      if (role == 'client') {
        return left(ClientModel.fromJSON(response.user!.toJson()));
      }
      return right(ShopModel.fromJSON(response.user!.toJson()));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Either<ClientModel, ShopModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException("User is null!");
      }

      final c = await supabaseClient
          .from("clients")
          .select('id, points, address, name')
          .eq('id', response.user!.id)
          .maybeSingle();

      if (c != null) {
        return left(ClientModel(
          id: response.user!.id,
          email: response.user!.id,
          points: c['points'],
          address: c['address'] ?? '',
          name: c['name'],
        ));
      }

      final s = await supabaseClient
          .from("shops")
          .select("id, address, name")
          .eq("id", response.user!.id)
          .maybeSingle();

      if (s != null) {
        return right(ShopModel(
          id: response.user!.id,
          email: response.user!.id,
          address: s['address'] ?? '',
          name: s['name'],
        ));
      }

      throw const ServerException('User is null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Either<ClientModel, ShopModel>?> getCurrentUserData() async {
    try {
      final userSession = currentUserSession;
      if (userSession == null) return null;
      final c = await supabaseClient
          .from("clients")
          .select('id, points, address, name')
          .eq('id', userSession.user.id)
          .maybeSingle();

      if (c != null) {
        return left(ClientModel(
          id: userSession.user.id,
          email: userSession.user.id,
          points: c['points'],
          address: c['address'] ?? '',
          name: c['name'],
        ));
      }

      final s = await supabaseClient
          .from("shops")
          .select("id, address, name")
          .eq("id", userSession.user.id)
          .maybeSingle();

      if (s != null) {
        return right(ShopModel(
          id: userSession.user.id,
          email: userSession.user.id,
          address: s['address'] ?? '',
          name: s['name'],
        ));
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      return await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
