import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'add_category.dart';
import 'add_product.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {
          _encryptedData.remove('myKey').then((success) =>
              Navigator.of(context).pop());
        }, icon: const Icon(Icons.logout))
      ],
        automaticallyImplyLeading: false,
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(child: Column(children: [
        const SizedBox(height: 20),
        ElevatedButton(onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddCategory()));
        }, child: Text('Add Category', style: TextStyle(fontSize: 25),)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddProduct()));
        }, child: Text('Add Product', style: TextStyle(fontSize: 25),)),
      ],),),
    );
  }
}
