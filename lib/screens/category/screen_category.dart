import 'package:flutter/material.dart';
import 'package:sample_project_3/db/category/category_db.dart';
import 'package:sample_project_3/screens/category/expense_category.dart';
import 'package:sample_project_3/screens/category/income_category.dart';

class ScreenCatogery extends StatefulWidget {
  const ScreenCatogery({super.key});



  @override
  
  State<ScreenCatogery> createState() => _ScreenCatogeryState();
}


class _ScreenCatogeryState extends State<ScreenCatogery> with SingleTickerProviderStateMixin {

  late TabController _tabController;

@override
  void initState() {
  _tabController = TabController(length: 2, vsync: this);

  CategoryDb().refreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'INCOME'),
            Tab(text: 'EXPENSE'),
          ]
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
              IncomeCategoryList(),
              ExpenseCategoryList()
            ]),
          )
    
          
      ],
    );
    
  }
}