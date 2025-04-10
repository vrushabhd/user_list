part of 'user_bloc.dart';
abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;
  final String searchQuery;
  final List<User> filteredUsers;

  const UserLoaded({
    required this.users,
    required this.hasReachedMax,
    required this.searchQuery,
    this.filteredUsers = const [],
  });

  UserLoaded copyWith({
    List<User>? users,
    bool? hasReachedMax,
    String? searchQuery,
    List<User>? filteredUsers,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredUsers: filteredUsers ?? this.filteredUsers,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax, searchQuery, filteredUsers];
}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}