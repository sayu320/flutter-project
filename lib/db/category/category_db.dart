import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_project_3/models/category/category_models.dart';
import 'package:sample_project_3/screens/category/expense_category.dart';
import 'package:sample_project_3/screens/category/income_category.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
 Future <List<CategoryModel>> getCategories();
 Future<void> insertCategory(CategoryModel value);
 Future<void> deleteCategory(String categoryID);

}

class CategoryDb implements CategoryDbFunctions{

CategoryDb._internal();
static CategoryDb instance = CategoryDb._internal();
factory CategoryDb(){
  return instance;
}  


ValueNotifier<List<CategoryModel>> incomeCategoryListListener = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> expenseCategoryListListener = ValueNotifier([]);


  @override
  Future<void> insertCategory(CategoryModel value) async {
   
 final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
 await _categoryDB.put(value.id,value);
 refreshUI();
  }
  
  
  @override
  Future<List<CategoryModel>> getCategories() async { 
  final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
 return _categoryDB.values.toList();

  }

Future<void> refreshUI() async {
  final _allCategories = await getCategories();
 incomeCategoryListListener.value.clear();
 expenseCategoryListListener.value.clear(); 

await Future.forEach(
  _allCategories,
  (CategoryModel category) {
  if(category.type == CategoryType.income){
    incomeCategoryListListener.value.add(category);
  }else {
    expenseCategoryListListener.value.add(category);
  }
});
incomeCategoryListListener.notifyListeners();
expenseCategoryListListener.notifyListeners();

}

  @override
  Future<void> deleteCategory(String categoryID) async {
  final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  await _categoryDB.delete(categoryID);
  await refreshUI();
  print('Category deleted');
  }

}
