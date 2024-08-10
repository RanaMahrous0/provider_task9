import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsProvider extends ChangeNotifier {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  List posts = [];
  bool isLoadingPosts = true;
  PostsProvider() {
    fetchPosts();
  }
  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        posts = jsonDecode(response.body);
      } else {
        throw Exception('failed to load posts');
      }
    } catch (e) {
      throw Exception('Error in fetching posts: $e');
    } finally {
      isLoadingPosts = false;
      notifyListeners();
    }
  }
}
