import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/features/categories/models/category_model.dart';
import 'package:expense_manager/features/categories/repositories/category_local_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryLocalRepo repo = CategoryLocalRepo();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>(_loadCategories);
    on<AddCategory>(_addCategory);
    on<DeleteCategory>(_deleteCategory);
  }

  FutureOr<void> _loadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final list = await repo.getCategories();
      emit(CategoryLoaded(list));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  FutureOr<void> _addCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await repo.addCategory(name: event.name);
      final list = await repo.getCategories();
      emit(CategoryLoaded(list));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  FutureOr<void> _deleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await repo.deleteCategory(id: event.id);
      final list = await repo.getCategories();
      emit(CategoryLoaded(list));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
