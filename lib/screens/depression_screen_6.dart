import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UniqueTriggersScreen extends StatefulWidget {
  @override
  _UniqueTriggersScreenState createState() => _UniqueTriggersScreenState();
}

class _UniqueTriggersScreenState extends State<UniqueTriggersScreen> {
  TextEditingController _triggersController = TextEditingController();
  TextEditingController _stressorsController = TextEditingController();

  @override
  void dispose() {
    _triggersController.dispose();
    _stressorsController.dispose();
    super.dispose();
  }

  Future<Database> _initializeDatabase() async {
    // Get the application documents directory.
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'triggers_stressors.db');

    // Open the database or create it if it doesn't exist.
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE triggers_stressors (
          id INTEGER PRIMARY KEY,
          triggers TEXT,
          stressors TEXT
        )
      ''');
        });
  }

  Future<void> _saveData(BuildContext context) async {
    String triggers = _triggersController.text;
    String stressors = _stressorsController.text;

    // Initialize the database.
    Database database = await _initializeDatabase();

    // Insert the data into the database.
    await database.insert('triggers_stressors', {
      'triggers': triggers,
      'stressors': stressors,
    });

    // Show a confirmation message or navigate to another screen.
    // For example:
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data saved successfully!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unique Triggers and Stressors'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _triggersController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Unique Triggers',
                hintText: 'Enter triggers that affect your mood...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _stressorsController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Unique Stressors',
                hintText: 'Enter stressors you encounter...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _saveData(context),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UniqueTriggersScreen(),
  ));
}
