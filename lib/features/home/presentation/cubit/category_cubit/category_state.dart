import 'package:flutter/material.dart';




import 'package:marketi/features/home/data/models/category_model.dart';


@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class Categoryloaded extends CategoryState {
  final List<CategoryModel> categories;

  Categoryloaded(this.categories);
}

final class CategoryErorr extends CategoryState {
  final String massage;

  CategoryErorr(this.massage);
}