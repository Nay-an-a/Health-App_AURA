//get code from google docs :: saved a Untitled document
import 'package:flutter/material.dart';
import 'package:new_project/searchUtil.dart';
import 'package:new_project/info.dart';

class GenMed extends StatefulWidget {
  const GenMed({super.key});
  @override
  _GenMed createState() => _GenMed();
}

class _GenMed extends State<GenMed> {
  bool isSearchActive = false;
  String searchQuery = "";
  List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Emma Rodriguez',
      'experience': '6 years',
      'specialization': 'General Medicine, Internal Medicine',
      'bio': 'Dr. Emma Rodriguez has 6 years of experience in treating general health issues and managing chronic diseases. She is dedicated to providing holistic care and improving the overall health of her patients.',
      'consultation_fee': '₹800',
      'phone_number': '+91 234 567 8901',
      'image': 'assets/images/Gen1.png',
      'consultation_days': 'Mon-Fri',
      'am': '9:00',
      'pm': '12:00',
    },
    {
      'name': 'Dr. Jacob Rivera',
      'experience': '17 years',
      'specialization': 'Cardiology, Diabetes Management',
      'bio': 'Dr. Jacob Rivera specializes in cardiology and diabetes management, with 17 years of experience. He is committed to providing effective treatments for heart conditions and managing diabetes to improve the quality of life for his patients.',
      'consultation_fee': '₹1200',
      'phone_number': '+91 987 654 3210',
      'image': 'assets/images/Gen2.png',
      'consultation_days': 'Tue-Sat',
      'am': '11:30',
      'pm': '6:00',
    },
    {
      'name': 'Dr. Madison Clark',
      'experience': '17 years',
      'specialization': 'Gastroenterology, Respiratory Diseases',
      'bio': 'With 17 years of experience, Dr. Madison Clark specializes in treating gastrointestinal issues and respiratory diseases. She is known for her personalized care and expertise in managing complex conditions.',
      'consultation_fee': '₹1000',
      'phone_number': '+91 876 543 2109',
      'image': 'assets/images/Gen3.png',
      'consultation_days': 'Mon-Thu',
      'am': '10:00',
      'pm': '1:00',
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
            : Text("General Medicine",
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
