// void userRegister({
//   required String name,
//   required String email,
//   required String password,
//   required String phone,
//   String? uId,
//   context
// })
// {
//   emit(SocialRegisterLoadingState());
//
//   FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: email,
//     password: password,
//
//   ).then((value)
//   {
//     userCreate(
//       email: email,
//       name: name,
//       phone: phone,
//       uId: value.user!.uid,
//     );
//     emit(SocialRegisterSuccesState());
//   }).catchError((e)
//   {
//     if (e.code == 'weak-password') {
//       AwesomeDialog(
//           context: context,
//           title: "Error",
//           body: Text("Password is to weak"))
//         ..show();
//     } else if (e.code == 'email-already-in-use') {
//       AwesomeDialog(
//           context: context,
//           title: "Error",
//           body: Text("The account already exists for that email"))
//         ..show();
//     }});
//
// }
//
// void userCreate({
//   required String email,
//   required String name,
//   required String phone,
//   required String uId,
// })
// {
//   SocialUserModel model=SocialUserModel(
//       username: name,
//       email: email,
//       phone: phone,
//       uId: uId,
//       bio: 'write your bio...',
//       cover: 'https://img.freepik.com/free-photo/photo-delighted-cheerful-afro-american-woman-with-crisp-hair-points-away-shows-blank-space-happy-advertise-item-sale-wears-orange-jumper-demonstrates-where-clothes-shop-situated_273609-26392.jpg?w=740&t=st=1666308935~exp=1666309535~hmac=14112bdae0f798397c8d2c56e30407fa4fe403e9580099acf12bc93c7754d807',
//       image: 'https://img.freepik.com/premium-photo/young-caucasian-man-isolated-blue-background-pointing-front-with-fingers_1187-239271.jpg?w=740'
//
//   );
//   FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
//   {
//     emit(SocialCreateUserSuccessState());
//   }).catchError((error)
//   {
//     emit(SocialCreateUserErrorState(error.toString()));
//   });
//   // 'email': email,
//   // 'username': name,
//   // 'uId': value.user!.uid,
//   // 'phone':phone,
//
// }
import 'package:equatable/equatable.dart';

class UserRegisterModelInput extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const UserRegisterModelInput({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}
