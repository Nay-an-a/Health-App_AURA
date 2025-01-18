import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedRep extends StatefulWidget {
  MedRep({Key? key}) : super(key: key);
  _MedRep createState() => _MedRep();
}

class _MedRep extends State<MedRep> {
  List<File> images = [];
  List<String> titles = [];
  PageController _pageController = PageController();
  TextEditingController _textEditingController = TextEditingController();
  int _currentIndex = 0;
  void nextImage() {
    if (_currentIndex < images.length) {
      setState(() {
        _currentIndex++;
      });
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
    _pageController.animateToPage(_currentIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future<void> _uploadResults() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        titles.add(_textEditingController.text);
        _textEditingController.clear();
        images.add(File(pickedFile.path));
        _currentIndex = images.length - 1;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: Text("Medical Reports", style: TextStyle(color: Colors.white)),
        ),
        body: Expanded(
            child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _textEditingController,
                  decoration:
                      InputDecoration(labelText: "Enter name of report "),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_textEditingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Enter a name for the report to be submitted"),
                      ));
                    } else {
                      _uploadResults();
                    }
                    print("Button Prssed");
                  },
                  child: Text("Upload Report",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                )),
            images.isEmpty || titles.isEmpty
                ? Expanded(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: Text("No medical reports found"))],
                  ))
                : Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(50),
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: images.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text("${titles[index]}",
                                        style: TextStyle(fontSize: 25)),
                                  ),
                                  Image.file(
                                    images[index],
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ));
                            }))),
          ],
        )));
  }
}
