//get code from google docs :: saved a Untitled document
import 'package:flutter/material.dart';
import 'package:new_project/searchUtil.dart';
import 'package:new_project/info.dart';

class Dermatology extends StatefulWidget {
  const Dermatology({super.key});
  @override
  _Dermatology createState() => _Dermatology();
}

class _Dermatology extends State<Dermatology> {
  bool isSearchActive = false;
  String searchQuery = "";
  List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Jacob Lopez',
      'experience': '15 years',
      'specialization': 'Skin Disorders, Cosmetic Dermatology',
      'bio': 'Dr. Jacob Lopez has 15 years of experience specializing in skin disorders and cosmetic dermatology. He is known for his expertise in treating acne, skin aging, and other dermatological conditions with advanced treatments.',
      'consultation_fee': '₹1000',
      'phone_number': '+91 234 567 8901',
      'image': 'assets/images/Derm1.png',
      'consultation_days': 'Mon-Fri',
      'am': '10:00',
      'pm': '1:00',
    },
    {
      'name': 'Dr. Hannah Lewis',
      'experience': '11 years',
      'specialization': 'Hair Restoration, Dermatologic Surgery',
      'bio': 'With over 11 years of experience, Dr. Hannah Lewis specializes in hair restoration treatments and dermatologic surgeries. She uses the latest technology to provide natural-looking results in her treatments.',
      'consultation_fee': '₹1200',
      'phone_number': '+91 987 654 3210',
      'image': 'assets/images/Derm2.png',
      'consultation_days': 'Tue-Sat',
      'am': '2:00',
      'pm': '5:00',
    },
    {
      'name': 'Dr. Michael Chang',
      'experience': '7 years',
      'specialization': 'Pediatric Dermatology, Psoriasis Treatment',
      'bio': 'Dr. Michael Chang is a young and dynamic dermatologist with expertise in pediatric dermatology and psoriasis treatment. He is committed to delivering patient-centric care with the latest treatments available.',
      'consultation_fee': '₹900',
      'phone_number': '+91 876 543 2109',
      'image': 'assets/images/Derm3.png',
      'consultation_days': 'Mon-Thu',
      'am': '9:00',
      'pm': '12:00',
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
            : Text("Dermatology",
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Info(doctor:doctor)));
                    },
                    child: Text("Info", style: TextStyle(color: Colors.white))),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.grey, width: 0.001),
                ));
          },
          separatorBuilder:(index,context)=>SizedBox(height:10),
    ),
    );
  }
}
