import 'package:flutter/material.dart';
class ViewBooked extends StatelessWidget
{
  List<Map<String,String>>? confirm;
  int set;
  ViewBooked({Key?key,this.confirm,this.set=0}):super(key:key);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar:AppBar(leading:IconButton(onPressed: ()
    {
      Navigator.pop(context);
      if(set==1)
        {
          Navigator.pop(context);
          Navigator.pop(context);
        }
    }, icon: Icon(Icons.arrow_back_ios,color:Colors.white))
        ,backgroundColor:Colors.blue,title:Text("Booked Appointments",style:TextStyle(color:Colors.white))),
    body:confirm==null?Center(child:Text("No appointments Found")):ListView.separated(shrinkWrap: true,itemCount: confirm!.length,itemBuilder: (context,index){
      final app=confirm![index];
      
      return ListTile(
        contentPadding: EdgeInsets.all(10),
        title:Text("${app['doctor']}",style:TextStyle(color:Colors.black)),
        subtitle:Text("Appointment Date:${app['appDate']}\nAppointment Time:${app['appTime']}",style:TextStyle(color:Colors.black54)),
        tileColor:Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );

    },
        separatorBuilder:(index,context)=>SizedBox(height:10),
    )
    );
  }
}