import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/network/network_error_notifier.dart';

import '../../domain/repositories/posts_repository.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._repository) : super(const PostsInitial());

  final PostsRepository _repository;

  Future<void> loadPosts() async {
    emit(const PostsLoading());
    try {
      final posts = await _repository.getPosts();
      networkErrorNotifier.value = false;
      emit(PostsLoaded(posts));
    } catch (e) {
      if (isNetworkError(e)) {
        networkErrorNotifier.value = true;
        emit(PostsError(NetworkException.from(e).message));
      } else {
        emit(PostsError(e.toString()));
      }
    }
  }
}
