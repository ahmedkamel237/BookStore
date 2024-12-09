import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/admin/domain/repository/admin_repository.dart';
import 'package:store_app/common/constants/app_constants.dart';
import 'package:store_app/home/domain/models/categoriey_model_input.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl();

  final CollectionReference _categories =
      FirebaseFirestore.instance.collection(AppConstants.collectionName);

  @override
  Future<void> addCollection(CategoriesModelInput input) async {
    await _categories
        .add({
          'name': input.name,
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
