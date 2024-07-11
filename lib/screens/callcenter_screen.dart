// callcenter_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CallCenterScreen extends StatefulWidget {
  @override
  _CallCenterScreenState createState() => _CallCenterScreenState();
}

class _CallCenterScreenState extends State<CallCenterScreen> {
  List<Map<String, String>> _callCenters = [];

  @override
  void initState() {
    super.initState();
    _loadCallCenters();
  }

  Future<void> _loadCallCenters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('callCenters');
    if (data != null) {
      setState(() {
        _callCenters = List<Map<String, String>>.from(json.decode(data));
      });
    }
  }

  Future<void> _saveCallCenters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('callCenters', json.encode(_callCenters));
  }

  void _addCallCenter() {
    _showEditDialog();
  }

  void _editCallCenter(int index) {
    _showEditDialog(index: index, data: _callCenters[index]);
  }

  void _deleteCallCenter(int index) {
    setState(() {
      _callCenters.removeAt(index);
    });
    _saveCallCenters();
  }

  void _showEditDialog({int? index, Map<String, String>? data}) {
    TextEditingController titleController = TextEditingController(text: data?['title'] ?? '');
    TextEditingController numberController = TextEditingController(text: data?['number'] ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Call Center' : 'Edit Call Center'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (index == null) {
                  setState(() {
                    _callCenters.add({
                      'title': titleController.text,
                      'number': numberController.text,
                    });
                  });
                } else {
                  setState(() {
                    _callCenters[index] = {
                      'title': titleController.text,
                      'number': numberController.text,
                    };
                  });
                }
                _saveCallCenters();
                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Center'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addCallCenter,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _callCenters.length,
          itemBuilder: (context, index) {
            final callCenter = _callCenters[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.blueAccent, size: 30),
                title: Text(callCenter['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(callCenter['number']!, style: TextStyle(fontSize: 16)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () => _editCallCenter(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteCallCenter(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
