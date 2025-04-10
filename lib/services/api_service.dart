import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String baseUrl = 'https://reqres.in/api/users';

  Future<Map<String, dynamic>> fetchUsers({required int page, int perPage = 15}) async {
    final response = await http
        .get(Uri.parse('$baseUrl?per_page=$perPage&page=$page'))
        .timeout(Duration(seconds: 10), onTimeout: () {
      throw Exception("Request timed out");
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<User> users = (data['data'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
      return {
        'users': users,
        'total_pages': data['total_pages'],
      };
    } else {
      throw Exception("Failed to load users");
    }
  }
}
