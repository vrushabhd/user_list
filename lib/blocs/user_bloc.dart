import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import '../models/user.dart';
import '../services/api_service.dart';
part  'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  int currentPage = 1;
  int totalPages = 1;
  List<User> users = [];
  bool isFetching = false;
  UserBloc({required this.apiService}) : super(UserInitial()) {
    on<LoadCachedUsers>(_onLoadCachedUsers);
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onLoadCachedUsers(LoadCachedUsers event, Emitter<UserState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cached_users');
    if (cachedData != null) {
      final List<dynamic> decoded = json.decode(cachedData);
      users = decoded.map((json) => User.fromJson(json)).toList();
      emit(UserLoaded(users: users, hasReachedMax: false, searchQuery: ''));
    }
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (isFetching) return;
    isFetching = true;
    try {
      // Emit loading state on first fetch
      if (event.isRefresh) {
        currentPage = 1;
        users.clear();
      } else if (state is UserInitial) {
        emit(UserLoading());
      }

      final response = await apiService.fetchUsers(page: currentPage);
      List<User> fetchedUsers = response['users'] as List<User>;
      totalPages = response['total_pages'] as int;
      users.addAll(fetchedUsers);

      // Cache the data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_users', json.encode(users.map((u) => u.toJson()).toList()));

      bool hasReachedMax = currentPage >= totalPages;
      currentPage++;

      // Apply search if already set
      String searchQuery = '';
      List<User> filtered = [];
      if (state is UserLoaded) {
        searchQuery = (state as UserLoaded).searchQuery;
        if (searchQuery.isNotEmpty) {
          filtered = users
              .where((u) => ('${u.firstName} ${u.lastName}')
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
              .toList();
        }
      }
      emit(UserLoaded(users: users, hasReachedMax: hasReachedMax, searchQuery: searchQuery, filteredUsers: filtered));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> _onRefreshUsers(RefreshUsers event, Emitter<UserState> emit) async {
    currentPage = 1;
    totalPages = 1;
    users.clear();
    emit(UserLoading());
    await _onFetchUsers(FetchUsers(), emit);
  }

  Future<void> _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      String query = event.query;
      if (query.isNotEmpty) {
        List<User> filtered = users.where((u) {
          final fullName = '${u.firstName} ${u.lastName}'.toLowerCase();
          return fullName.contains(query.toLowerCase());
        }).toList();
        emit(currentState.copyWith(searchQuery: query, filteredUsers: filtered));
      } else {
        emit(currentState.copyWith(searchQuery: '', filteredUsers: []));
      }
    }
  }
}
