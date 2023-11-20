import 'package:flutter/material.dart';
import 'package:sample_project_3/db/category/category_db.dart';
import 'package:sample_project_3/models/category/category_models.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb.instance.incomeCategoryListListener, 
      builder: (BuildContext context, List<CategoryModel>newList, Widget?_){
      return ListView.separated(
      itemBuilder: (context,index) {
      final category = newList[index];
   return Card(
      child: ListTile
      (title: Text(category.name),
      trailing: IconButton(
        onPressed: (){
      CategoryDb.instance.deleteCategory(category.id);
        }, 
        icon: const Icon(Icons.delete)
        ),
      ),
    );
      }, 
      separatorBuilder: (context,index) {
    return const SizedBox(height: 10);
      }, 
      itemCount: newList.length
      );
    });
  }
}