import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sample_project_3/models/category/category_models.dart';
import 'package:sample_project_3/models/transactions/transaction_model.dart';
import 'package:sample_project_3/screens/add_transactions/screen_add_transaction.dart';
import 'package:sample_project_3/screens/home/screen_home.dart';



Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();

if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
  Hive.registerAdapter(CategoryTypeAdapter());
}

if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
  Hive.registerAdapter(CategoryModelAdapter());
}
if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
  Hive.registerAdapter(TransactionModelAdapter());
}


  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'My Flutter Demo',
          theme:ThemeData(primarySwatch: Colors.blue),
         home: const ScreenHome(),
         routes:{
          ScreenAddTransaction.routeName:(context) => const ScreenAddTransaction(),
         },
        );
        
      
        
      
      
    
  }
}



