import 'package:flutter/material.dart';
import 'package:sample_project_3/db/category/category_db.dart';
import 'package:sample_project_3/models/category/category_models.dart';
import 'package:sample_project_3/screens/add_transactions/screen_add_transaction.dart';
import 'package:sample_project_3/screens/category/category_add_popup.dart';
import 'package:sample_project_3/screens/category/screen_category.dart';
import 'package:sample_project_3/screens/home/widgets/bottom_navigation.dart';
import 'package:sample_project_3/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
ScreenTransactions(),
ScreenCatogery()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier, 
          builder: (BuildContext context,int updatedIndex, _) {
            return _pages[updatedIndex];
          },
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
     if(selectedIndexNotifier.value == 0){
      print('Add Transaction');
    Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);

     }else {
      print('Add Category');

      showCategoryAddPopup(context);

      // final _sample = CategoryModel(
      //   id: DateTime.now().millisecondsSinceEpoch.toString(),
      //   name: 'Travel', 
      //   type: CategoryType.expense,
      //   );
      // CategoryDb().insertCategory(_sample);

     }
        },
        child: Icon(Icons.add),
        ),
    );
  }
}