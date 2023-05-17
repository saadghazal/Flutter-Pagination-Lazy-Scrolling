import 'package:flutter_pagination/erro_handler.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

class PlaceHolderRepository {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final http.Client client;

  const PlaceHolderRepository({
    required this.client,
  });
  Future<List<Post>> firstLoad() async {
    int page = 1;
    final url = Uri.parse(baseUrl + '?_page=$page');
    try {
      final response = await client.get(url);
      return postFromJson(response.body);
    } catch (e) {
      throw ErrorHandler(errorMessage: e.toString());
    }
  }

  Future<List<Post>> loadMore(int pageNumber) async {
    final url = Uri.parse('$baseUrl?_page=$pageNumber');
    try{
      final response = await client.get(url);
      return postFromJson(response.body);
    }catch (e){
      throw ErrorHandler(errorMessage: e.toString());
    }

  }
}
