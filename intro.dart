import 'package:flutter/material.dart';

class TicketOrderPage extends StatefulWidget {
  @override
  _TicketOrderPageState createState() => _TicketOrderPageState();
}

class _TicketOrderPageState extends State<TicketOrderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Ticket Ordering App'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image.asset('assets/logo.png'), // Your logo goes here
                TextFormField(
                  controller: _fromController,
                  decoration: InputDecoration(labelText: 'From'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a departure location';
                    }
                    return null;
                  },
                ),
                // Additional TextFormField widgets as needed
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Order Ticket'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Implement your form submission logic here
      // For example, showing a Snackbar with a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket ordered successfully!')),
      );
    }
  }
}