
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walktestapp/models/primarydetails.dart';
import 'package:walktestapp/models/testdetails.dart';
import 'package:walktestapp/showprimarydetails.dart';
import 'package:walktestapp/timer.dart';
import 'package:walktestapp/widgets/landscape/testDetailsCardLandScape.dart';
import 'package:walktestapp/widgets/testdetailscard.dart';

class ShowTestDetails  extends StatefulWidget {
  
  final String  id;
  final String  name;
  

  
  ShowTestDetails({required this.id,required this.name});
  @override
  _ShowTestDetails createState() => _ShowTestDetails();
}

class _ShowTestDetails extends State<ShowTestDetails> {
   
   List<TestDetails>_templist=[];
   //List<TestDetails>_temp=[];
   late PrimaryDetails _primaryDetails;
 

    
    void initState(){
      getdata();
      print('in init');
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,

      ]);
      
    }

   void  getdata() async{
      SharedPreferences prefs=await SharedPreferences.getInstance();
        
      _templist.clear();
      
      setState(() {
         String? _primary = prefs.getString('primary');
          _primaryDetails=PrimaryDetails.decode(_primary!).firstWhere((element) => element.id==widget.id);

        if(prefs.getString('test')!=null){
          String? detailsString=prefs.getString('test');
          _templist=TestDetails.decode(detailsString!).where((element) => element.id==widget.id).toList();
        }
        
    });
    
   }
  
void cleartest(String removeid)async{
 
  
  
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('test')!=null){
           String? detailsString=prefs.getString('test');
            List<TestDetails> temp=TestDetails.decode(detailsString!);
            
           temp.removeWhere((element) => element.testid==removeid);
            String encodedData = TestDetails.encode(temp);
            await prefs.setString('test', encodedData);

    }
     getdata();
     
          

}
void alert (Function function,BuildContext ctx){
      showDialog(context: ctx, builder:(ctx){
      return AlertDialog(
        title: Text ("Are you sure to remove this test ?"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("No")),
          ElevatedButton(onPressed: (){
            
          setState(() {
            function();
            Navigator.of(ctx).pop();
          });
           
          }, child: Text("Yes")),
        ],
      );
    });
  }
  


void taketest(BuildContext ctx){

  Navigator.of(context).push(MaterialPageRoute(builder: (_){return Time(widget.id,widget.name);}));
  
}

Widget patientdetailsPortrait(){
  return Card(
    color: Colors.grey.shade800,
    child: ListTile(
      title: Text("Name : ${_primaryDetails.name}",style: GoogleFonts.roboto(fontSize:17.sp,color: Colors.white),),
      subtitle: Row(children: [
        Padding(
          padding:  EdgeInsets.only(top: 10.h,right: 15.h),
          child: Text("Age : ${_primaryDetails.age}",style: GoogleFonts.roboto(fontSize: 14.sp,color: Colors.white),),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 10.h,right: 15.h),
          child: Text("Height : ${_primaryDetails.height} ${_primaryDetails.hunit}",style: GoogleFonts.roboto(fontSize: 14.sp,color: Colors.white),),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 10.h),
          child: Text("Weight : ${_primaryDetails.weight} ${_primaryDetails.wunit}",style: GoogleFonts.roboto(fontSize: 14.sp,color: Colors.white),),
        ),
      ],),
      
    ),
 );
  
}
Widget patientdetailsLandscape(){
  return Card(
    color: Colors.grey.shade800,
    child: ListTile(
      title: Text("Name : ${_primaryDetails.name}",style: GoogleFonts.roboto(fontSize:30.sp,color: Colors.white),),
      subtitle: Row(children: [
        Padding(
          padding:  EdgeInsets.only(top: 10.h,right: 15.h),
          child: Text("Age : ${_primaryDetails.age}",style: GoogleFonts.roboto(fontSize: 25.sp,color: Colors.white),),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 10.h,right: 15.h),
          child: Text("Height : ${_primaryDetails.height} ${_primaryDetails.hunit}",style: GoogleFonts.roboto(fontSize: 25.sp,color: Colors.white),),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 10.h),
          child: Text("Weight : ${_primaryDetails.weight} ${_primaryDetails.wunit}",style: GoogleFonts.roboto(fontSize: 25.sp,color: Colors.white),),
        ),
      ],),
      
    ),
 );
  
}


Widget showPortrait(){
  return
     SingleChildScrollView(
           child: Column(
            children: [ Padding(
              padding:  EdgeInsets.only(top:10.h),
              child: patientdetailsPortrait(),
            ),
              Stack(children: [
                Container(
                height: 0.7.sh,
                padding: EdgeInsets.only(top:10.h),
                child: _templist.isNotEmpty ?
                ListView.builder(itemBuilder: (context,index){
                      return TestDetailsCard(
                        testDetails:_templist[index], 
                        number:(index+1).toString(),
                        testid:_templist[index].testid,
                        name:widget.name,
                        context:context,
                        function: ()=>alert(()=>cleartest(_templist[index].testid),context),);
                },itemCount: _templist.length,): Center(
                  
                    child: Text("No test done yet !!",style: GoogleFonts.roboto(fontSize: 20.sp)),
                  ),
                ) ,
              
               
              ],)
           ],
                 ),
         );
}
Widget showLandscape(){
  return
     SingleChildScrollView(
           child: Column(
            children: [ Padding(
              padding:  EdgeInsets.only(top:10.h),
              child: patientdetailsLandscape(),
            ),
              Stack(children: [
                Container(
                height: 0.6.sh,
                padding: EdgeInsets.only(top:10.h),
                child: _templist.isNotEmpty ?
                ListView.builder(itemBuilder: (context,index){
                      return TestDetailsCardLandScape(
                        testDetails:_templist[index], 
                        number:(index+1).toString(),
                        testid:_templist[index].testid,
                        name:widget.name,
                        context:context,
                        function: ()=>alert(()=>cleartest(_templist[index].testid),context),);
                },itemCount: _templist.length,): Center(
                  
                    child: Text("No test done yet !!",style: GoogleFonts.roboto(fontSize: 25.sp)),
                  ),
                ) ,
              
               
              ],)
           ],
                 ),
         );
}
  
  @override
  Widget build(BuildContext context) {
        Future<bool> _willPopCallback() async {
          SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
         
      ]);
          return true;
        }
    return  WillPopScope(onWillPop:_willPopCallback ,
      child: OrientationBuilder(
          builder: (context, orientation){
            if(orientation == Orientation.portrait){
              return Scaffold(
        appBar: AppBar(title: Text("${widget.name} - Test Details"),),
        body:showPortrait(),
        floatingActionButton: FloatingActionButton(onPressed: ()=>taketest(context), child: Icon(Icons.navigate_next)),);
            }else{
              return Scaffold(
            appBar: AppBar(title: Text("${widget.name} - Test Details"),
            actions: [IconButton(onPressed: ()=>taketest(context),
            highlightColor: Colors.white,
    
            color: Colors.blue,
            icon: CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.navigate_next_rounded)))],),
            body: showLandscape());
            }
          },
        
           
        
      
      ),
    );
  }
}

  
