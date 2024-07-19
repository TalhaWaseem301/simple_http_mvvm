import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user.dart';


class UserViewModel extends ChangeNotifier {
  List<Data> _users = [];
  bool _isLoading = true;

  List<Data> get users => _users;
  bool get isLoading => _isLoading;

  UserViewModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response data: $data');
        final userListModel = UserListModel.fromJson(data);
        _users = userListModel.data ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
