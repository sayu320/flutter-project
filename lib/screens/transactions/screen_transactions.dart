import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sample_project_3/db/category/category_db.dart';
import 'package:sample_project_3/db/transactions/transaction_db.dart';
import 'package:sample_project_3/models/category/category_models.dart';
import 'package:sample_project_3/models/transactions/transaction_model.dart';


class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});
  

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier, 
      builder: (BuildContext context, List<TransactionModel> newList, Widget?_){
     return ListView.separated(
      padding: const EdgeInsets.all(10),

      //values

      itemBuilder: (context,index) {
        final _value = newList[index];
        return Slidable(
          key: ValueKey(_value.id ?? ''),
          startActionPane: ActionPane(motion: ScrollMotion(),
           children: [
            SlidableAction(onPressed: (context){
              if (_value.id != null){
              TransactionDb.instance.deleteTransaction(_value.id!);
              }
            },
            icon: Icons.delete,
            label: 'Delete',)
          ]),
          child: Card(
            elevation: 0,
            child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    parseDate(_value.date),
                  textAlign: TextAlign.center,
                  ),
                  backgroundColor: _value.type == CategoryType.income 
                  ? Colors.green 
                  : Colors.red,
                ),
                title: Text('RS ${_value.amount}'),
                subtitle: Text(_value.category.name), 
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

  // String parseDate(DateTime date) {
  //   final _date = DateFormat.MMMd().format(date);
  //   final _splitedDate = _date.split('');
  //   return '${_splitedDate.last}\n${_splitedDate.first}';


   //  return '${date.day}\n${date.month}';
// '${splitDate.first}\n${splitDate.skip(1).join()}';
// DateFormat('dMMM').format(date);
  
String parseDate(DateTime date) {
  final formattedDate = DateFormat('dMMM').format(date);
  return '${formattedDate.substring(0, formattedDate.length -3)}\n${formattedDate.substring(formattedDate.length -3 )}';
}

// void main() {
//   DateTime myDate = DateTime.now(); // Replace this with your desired DateTime object
//   String result = parseDate(myDate);
//   print(result); // Output: "8\nNov"
// }
  

  }

