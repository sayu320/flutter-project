import 'package:flutter/material.dart';
import 'package:sample_project_3/db/category/category_db.dart';
import 'package:sample_project_3/models/category/category_models.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);
final _nameEditingController = TextEditingController();

Future<void> showCategoryAddPopup(BuildContext context) async {
  showDialog(
    context: context, 
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        const Padding(
           padding: EdgeInsets.all(8.0),
          child:Row(
            children:  [
            RadioButton(title:'Income', type: CategoryType.income),
            RadioButton(title:'Expense', type: CategoryType.expense),
          ],
          )
           ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                final _name = _nameEditingController.text;
                if(_name.isEmpty){
                  return;
                }
                final _type = selectedCategoryNotifier.value;
                final _category = CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                   name: _name, 
                   type: _type,
                   );
            CategoryDb.instance.insertCategory(_category);
            Navigator.of(ctx).pop();

              }, 
              child: Text('Add')
              ),
          )
        ],
      );
    });
}
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type
    });

   

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier, 
          builder: (BuildContext context, CategoryType newCategory, Widget?_) {
          return Radio<CategoryType>(
          value: type,
         groupValue: newCategory , 
         onChanged: (value){
          if(value == null){
            return;
          }
          selectedCategoryNotifier.value = value;
          selectedCategoryNotifier.notifyListeners();
       

         },
         
         );
        }),
        Text(title),
      ],
    );
  }
}