//get code from google docs :: saved a Untitled document
import 'package:flutter/material.dart';
import 'package:new_project/searchUtil.dart';
import 'package:new_project/info.dart';

class Cardiology extends StatefulWidget {
  const Cardiology({super.key});
  @override
  _Cardiology createState() => _Cardiology();
}

class _Cardiology extends State<Cardiology> {
  bool isSearchActive = false;
  String searchQuery = "";
  List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Daniel Rodriguez',
      'experience': '23 years',
      'consultation_fee': '₹1500',
      'phone_number': '+91 987 654 1234',
      'specialization': 'Interventional Cardiology and Heart Surgeries',
      'bio': 'Dr. Daniel Rodriguez is a highly experienced cardiologist specializing in interventional cardiology and heart surgeries. He has performed numerous complex procedures with excellent outcomes over his 23 years of practice.',
      'image': 'assets/images/Card1.png',
      'consultation_days': 'Mon-Fri',
      'am': '9:00',
      'pm': '6:00',
    },
    {
      'name': 'Dr. Ryan Richards',
      'experience': '11 years',
      'consultation_fee': '₹1200',
      'phone_number': '+91 876 543 2109',
      'specialization': 'Preventive and Lifestyle Cardiology',
      'bio': 'Dr. Ryan Richards focuses on preventive cardiology and managing heart diseases with lifestyle modifications. With 11 years of experience, he is well-regarded for his patient-focused approach and preventive care techniques.',
      'image': 'assets/images/Card2.png',
      'consultation_days': 'Mon-Sat',
      'am': '11:00',
      'pm': '3:00',
    },
    {
      'name': 'Dr. Maria John',
      'experience': '17 years',
      'consultation_fee': '₹1400',
      'phone_number': '+91 765 432 1098',
      'specialization': 'Heart Rhythm Disorders and Interventional Cardiology',
      'bio': 'Dr. Maria John specializes in treating heart rhythm disorders and interventional cardiology. She has 17 years of experience in diagnosing and treating complex cardiac conditions with precision and care.',
      'image': 'assets/images/Card3.png',
      'consultation_days': 'Tue-Sat',
      'am': '8:00',
      'pm': '2:00',
    },
  ];

  List<Map<String, String>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors; //Initially all doctors are displayed
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredDoctors = SearchUtil.searchItems(doctors, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isSearchActive = !isSearchActive;
                });
              })
        ],
        title: isSearchActive
            ? Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
                onChanged: (query) {
                  updateSearchQuery(query);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.blue),
                    onPressed: () {
                      setState(() {
                        isSearchActive = !isSearchActive;
                        filteredDoctors=doctors;
                        searchQuery="";
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search..",
                )))
            : Text("Cardiology",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: filteredDoctors.isEmpty?
      Center(child:Text("No Doctors Found!",style:TextStyle(color:Colors.black))):
      ListView.separated(
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = filteredDoctors[index];
            return ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      doctor['image']!,
                    ),
                    radius: 25),
                title: Text(doctor['name']!,
                    style: TextStyle(color: Colors.black)),
                subtitle: Text("Experience ${doctor['experience']}",
                    style: TextStyle(color: Colors.black)),
                trailing: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Info(doctor:doctor)));
                    },
                    child: Text("Info", style: TextStyle(color: Colors.white))),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.grey, width: 0.001),
                ));
          },
          separatorBuilder: (index,context)=>SizedBox(height:10),),
    );
  }
}
