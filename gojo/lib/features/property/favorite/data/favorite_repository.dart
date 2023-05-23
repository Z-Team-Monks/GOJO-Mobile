import 'favorite_client_api.dart';

abstract class FavoritePropertyRepository {
  Future<void> favorProperty(String propertyId);
  Future<void> unfavorProperty(String propertyId);
}

class FavoritePropertyRepositoryImpl implements FavoritePropertyRepository {
  final FavoritePropertyClient favoritePropertyClient;

  FavoritePropertyRepositoryImpl(this.favoritePropertyClient);

  @override
  Future<void> favorProperty(String propertyId) async {
    await favoritePropertyClient.favorProperty(propertyId);
  }

  @override
  Future<void> unfavorProperty(String propertyId) async {
    await favoritePropertyClient.unfavorProperty(propertyId);
  }
}

class FavoritePropertyRepositoryFake implements FavoritePropertyRepository {
  FavoritePropertyRepositoryFake();

  @override
  Future<void> favorProperty(String propertyId) async {
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> unfavorProperty(String propertyId) async {
    Future.delayed(const Duration(seconds: 1));
  }
}
