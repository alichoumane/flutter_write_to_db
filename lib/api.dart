import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();
const String _baseURL = 'i3350.ulfs5.net';


// below function sends the cid, name and key using http post to the REST service
void addCategory(Function(String text) update, String name) async {
  try {
    // we need to first retrieve and decrypt the key
    String myKey = await _encryptedData.getString('myKey');
    // send a JSON object using http post
    final url = Uri.https(_baseURL, 'addCategory.php');
    final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $myKey',
        }, // convert the cid, name and key to a JSON object
        body: convert.jsonEncode(<String, String>{
          'name': name, 'key': myKey
        })).timeout(const Duration(seconds: 5));
    // call the update function
    update(response.body);
    print(response.body);
  }
  catch (e) {
    update("connection error");
  }
}

void addProduct(Function(String text) update, String productName, int quantity, double price, String categoryName) async {
  try {
    // we need to first retrieve and decrypt the key
    String myKey = await _encryptedData.getString('myKey');
    // send a JSON object using http post
    final url = Uri.https(_baseURL, 'addProduct.php');
    final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $myKey',
        }, // convert the cid, name and key to a JSON object
        body: convert.jsonEncode(<String, dynamic>{
          'name': '$productName', 'quantity': quantity, 'price': price, 'category_name': categoryName, 'key': myKey
        })).timeout(const Duration(seconds: 15));
    // call the update function
    update(response.body);
  }
  catch (e) {
    update("connection error");
  }
}