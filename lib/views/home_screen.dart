import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('User Data'),
      ),
      body: Container(
        color: Colors.lightBlue[200],
        child: Consumer<UserViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (viewModel.users.isEmpty) {
              return Center(child: Text('No data found'));
            }
            return ListView.builder(
              itemCount: viewModel.users.length,
              itemBuilder: (context, index) {
                final user = viewModel.users[index];
                return ListTile(
                  leading: Image.network(user.avatar ?? ''),
                  title: Text('${user.firstName ?? ''} ${user.lastName ?? ''}'),
                  subtitle: Text(user.email ?? ''),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
