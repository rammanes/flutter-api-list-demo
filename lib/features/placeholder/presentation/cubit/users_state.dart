import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

final class UsersInitial extends UsersState {
  const UsersInitial();
}

final class UsersLoading extends UsersState {
  const UsersLoading();
}

final class UsersLoaded extends UsersState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

final class UsersError extends UsersState {
  const UsersError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
