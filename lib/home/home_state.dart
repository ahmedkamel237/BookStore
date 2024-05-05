
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeSuccess({required this.categoryNames});

  final List<String> categoryNames;
}

class HomeError extends HomeState {
  HomeError({required this.errorMessage});


  final String errorMessage;
}
