import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'add_category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController(); // hold user key from TextField
  final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences(); // used to store the key later

  @override
  void initState() {
    super.initState();
    // call the below function to check if key exists
    checkSavedData();
  }
  // opens the Add Category page, if the key exists. It is called when
  // the application starts
  void checkSavedData() {
    _encryptedData.getString('myKey').then((String myKey) {
      if (myKey.isNotEmpty) {
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) => const AddCategory()));
      }
    });
  }


  void checkLogin() async{
    // make sure the key is not empty
    if (_controller.text.toString().trim() == '') {
      update(false);
    } else {
      // attempt to save key. Saving the key and encrypting it takes time.
      // so it is done asynchronously
      _encryptedData
          .setString('myKey', _controller.text.toString())
          .then((bool success) { // then is equivalent to using wait
        if (success) {
          update(true);
        } else {
          update(false);
        }
      });
    }
  }

  // this function opens the Add Category page, if we managed to save key successfully
  void update(bool success) {
    if (success) { // open the Add Category page if successful
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const AddCategory()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to set key')));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                  // replace typed text with * for passwords
                  obscureText: true,
                  enableSuggestions: false, // disable suggestions for password
                  autocorrect: false, // disable auto correct for password
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Key'),
                )),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: checkLogin, child: const Text('Save'))
          ])),
    );
  }

}
