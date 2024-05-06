import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stor_app/admin/domain/repository/admin_repository.dart';
import 'package:stor_app/common/constants/app_constants.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl();

  final CollectionReference _categories =
      FirebaseFirestore.instance.collection(AppConstants.collectionName);

  @override
  Future<void> addCollection(CategoriesModel model) async {
    await _categories
        .add({
          'name': model.name,
        })
        .then((value) => _categories.doc(value.id).update({
              'id': value.id,
            }))
        .catchError(
          (error) => print('Failed to add collection: $error'),
        );
  }

  @override
  Future<void> removeCollection(String id) async {
    await _categories.doc(id).delete();
  }

  // @override
  // Future<CategoriesModel> updateCollection(CategoriesModel model) async {
  //   final data = await _categories.doc(model.id).update(
  //     {
  //       'id': model.id,
  //       'image': model.image,
  //       'name': model.name,
  //     },
  //   );
  //
  //   return data;
  // }
}
