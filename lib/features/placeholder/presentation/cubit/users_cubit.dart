import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/network/network_error_notifier.dart';

import '../../domain/repositories/users_repository.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._repository) : super(const UsersInitial());

  final UsersRepository _repository;

  Future<void> loadUsers() async {
    emit(const UsersLoading());
    try {
      final users = await _repository.getUsers();
      networkErrorNotifier.value = false;
      emit(UsersLoaded(users));
    } catch (e) {
      if (isNetworkError(e)) {
        networkErrorNotifier.value = true;
        emit(UsersError(NetworkException.from(e).message));
      } else {
        emit(UsersError(e.toString()));
      }
    }
  }
}
