import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/storage/secure_storage_datasource.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SecureStorageDataSource _storage;

  ThemeCubit({required SecureStorageDataSource storage})
      : _storage = storage,
        super(const ThemeState());

  Future<void> loadTheme() async {
    final savedTheme = await _storage.getThemeMode();
    if (savedTheme == 'light') {
      emit(state.copyWith(themeMode: ThemeMode.light));
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(state.copyWith(themeMode: newMode));
    await _storage.saveThemeMode(
      newMode == ThemeMode.light ? 'light' : 'dark',
    );
  }
}
