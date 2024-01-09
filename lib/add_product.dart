import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'api.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _controllerProductName = TextEditingController();
  TextEditingController _controllerQuantity= TextEditingController();
  TextEditingController _controllerPrice= TextEditingController();
  TextEditingController _controllerCategoryName= TextEditingController();

  // the below variable is used to display the progress bar when retrieving data
  bool _loading = false;

  @override
  void dispose() {
    _controllerQuantity.dispose();
    _controllerProductName.dispose();
    _controllerPrice.dispose();
    _controllerCategoryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(child:
        Center(child: Form(
          key: _formKey, // key to uniquely identify the form when performing validation
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerProductName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter product name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerQuantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter quantity',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerPrice,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter price',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerCategoryName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter category name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              ElevatedButton(
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading ? null : () { // disable button while loading
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    addProduct(update,_controllerProductName.text.toString(), int.parse(_controllerQuantity.text.toString()), double.parse(_controllerPrice.text.toString()), _controllerCategoryName.text.toString());
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              Visibility(visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        ))));
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
}
