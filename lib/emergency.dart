import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  final List<Map<String, String>> emergencyNumbers = [

    {"name": "Ambulance", "number": "102"},
    {"name": "Poison Control", "number": "1800-222-1222"},
    {"name": "Mental Health Helpline", "number": "1800-273-8255"},
{"name": "Blood Bank", "number": "104"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(icon:Icon(Icons.arrow_back_ios,color:Colors.white),onPressed: ()
          {
            Navigator.pop(context);
          },),
        title: Text("Emergency Contacts",style:TextStyle(color:Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: emergencyNumbers.length,
        itemBuilder: (context, index) {
          final contact = emergencyNumbers[index];
          return ListTile(
            leading: Icon(Icons.phone, color: Colors.redAccent),
            title: Text(contact['name']!, style: TextStyle(fontSize: 18)),
            trailing: Text(contact['number']!, style: TextStyle(fontSize: 18)),
          );
        },
      ),
    );
  }
}
