part of 'user_bloc.dart';


abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class LoadCachedUsers extends UserEvent {}

class FetchUsers extends UserEvent {
  final bool isRefresh;
  const FetchUsers({this.isRefresh = false});
  @override
  List<Object> get props => [isRefresh];
}

class RefreshUsers extends UserEvent {



}

class SearchUsers extends UserEvent {
  final String query;
  const SearchUsers({required this.query});

  @override
  List<Object> get props => [query];
}
