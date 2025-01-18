import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_project/bookedappointments.dart';

class Info extends StatefulWidget {
  Info({super.key, required this.doctor});
  final Map<String, String> doctor;
  _Info createState() => _Info();
}

class _Info extends State<Info> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  @override
  Widget build(BuildContext context) {
    String consultationTime = widget.doctor['consultation_days'] ?? '';
    List<int> availableDays = _parseConsultationTime(consultationTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Doctor Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    widget.doctor['image']!), // Display the doctor's image
                radius: 80, // Set the size of the avatar
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: Text("${widget.doctor['name']}",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Text("Experience : ${widget.doctor['experience']}",
                    style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Specialization : ${widget.doctor['specialization']}",
                  textAlign: TextAlign.justify, style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Bio :\n${widget.doctor['bio']}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15))),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                  "Consultation Times : ${widget.doctor['consultation_days']} :${widget.doctor['am']} AM - ${widget.doctor['pm']} PM",
                  style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text("Consultation Fee : ${widget.doctor['consultation_fee']}",
                    style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text("Contact No : ${widget.doctor['phone_number']}",
                    style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(180, 40),
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                    onPressed: () async {
                      int flag = 0;
                      /*Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNow(doctor:doctor)));*/
                      final date = await pickDate();
                      if (date == null) return;
                      final time = await pickTime();
                      if (time == null) return;
                      _selectedTime = time;
                      _selectedDate = date;
                      print("${_selectedTime} and ${_selectedDate}");
                      print(
                          "Am time of doctor:${convertStringToTime(widget.doctor['am']!).hour}");
                      print(
                          "Pm time of doctor:${convertStringToTime(widget.doctor['pm']!).hour}");
                      print("SelectedTime:${_selectedTime!.hour}");
                      if (availableDays.contains(date.weekday)) {
                        if (_selectedTime!.hour < 12 &&
                            _selectedTime!.hour >=
                                convertStringToTime(widget.doctor['am']!)
                                    .hour) {
                          flag = 1;
                          print("am");
                        } else if (_selectedTime!.hour > 12 &&
                            _selectedTime!.hour % 12 <=
                                convertStringToTime(widget.doctor['pm']!)
                                    .hour) {
                          flag = 1;
                          print("pm");
                        } else {
                          flag = 0;
                        }
                        if (flag == 1) {
                          print("Date selected is within consultation days");
                          print("time is within consultation hours");
                          showMessageDialog(
                              "Booking Successful",
                              "Booking confirmed with doctor ${widget.doctor['name']} on ${DateFormat('dd-MM-yyy').format(_selectedDate!.toLocal())}  at ${_selectedTime!.hour}:${_selectedTime!.minute} ",
                              1);
                        } else {
                          showMessageDialog("Booking Unsuccessful",
                              "Time outside consultation hours", 0);
                        }
                      } else {
                        print("Date outside consultation date");
                        showMessageDialog("Booking Unsuccessful",
                            "Doctor unavailable on selected date", 0);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Book now",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        SizedBox(width: 20),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        )
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2027),
      );
  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
  List<int> _parseConsultationTime(String consultationTime) {
    final availableDays = <int>[];
    Map<int, String> days = {
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun',
    };
    int x = 0, y = 0;

    if (consultationTime.contains('Mon')) x == 0 ? x = 1 : y = 1;
    if (consultationTime.contains('Tue')) x == 0 ? x = 2 : y = 2;
    if (consultationTime.contains('Wed')) x == 0 ? x = 3 : y = 3;
    if (consultationTime.contains('Thu')) x == 0 ? x = 4 : y = 4;
    if (consultationTime.contains('Fri')) x == 0 ? x = 5 : y = 5;
    if (consultationTime.contains('Sat')) x == 0 ? x = 6 : y = 6;

    for (int i = x; i <= y; i++) {
      if (days[i] == 'Mon') {
        availableDays.add(DateTime.monday);
      } else if (days[i] == 'Tue') {
        availableDays.add(DateTime.tuesday);
      } else if (days[i] == 'Wed') {
        availableDays.add(DateTime.wednesday);
      } else if (days[i] == 'Thu') {
        availableDays.add(DateTime.thursday);
      } else if (days[i] == 'Fri') {
        availableDays.add(DateTime.friday);
      } else if (days[i] == 'Sat') {
        availableDays.add(DateTime.saturday);
      }
    }
    print(availableDays);
    return availableDays;
  }

  TimeOfDay convertStringToTime(String timeString) {
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int min = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: min);
  }

  void showMessageDialog(String title, String str, int confirm) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              str,
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (confirm == 1) {
                      List<Map<String, String>>? app = [
                        {
                          'doctor': widget.doctor['name'] ?? 'Unknown',
                          'appDate': DateFormat("dd-MM-yyyy")
                              .format(_selectedDate!.toLocal()),
                          'appTime':
                              "${_selectedTime!.hour}:${_selectedTime!.minute}",
                        }
                      ];
                      print(app[0]['appTime']);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ViewBooked(confirm: app, set: 1)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}
