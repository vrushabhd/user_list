import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatar),
            ),
            SizedBox(height: 16),
            Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(user.email, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            // For demonstration, phone number is not provided by the API.
            Text('Phone: (N/A)', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
