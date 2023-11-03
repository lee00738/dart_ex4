import 'dart:math';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



void main() {

  getUsers()
    .then((users){
      assert(users.isNotEmpty);

      for (var user in users) {
        var firstName = user['first_name'].toString().padRight(14);
        var lastName = user['last_name'].toString().padRight(14);
        var uid = user['uid'];
        print('First Name: $firstName | Last Name: $lastName | UID: $uid');
      }
    })
    .catchError((e){
      print(e);
    });

}


Future<List<Map<String, dynamic>>> getUsers() async{
  
  int num = Random().nextInt(5) + 8; // 8 to 12
  try{
  Uri url = Uri.parse("https://random-data-api.com/api/v2/users?size=$num");

  var res = await http.get(url);
  if(res.statusCode != 200){
    throw Exception("Response status code: ${res.statusCode}");
  }

  List<Map<String, dynamic>> data = 
    List<Map<String, dynamic>>.from(convert.jsonDecode(res.body));

  return data;

  }catch (e){
    print(e);
    return [];
  }

}




// void main() async {
//   try {
//     var randomUsers = await fetchUsers(10);
//     if (randomUsers != null) {
//       for (var user in randomUsers) {
//         var firstName = user['first_name'];
//         var lastName = user['last_name'];
//         var uid = user['uid'];
//         print('First Name: $firstName | Last Name: $lastName | UID: $uid');
//       }
//     }
//   } catch (error) {
//     print('ERROR: $error');
//   }
// }

// // fetch function
// Future<List<Map<String, dynamic>>> fetchUsers(int num) async {
//   var url = Uri.parse('https://random-data-api.com/api/v2/users?size=$num');

//   var res = await http.get(url);
//   if (res.statusCode == 200) {
//     final List<dynamic> data = convert.jsonDecode(res.body);
//     return data.cast<Map<String, dynamic>>();
//   } else {
//     throw Exception('Fetch Error');
//   }
// }
