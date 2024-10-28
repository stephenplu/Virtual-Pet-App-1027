import 'dart:convert';
import 'package:http/http.dart' as http;

/*API SERVICE FILE
steph: this connects the frontend UI and works with the backend (/my-backend/server.js) to connect to the amazon RDS databse
if we want to add more actions that would access the database we would need to use this page
*/

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3000/api'; // steph: this is the url for the andriod emulator, if we test a external device or on a webpage this url can change

  Future<Map<String, dynamic>?> login(String username, String password) async {
    print('Making API call to $baseUrl/login');
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Successful login response: $jsonResponse');
        return jsonResponse;
      } else {
        print('Failed to log in: ${response.statusCode}, Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }

    //add more actions here








    
  }
}
