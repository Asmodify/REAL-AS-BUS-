import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrontPage(),
    );
  }
}

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Locations and Date'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _fromController,
              decoration: InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'No Date Chosen'
                  : 'Picked Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement navigation or logic to proceed with the selected locations and date
                if (_fromController.text.isNotEmpty && _toController.text.isNotEmpty && _selectedDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultsPage(fromLocation: _fromController.text, toLocation: _toController.text, date: _selectedDate!)),
                  );
                } else {
                  // Show an error or prompt to complete all fields
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}

// Placeholder for the ResultsPage. You need to implement this based on your app's requirements.
class ResultsPage extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  final DateTime date;

  ResultsPage({required this.fromLocation, required this.toLocation, required this.date});

  @override
  Widget build(BuildContext context) {
    // Build your results page here
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Text('Showing results for $fromLocation to $toLocation on ${date.toLocal()}'),
      ),
    );
  }
}