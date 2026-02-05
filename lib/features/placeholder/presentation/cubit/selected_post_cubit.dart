import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';

/// Holds the currently selected post (e.g. for the post detail screen).

class SelectedPostCubit extends Cubit<Post?> {
  SelectedPostCubit() : super(null);

  void select(Post? post) => emit(post);
}
