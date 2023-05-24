import '../presentation/model/category.dart';
import '../presentation/model/facility.dart';
import 'property_client.dart';

abstract class PropertyRepositoryAPI {
  Future<Category> getCategories();
  Future<Facility> getFacilities();
}

class PropertyRepositoryImpl implements PropertyRepositoryAPI {
  final PropertyClientAPI client;

  PropertyRepositoryImpl(this.client);

  @override
  Future<Category> getCategories() async {
    final response = await client.getCategories();
    return Category.fromJson(response.data);
  }

  @override
  Future<Facility> getFacilities() async {
    final response = await client.getFacilities();
    return Facility.fromJson(response.data);
  }
}
