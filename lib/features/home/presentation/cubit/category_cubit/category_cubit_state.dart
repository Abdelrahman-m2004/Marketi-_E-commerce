import 'package:flutter/material.dart';




import 'package:marketi/features/home/data/models/category_model.dart';


@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class categoryLoading extends CategoryState {}

final class categoryloaded extends CategoryState {
  final List<CategoryModel> categories;

  categoryloaded(this.categories);
}

final class categoryErorr extends CategoryState {
  final String massage;

  categoryErorr(this.massage);
}