import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_state.dart';
import 'package:marketi/features/profile/domain/use_case/get_theme_use_case.dart';
import 'package:marketi/features/profile/domain/use_case/save_theme_use_case.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  final GetThemeUseCase _getThemeUseCase;
  final SaveThemeUseCase _saveThemeUseCase;
  ThemeCubit(this._getThemeUseCase, this._saveThemeUseCase)
    : super(ThemeState(ThemeMode.light)) {
    _loadTheme();
  }

  void _loadTheme() async {
    final isDark = await _getThemeUseCase.call();
    emit(ThemeState(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  void toggleTheme() async {
    final isDark = state.themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;

    emit(ThemeState(newMode));
    await _saveThemeUseCase.call(!isDark);
  }
}
