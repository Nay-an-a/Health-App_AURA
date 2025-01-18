import 'package:flutter/material.dart';
import 'package:new_project/emergency.dart';
import 'package:new_project/specialities.dart';
import 'package:new_project/bookedappointments.dart';
import 'package:new_project/userprofile.dart';
import 'package:new_project/medicalReports1.dart';
import 'package:new_project/vaccinations.dart';
import 'package:new_project/searchHospitals.dart';
import 'package:new_project/searchUtil.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user });
  final Map<String, String> user;
  _HomePage createState() => _HomePage();
}
class _HomePage extends State<HomePage> {
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    List <Widget> pages=[
      Home(user:widget.user),
      SearchHos(user: widget.user),
    ];
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          fixedColor: Colors.blue,
          onTap:(index)
          {
            setState(() {
              _currentIndex=index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Search Hospitals",
              icon: Icon(Icons.local_hospital_rounded),
            ),
          ]),

    );
  }
}
class Home extends StatelessWidget
{
  Home({Key?key,required this.user}):super(key:key);
  Map<String,String> user;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Grotesco",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              Text(
                "   Welcome ${user['name']}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DoctorSp()));
                },
                style: ElevatedButton.styleFrom(

                    fixedSize: Size(double.infinity, 60), backgroundColor: Colors.blue,elevation:5),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Consult a doctor",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Icon(Icons.arrow_circle_right, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height:30,),
              ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewBooked()));
                  },
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.blue,fixedSize:Size(double.infinity,60),elevation:5),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Booked appointments",style:TextStyle(color:Colors.white,fontSize:18)),
                      Icon(Icons.arrow_circle_right,color:Colors.white),
                    ],
                  )
              )
            ]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              accountName: Text(
                "${user['name']}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Grotesco",
                ),
              ),
              accountEmail: Text(
                "${user['emailId']}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Grotesco",
                ),
              ),
              currentAccountPictureSize: Size.square(55),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                ' My Profile ',
                style: TextStyle(
                  fontFamily: "Grotesco",
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(user:user),),);
              },
            ),
            ListTile(
              leading: Icon(Icons.note_alt_outlined),
              title: Text(
                "Medical Reports",
                style: TextStyle(
                  fontFamily: "Grotesco",
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MedRep()));
              },
            ),
            ListTile(
                leading: Icon(Icons.vaccines),
                title: Text(
                  "Vaccination Details",
                  style: TextStyle(
                    fontFamily: "Grotesco",
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VaccRep()));
                }),
            ListTile(
                leading: Icon(Icons.report_problem),
                title: Text(
                  "Emergency",
                  style: TextStyle(
                    fontFamily: "Grotesco",
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EmergencyPage()));
                })
          ],
        ),
      ),

    );
  }
}


class SearchHos extends StatefulWidget {
  Map<String,String> user;
  SearchHos({super.key,required this.user});
  @override
  _SearchHos createState() => _SearchHos();
}


class _SearchHos extends State<SearchHos> {
  bool isSearchActive = false;
  String searchQuery = "";
  final List<Map<String, String>> hospitals= [
    {
      "name": "City Medical Center",
      "address": "123 Main Street, Downtown",
      "contact": "123-456-7890",
    },
    {
      "name": "General Hospital",
      "address": "456 Elm Street, Suburbia",
      "contact": "987-654-3210",
    },
    {
      "name": "Advanced Care Hospital",
      "address": "789 Oak Avenue, Uptown",
      "contact": "555-123-4567",
    },
    {
      "name": "Children's Health Center",
      "address": "321 Pine Lane, Midtown",
      "contact": "111-222-3333",
    },
  ];
  List<Map<String, String>> filteredHos = [];


  @override
  void initState() {
    super.initState();
    filteredHos = hospitals; //Initially all doctors are displayed
  }


  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredHos = SearchUtil.searchItems(hospitals, query);
      print("Search Query: $query");
      print("Filtered Hospitals: $filteredHos");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:IconThemeData(color:Colors.white),
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
                        filteredHos=hospitals;
                        searchQuery="";
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search..",
                )))
            : Text("Hospitals",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: filteredHos.isEmpty?
      Center(child:Text("No Hospitals Found!",style:TextStyle(color:Colors.black))):
      ListView.separated(
        itemCount: filteredHos.length,
        itemBuilder: (context, index) {
          final hos = filteredHos[index];
          return ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(hos['name']!,
                  style: TextStyle(color: Colors.black)),
              subtitle: Text("Address ${hos['address']}Contact Number ${hos['contact']}",
                  style: TextStyle(color: Colors.black)),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.grey, width: 0.001),
              ));
        },
        separatorBuilder: (index,context)=>SizedBox(height:10),),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              accountName: Text(
                "${widget.user['name']}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Grotesco",
                ),
              ),
              accountEmail: Text(
                "${widget.user['emailId']}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Grotesco",
                ),
              ),
              currentAccountPictureSize: Size.square(55),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                ' My Profile ',
                style: TextStyle(
                  fontFamily: "Grotesco",
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(user:widget.user),),);
              },
            ),
            ListTile(
              leading: Icon(Icons.note_alt_outlined),
              title: Text(
                "Medical Reports",
                style: TextStyle(
                  fontFamily: "Grotesco",
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MedRep()));
              },
            ),
            ListTile(
                leading: Icon(Icons.vaccines),
                title: Text(
                  "Vaccination Details",
                  style: TextStyle(
                    fontFamily: "Grotesco",
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VaccRep()));
                }),
            ListTile(
                leading: Icon(Icons.report_problem),
                title: Text(
                  "Emergency",
                  style: TextStyle(
                    fontFamily: "Grotesco",
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EmergencyPage()));
                })
          ],
        ),
      ),
    );
  }
}
