import 'package:flutter/material.dart';
import 'package:sqflite_project/pages/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Add task"),
              content: Column(
                children: [
                  TextField(),
                  MaterialButton(onPressed:() {},
                    )
                ],
              ),
                )
        );
      },
      child: Icon(
        Icons.add,
      ),
    );
  }
}
