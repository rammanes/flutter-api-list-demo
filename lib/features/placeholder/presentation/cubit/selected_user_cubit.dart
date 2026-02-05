import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

/// Holds the currently selected user (e.g. for the user detail screen).
class SelectedUserCubit extends Cubit<User?> {
  SelectedUserCubit() : super(null);

  void select(User? user) => emit(user);
}
