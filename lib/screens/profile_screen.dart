import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _instansiList = [];
  String _selectedInstansi = '';
  String _namaInstansi = '';
  String _email = '';
  String _kantor = '';
  String _alamat = '';
  String _callCenter = '';
  String _responseMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchInstansiList();
  }

  Future<void> _fetchInstansiList() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://mobilecomputing.my.id/api_amru/get_instansi_list.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _instansiList = json.decode(response.body);
      });
    } else {
      setState(() {
        _responseMessage = 'Failed to fetch instansi list: ${response.reasonPhrase}';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchProfile(String namaInstansi) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://mobilecomputing.my.id/api_amru/profile.php?nama_instansi=$namaInstansi'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _namaInstansi = data['nama_instansi'];
        _email = data['email'];
        _kantor = data['kantor'];
        _alamat = data['alamat'];
        _callCenter = data['call_center'];
      });
    } else {
      setState(() {
        _responseMessage = 'Failed to fetch profile: ${response.reasonPhrase}';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _createProfile() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://mobilecomputing.my.id/api_amru/create_profile.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama_instansi': _namaInstansi,
        'email': _email,
        'kantor': _kantor,
        'alamat': _alamat,
        'call_center': _callCenter,
      }),
    );

    setState(() {
      _isLoading = false;
      _responseMessage = response.body;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://mobilecomputing.my.id/api_amru/update_profile.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama_instansi': _namaInstansi,
        'email': _email,
        'kantor': _kantor,
        'alamat': _alamat,
        'call_center': _callCenter,
      }),
    );

    setState(() {
      _isLoading = false;
      _responseMessage = response.body;
    });
  }

  Future<void> _deleteProfile() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://mobilecomputing.my.id/api_amru/delete_profile.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nama_instansi': _namaInstansi}),
    );

    setState(() {
      _isLoading = false;
      _responseMessage = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Profile Instansi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField(
                          items: _instansiList.map<DropdownMenuItem<String>>((instansi) {
                            return DropdownMenuItem<String>(
                              value: instansi['nama_instansi'],
                              child: Text(instansi['nama_instansi']),
                            );
                          }).toList(),
                          decoration: InputDecoration(labelText: 'Pilih Nama Instansi'),
                          onChanged: (value) {
                            setState(() {
                              _selectedInstansi = value.toString();
                              _fetchProfile(_selectedInstansi);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Nama Instansi'),
                          controller: TextEditingController(text: _namaInstansi),
                          onChanged: (value) {
                            setState(() {
                              _namaInstansi = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          controller: TextEditingController(text: _email),
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Kantor'),
                          controller: TextEditingController(text: _kantor),
                          onChanged: (value) {
                            setState(() {
                              _kantor = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Alamat'),
                          controller: TextEditingController(text: _alamat),
                          onChanged: (value) {
                            setState(() {
                              _alamat = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Call Center'),
                          controller: TextEditingController(text: _callCenter),
                          onChanged: (value) {
                            setState(() {
                              _callCenter = value;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 4,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _createProfile,
                              icon: Icon(Icons.add),
                              label: Text('Create'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _updateProfile,
                              icon: Icon(Icons.update),
                              label: Text('Update'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _deleteProfile,
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _fetchProfile(_selectedInstansi),
                              icon: Icon(Icons.search),
                              label: Text('Fetch'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _responseMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
