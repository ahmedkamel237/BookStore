
abstract class AdminRepository {
  Future<void> addCollection(String collectionName);
  Future<List<String>> fetchCategories();
}
