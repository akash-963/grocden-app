import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopDetailsPage extends StatefulWidget {
  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _selectedLocality = '';

  GlobalKey<AutoCompleteTextFieldState<String>> localityKey =
  GlobalKey<AutoCompleteTextFieldState<String>>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final phone = _phoneNumberController.text;
    final locality = _selectedLocality;

    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    FirebaseFirestore.instance.collection('shopCollection').doc(userId).set({
      'name': name,
      'address': address,
      'locality': locality,
      'phoneNumber': phone,
    });

    _nameController.clear();
    _addressController.clear();
    _phoneNumberController.clear();

    // Navigate to the desired screen
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<void> notifyUnavailableLocality() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final phone = _phoneNumberController.text;
    final locality = _selectedLocality;

    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    await FirebaseFirestore.instance.collection('waitingListCollection').doc(userId).set({
        'name': name,
        'address': address,
        'locality': locality,
        'phoneNumber': phone,
    });

    _nameController.clear();
    _addressController.clear();
    _phoneNumberController.clear();

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('We will get back to you soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("\n\n\n"+ _selectedLocality);
    return Scaffold(
      appBar: AppBar(
        title: Text('Locality Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 10.0),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: saveData,
              child: Text('Save and Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
