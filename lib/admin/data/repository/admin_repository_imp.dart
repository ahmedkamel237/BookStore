import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stor_app/admin/domain/repository/admin_repository.dart';
import 'package:stor_app/common/constants/app_constants.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl();

  final CollectionReference _categories =
      FirebaseFirestore.instance.collection(AppConstants.collectionName);

  @override
  Future<void> addCollection(String collectionName) async {
    await _categories
        .add({
          'name': collectionName,
        })
        .then((value) => print('$value added successfully'))
        .catchError(
          (error) => print('Failed to add collection: $error'),
        );
  }

    // TODO: implement fetchCategories not completed
  @override
  Future<List<String>> fetchCategories() async {
    final result = await _categories
        .get();
    return result.docs.map((e) => e['name'].toString()).toList();
  }
}
