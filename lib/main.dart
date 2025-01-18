import 'package:flutter/material.dart';
import 'package:new_project/sign_up.dart';
import 'package:new_project/login.dart';


void main() => runApp(HealthApp());

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aura",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      debugShowCheckedModeBanner:false,
    );
  }
}
class SplashScreen extends StatefulWidget
{
  const SplashScreen({super.key});
  @override
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen>
{
  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds:3),()
    {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>  FirstPage())
      );
    }
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor:Color.fromARGB(240,246,255,255),
    body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
      ClipRect(child:Image.asset('assets/images/Aura.png',width:210,height:100,fit:BoxFit.cover,),),
        ],
    ),
    ),
    );
  }
}


class FirstPage extends StatefulWidget {
  Map<String,String> user={
    'name':"abcd",'phoneno':"1234567890",'emailId':"abc12@gmail.com",'_username':"abcd",'_password':"1234"
  };
  FirstPage({super.key});
  @override
  _Firstpage createState() => _Firstpage();
}

class _Firstpage extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Login(user:widget.user),
            SignUp(),
          ],
        ),
      ),
    );
  }
}
