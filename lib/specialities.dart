import 'package:flutter/material.dart';
import 'package:new_project/cardiology.dart';
import 'package:new_project/dermatology.dart';
import 'package:new_project/generalMedicine.dart';

class DoctorSp extends StatelessWidget {
  const DoctorSp({super.key});
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
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              Text(
                "Specialities",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                SizedBox(width:MediaQuery.of(context).size.width*0.00000001),
                TextButton(
                  onPressed: () {
                    print("Cardiology button clicked");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Cardiology()));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 18),
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.blue,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.monitor_heart,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text("Cardiology", style: TextStyle(color: Colors.white))
                  ]),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Dermatology()));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        EdgeInsets.symmetric(vertical: 30, horizontal: 12.5),
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.blue,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.face,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text("Dermatology", style: TextStyle(color: Colors.white))
                  ]),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GenMed()));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.blue,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.local_hospital,
                      size: 20,
                      color: Colors.white,
                    ),

                    Text(" General\nMedicine",
                        style: TextStyle(color: Colors.white))
                  ],),
                ),
                SizedBox(width:MediaQuery.of(context).size.width*0.00000001),
              ],),
            ],),
    ),
    );
  }
}
