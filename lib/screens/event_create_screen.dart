import 'package:flutter/material.dart';

class event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class FundraiserEvent {
  String name;
  DateTime date;
  String description;

  FundraiserEvent(
      {required this.name, required this.date, required this.description});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FundraiserEvent> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                FundraiserEvent? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateEventScreen()),
                );

                if (result != null) {
                  setState(() {
                    events.add(result);
                  });
                }
              },
              child: Text('Create Event'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookEventScreen()),
                );
              },
              child: Text('Book Event'),
            ),
            SizedBox(height: 20),
            Column(
              children: events.map((event) {
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.date.toString()),
                  // Add more details as needed
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateEventScreen extends StatelessWidget {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create Your Event Here',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            TextFormField(
              controller: eventDateController,
              decoration: InputDecoration(labelText: 'Event Date'),
            ),
            TextFormField(
              controller: eventDescriptionController,
              decoration: InputDecoration(labelText: 'Event Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FundraiserEvent newEvent = FundraiserEvent(
                  name: eventNameController.text,
                  date: DateTime.parse(eventDateController.text),
                  description: eventDescriptionController.text,
                );

                Navigator.pop(context, newEvent);
              },
              child: Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Event'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Browse and Book Events Here',
              style: TextStyle(fontSize: 20),
            ),
            // Add a list of events and a button to book them
          ],
        ),
      ),
    );
  }
}
