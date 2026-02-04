import 'package:vsi_assessment/features/posts/domain/entities/post.dart';
import 'package:vsi_assessment/features/posts/domain/repositories/posts_repository.dart';

import '../datasources/post_api_service.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl({PostApiService? apiService})
      : _apiService = apiService ?? PostApiService();

  final PostApiService _apiService;

  @override
  Future<List<Post>> getPosts() => _apiService.fetchPosts();

  @override
  Future<Post?> getPostById(int id) => _apiService.fetchPostById(id);
}
