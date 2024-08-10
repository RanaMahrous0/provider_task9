import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDetailsProvider extends ChangeNotifier {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  List comments = [];
    Map<String, dynamic> post = {};
  bool isLoadingComments = false;
    bool isLoadingPost = true;
  Future<void> fetchComments(int postId) async {
    isLoadingComments = true;
    notifyListeners();
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
      if (response.statusCode == 200) {
        comments = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Error in fetching comments');
    } finally {
      isLoadingComments = false;
      notifyListeners();
    }
  }
  Future<void> fetchPost(int postId)async{
        try {
      isLoadingPost = true;
      notifyListeners();

      final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));
      if (response.statusCode == 200) {
        post = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    } finally {
      isLoadingPost = false;
      notifyListeners();
    }
  }
}
