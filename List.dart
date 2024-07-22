import 'package:flutter/material.dart';

class AvailableBusesPage extends StatelessWidget {
  final String fromLocation;

  AvailableBusesPage({required this.fromLocation});

  // Dummy data for available buses. In a real app, this data would come from a backend or database.
  final List<Map<String, String>> availableBuses = [
    {"name": "Bus A", "time": "08:00 AM"},
    {"name": "Bus B", "time": "09:00 AM"},
    {"name": "Bus C", "time": "10:00 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Buses from $fromLocation'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: availableBuses.length,
        itemBuilder: (context, index) {
          var bus = availableBuses[index];
          return ListTile(
            leading: Icon(Icons.directions_bus),
            title: Text(bus["name"]!),
            subtitle: Text('Departure: ${bus["time"]}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Logic to select this bus for booking
                Navigator.pop(context); // Optionally pop back to the previous page
              },
              child: Text('Select'),
            ),
          );
        },
      ),
    );
  }
}