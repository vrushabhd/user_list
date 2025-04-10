import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';

import '../models/user.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for scrolling to bottom for infinite scroll.
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        BlocProvider.of<UserBloc>(context).add(FetchUsers());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<UserBloc>(context).add(FetchUsers(isRefresh: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Internet Conncection"),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(FetchUsers());
                    },
                    child: Text('Retry'),
                  )
                ],
              ),
            );
          } else if (state is UserLoaded) {
            List<User> displayUsers = state.searchQuery.isEmpty
                ? state.users
                : state.filteredUsers;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search users by name',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<UserBloc>(context)
                            .add(SearchUsers(query: value));
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: displayUsers.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index < displayUsers.length) {
                          User user = displayUsers[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatar),
                            ),
                            title: Text('${user.firstName} ${user.lastName}'),
                            subtitle: Text(user.email),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UserDetailScreen(user: user),
                                ),
                              );
                            },
                          );
                        } else {
                          // Show a loading indicator at the bottom.
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
