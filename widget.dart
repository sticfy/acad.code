import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyFormWidget extends StatefulWidget {
  @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  late String _selectedDropdownValue1;
  late String _selectedDropdownValue2;
  late String _selectedDropdownValue3;
  late String _selectedDropdownValue4;
  late String _selectedDropdownValue5;
  String serverResponse = '';
  String report = '';

  _MyFormWidgetState() {
    _selectedDropdownValue1 = 'Male';
    _selectedDropdownValue2 = 'No Education';
    _selectedDropdownValue3 = 'No';
    _selectedDropdownValue4 = 'No';
    _selectedDropdownValue5 = 'No';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0E77DD),
        title: Row(
          children: [
            SizedBox(width: 8),
            Text(
              'ACAD',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '©Made by',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Text(
                'Tayeb Hossain and Kamrul Islam Chowdhury',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Please Enter the Values Accordingly',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildInputField('Enter your age here', _controller1),
                  SizedBox(height: 16),
                  _buildDropdown(
                      'Gender', _selectedDropdownValue1, ['Male', 'Female']),
                  SizedBox(height: 16),
                  _buildInputField('Enter blood pressure here', _controller2),
                  SizedBox(height: 16),
                  _buildDropdown('Select your educational qualification',
                      _selectedDropdownValue2, [
                    'No Education',
                    'Secondary',
                    'Higher Secondary',
                    'Grduate'
                  ]),
                  SizedBox(height: 16),
                  _buildInputField('Enter heart rate here', _controller3),
                  SizedBox(height: 16),
                  _buildDropdown('Select your smoking status',
                      _selectedDropdownValue3, ['Yes', 'No']),
                  SizedBox(height: 16),
                  _buildInputField(
                      'Enter Cigarette per day here', _controller4),
                  SizedBox(height: 16),
                  _buildDropdown('Blood pressure Medicine',
                      _selectedDropdownValue4, ['Yes', 'No']),
                  SizedBox(height: 16),
                  _buildInputField('Enter glucose level here', _controller5),
                  SizedBox(height: 16),
                  _buildDropdown('Prevalent hyper tension',
                      _selectedDropdownValue5, ['Yes', 'No']),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _submitForm();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0E77DD),
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildReport(),
                  _buildResult(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF0E77DD),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF071177),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      controller: controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a value';
        }
        return null;
      },
      style: TextStyle(
        color: Colors.black87.withOpacity(0.9),
      ),
    );
  }

  Widget _buildDropdown(
      String label, String selectedValue, List<String> dropdownItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF0E77DD),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF071177),
            ),
          ),
        ),
        value: selectedValue,
        items: dropdownItems
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black87.withOpacity(0.9),
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            switch (label) {
              case 'Gender':
                _selectedDropdownValue1 = value ?? 'Male';
                break;
              case 'Select your educational qualification':
                _selectedDropdownValue2 = value ?? 'No Education';
                break;
              case 'Select your smoking status':
                _selectedDropdownValue3 = value ?? 'No';
                break;
              case 'Blood pressure Medicine':
                _selectedDropdownValue4 = value ?? 'No';
                break;
              case 'Prevalent hyper tension':
                _selectedDropdownValue5 = value ?? 'No';
                break;
            }
          });
        },
      ),
    );
  }

  Widget _buildReport() {
    if (_controller1.text.isEmpty ||
        _controller2.text.isEmpty ||
        _controller3.text.isEmpty ||
        _controller4.text.isEmpty ||
        _controller5.text.isEmpty ||
        _selectedDropdownValue1 == null ||
        _selectedDropdownValue2 == null ||
        _selectedDropdownValue3 == null ||
        _selectedDropdownValue4 == null ||
        _selectedDropdownValue5 == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Report:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Label 1: ${_controller1.text}'),
        Text('Dropdown 1: $_selectedDropdownValue1'),
        Text('Label 2: ${_controller2.text}'),
        Text('Dropdown 2: $_selectedDropdownValue2'),
        Text('Label 3: ${_controller3.text}'),
        Text('Dropdown 3: $_selectedDropdownValue3'),
        Text('Label 4: ${_controller4.text}'),
        Text('Dropdown 4: $_selectedDropdownValue4'),
        Text('Label 5: ${_controller5.text}'),
        Text('Dropdown 5: $_selectedDropdownValue5'),
      ],
    );
  }

  Widget _buildResult() {
    return FutureBuilder(
      future: fetchResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Result from Server:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Server Response: ${snapshot.data}'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement the logic for checking again
                      // Reset the form or take any necessary actions
                      setState(() {
                        // Reset your form variables or perform any actions needed
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0E77DD),
                    ),
                    child: Text(
                      'Check Again',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement the logic for downloading the report
                      // You can use a package like url_launcher to open a link or implement your download logic
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0E77DD),
                    ),
                    child: Text(
                      'Download Report',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  void _submitForm() {
    _callFlaskAPI();
    // Additional processing if needed
  }

  Future<String> fetchResult() async {
    // Mocking a server request.
    await Future.delayed(Duration(seconds: 2));
    return 'Mock Server Response';
  }

  Future<void> _callFlaskAPI() async {
    final String apiUrl = 'http://a1b6-34-123-86-181.ngrok-free.app/predict';

    try {
      Map<String, dynamic> formData = {
        'gender': _selectedDropdownValue1,
        'age': _controller1.text,
        'education': _selectedDropdownValue2,
        'smoking': _selectedDropdownValue3,
        'cig': _controller4.text,
        'bpmeds': _selectedDropdownValue4,
        'hyp': _selectedDropdownValue5,
        'bp': _controller2.text,
        'hr': _controller3.text,
        'glu': _controller5.text,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          serverResponse = data['result'];
          report = data['report'];
        });
      } else {
        throw Exception('Failed to fetch result');
      }
    } catch (e) {
      print('Error: $e');
      // Display an error message to the user
      // You can use a Flutter SnackBar or some other UI element
    }
  }
}
