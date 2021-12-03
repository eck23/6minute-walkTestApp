
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:walktestapp/models/testdetails.dart';

import 'package:walktestapp/showtestdetails.dart';




class Time extends StatefulWidget {
  
  // int minutes;
  // int seconds;
 final  String id;
 final String name;
  Time(this.id,this.name);
  
  @override
  State<Time> createState() => TimerState();

  
}

class TimerState extends State<Time> {
 int maxminutes=6;
 
 int minutes=6;
 
 int maxseconds=0;
 
 int seconds=0;

 int elapsedsec=0;
 
 int saveminutes=0;
 
 int saveseconds=0;
 
  bool change=true;
 
  Timer ?timer;
 
  int laps=0;

  late double onelap;

 late double partialLap;
 
  bool completed=false;

  bool onStart=true;

  int prevlaptime=0;
  int currentlaptime=0;
  int average=0;
  int avg=0;
 
  NumberFormat formatter= new NumberFormat("00");

  List<TestDetails> test=[];

  final labcontroller=TextEditingController();

  AudioPlayer audioPlayer =AudioPlayer();
  
  late final AudioCache player;
  final String  lapsound="lapsound1.mp3";

  List viewLaps=[];
  List viewLaps_reverse=[];
  

  @override
  void initState() {
    super.initState();
    
    player = AudioCache(
     prefix: 'assets/audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
    player.load(lapsound);

  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,

      ]);
      
    
  }
  
  playsound()async{
      audioPlayer= await player.play(lapsound);
  }
 
 final _formKey=GlobalKey<FormState>();
 final _formKey_=GlobalKey<FormState>();
 int min=6;
 int sec=0;

 bool done=false;
bool onenter=false;
void enterdetails(BuildContext ctx)async{
SharedPreferences prefs=await SharedPreferences.getInstance();    

  if(test.isEmpty && prefs.getString('test')!=null){
        final String? detailsString=prefs.getString('test');
        test=TestDetails.decode(detailsString!);
      }
  

    test.add(TestDetails
           (id: widget.id,
           testid:DateTime.now().toString(),
           date: DateFormat.yMMMd().format(DateTime.now()),
           BP_before: '', 
           BP_after: '', 
           HR_before: '', 
           HR_after: '', 
           RR_before: '', 
           RR_after: '', 
           SPO2_before: '', 
           SPO2_after: '', 
           dyspnea_before: '', 
           dyspnea_after: '', 
           fatigue_before: '', 
           fatigue_after:'', 
           Stopped_before: !completed, 
           StopReason: "", 
           MedicationsTaken:'', 
           Symptoms_after: "", 
           test_duration: '${formatter.format(maxminutes)} : ${formatter.format(maxseconds)}',
           completion_time:'${formatter.format(saveminutes)} : ${formatter.format(saveseconds)}', 
           oneLapDistance: '$onelap', 
           total_laps: laps.toString(), 
           total_covered_diatance: '${(onelap*laps)+partialLap}', 
           partial_lap_distance: '$partialLap',
           averagelap: '${ formatter.format(avg/60)}:${ formatter.format(avg%60)}',
           ));

        
        final String encodedData = TestDetails.encode(test);
        await prefs.setString('test', encodedData);
     
    Navigator.of(context).pop();
     Navigator.of(context).pop();
  
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_)=>ShowTestDetails(id: widget.id, name:widget.name )));
     
  
  }


 void settime(BuildContext ctx){

   showDialog(context: ctx, 
   barrierDismissible: false,
   builder: (ctx){
    
     return AlertDialog(
       scrollable: true,
       title: Text("Enter Test Time") ,
       content:
       Container(
         height: 180,
         width: 130,
         child: Form(
             key: _formKey,
             child:
             Column(children: [TextFormField(
              // controller: minutesEntry,
               onSaved: (val){
                 setState(() {
                   min=int.parse(val!) ;
                 });
               },
               validator: (minvalue){
                 if(minvalue!.isEmpty || int.parse(minvalue)>60){
                   return 'Enter A valid information';
                 }
                 return null;
               },

               keyboardType: TextInputType.number,
               decoration: InputDecoration(labelText: "Minutes",),
               inputFormatters: [LengthLimitingTextInputFormatter(2)],
               initialValue: "06",),

               TextFormField(
                 //controller: secondsEntry,
                 onSaved: (secval){
                   setState(() {
                     sec=int.parse(secval!);
                   });
                 },
                 validator: (secvalue){
                   if(secvalue!.isEmpty || int.parse(secvalue)>60){
                     return 'Enter A valid information';
                   }
                   return null;
                 },

                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(labelText: "Seconds",),
                 inputFormatters: [LengthLimitingTextInputFormatter(2)],
                 initialValue: "00",),
                 
                 TextFormField(
                 
                 onSaved: (lapdistance){
                   setState(() {
                     onelap=double.parse(lapdistance!);
                   });
                 },
                 validator: (onelapdistance){
                   if(onelapdistance!.isEmpty ){
                     return 'Enter A valid information';
                   }
                   return null;
                 },

                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(labelText: "One Lap Distance(in meters)",),
                 initialValue: "15.00",)],)
         ),
       ),

       actions: [
         ElevatedButton(onPressed: (){
           Navigator.pop(context);
           Navigator.pop(context);
           }, 
           child: Text("Exit")),
         
         ElevatedButton(onPressed:(){
         _formKey.currentState!.save();
         _formKey.currentState!.validate();
         if(_formKey.currentState!.validate()){
           setState(() {
             maxminutes=minutes=min;
             maxseconds=seconds=sec;
             pauseTimer(true);
             
             Navigator.of(ctx).pop();
           });

         }
       } , child: Text("Do Test")),],



     );
   });

 }
 
  void startTimer(BuildContext ctx){
      setState(() {
         change=false;
         
       });
     timer=Timer.periodic(Duration(seconds: 1), (_) {
       
       setState(() {
         if(seconds>0){
          change=false;
          seconds--;
          ++elapsedsec;
          

         }
         else{
           if(minutes>0){
             minutes--;
             seconds=59;
             ++elapsedsec;
           }else{
           
           pauseTimer(false);
           completed=true;
           save(ctx);
           }
         }
          
       });
      });
      
    
}
  
  void pauseTimer(bool reset) {
    setState(() {
      timer?.cancel();
     change=true;
     if(reset==true){
      seconds=maxseconds;
      minutes=maxminutes;
      laps=0;
      completed=false;
      elapsedsec=0;
      viewLaps.clear();
      viewLaps_reverse.clear();
      prevlaptime=0;
      currentlaptime=0;
      average=0;
      
     }
    });
     
  }
 
  void lap(){
    
    setState(() {

      if(laps<1){
        prevlaptime=elapsedsec;
        currentlaptime=elapsedsec;
        average+=currentlaptime;
        print('inside if');
      }
      else if(laps>0){
            currentlaptime=elapsedsec-prevlaptime;
            prevlaptime=elapsedsec;
            average+=currentlaptime;
            print("inside else if");
      }
      audioPlayer.stop();
      playsound();
     
      
      laps++;
      viewLaps.add(
     {'laptime': '${formatter.format((elapsedsec~/60))}:${formatter.format(elapsedsec%60)}',
      'currentlap':'${formatter.format((currentlaptime~/60))}:${formatter.format(currentlaptime%60)}',
     });
      viewLaps_reverse=List.from(viewLaps.reversed);
     
    });
  }

  void save(BuildContext ctx){
      if(laps>0){
        avg=(average/laps).round() ;
      }
    
      
    saveminutes=  (elapsedsec~/60) ;
    saveseconds =elapsedsec%60;
    bool landscape=false;
    if(MediaQuery.of(context).orientation==Orientation.landscape)
        landscape=true;  
    
    showDialog(context: ctx, 
    barrierDismissible:false,
    builder:(ctx){
      print("in dialog box");
      return AlertDialog(
        scrollable: true,
        title: Text("Save Test??"),
        content: Container(
          height: landscape==true ? 250.h:150.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Text("Total Test Time : ${formatter.format(maxminutes)}:${formatter.format(maxseconds)} min" ),
                        Text("Completion Time : ${formatter.format(saveminutes)}: ${formatter.format(saveseconds)} min"),
                        Text("Total Laps : $laps"),
                        Text("Average Lap Time : ${ formatter.format(avg/60)}:${ formatter.format(avg%60)}"),
                        
                        Form(
                          key: _formKey_,
                          child: TextFormField(
                        
                          onSaved: (partiallap){
                              partialLap=double.parse(partiallap!);
                          },
                          validator: (partial){
                          if(partial!.isEmpty ){
                            done=false;
                            return 'Enter A valid information';
                          }
                          return null;
                         },
                        
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Partial Lap Distance(in meters))",),
                       initialValue: "00",),
                        )
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
         Navigator.of(context).pop();
           
        }

        , child: Text(" No ")),
          
          
          
          ElevatedButton(onPressed: (){
          done=true;
          _formKey_.currentState!.save();
          _formKey_.currentState!.validate();
            
              if(done==true)enterdetails(ctx);
           
            
        }

        , child: Text(" Yes ")),
        ],
      );
    });
    
  }
 
  Widget showTime(){
    return 
    Text(
      "${formatter.format(minutes)}:${formatter.format(seconds)}",
      
      style: TextStyle(fontSize: 50),
    );
  }

  Widget showProgress(){
    return
      SizedBox(
        height: 170.h,
        width: 170.h,
        child: Stack(
          fit:StackFit.expand ,
          children: [
            Transform(
            alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
            child: CircularProgressIndicator(
              value: elapsedsec/((maxminutes*60)+maxseconds),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
              
              strokeWidth: 9.w,
              backgroundColor: Colors.green,
            ),),
          Center(child: showTime(),)],),
      );
  }

  Widget showProgressLandScape(){
    return
      SizedBox(
        height: 75.w,
        width: 75.w,
        child: Stack(
          fit:StackFit.expand ,
          children: [
            Transform(
            alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
            child: CircularProgressIndicator(
              value: elapsedsec/((maxminutes*60)+maxseconds),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
              
              strokeWidth: 7.w,
              backgroundColor: Colors.green,
            ),),
          Center(child: showTime(),)],),
      );
  }
 
  
  @override
  Widget build(BuildContext context) {
    
   
   if(onenter==false){
     Future.delayed(Duration.zero, () =>settime(context));
     onenter=true;
   }
   return Scaffold(
      
      resizeToAvoidBottomInset: false,
      appBar: AppBar(actions: [IconButton(onPressed: ()=>settime(context), icon:Icon(Icons.timer))],),
      body:
      OrientationBuilder(builder: (context,orientation){
      if(orientation==Orientation.portrait){
           return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: showProgress(),
              ),
              
              
              if(laps>0)Padding(
                padding:  EdgeInsets.only(top: 20.h,bottom: 20.h),
                
                child: Container(
                  height: 200.h,
                  width: 250.h,
                  child: ListView.separated(itemBuilder: (context,index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 15.w),
                          child: Text("${viewLaps_reverse.length-index}.",style: GoogleFonts.roboto(fontSize: 22.sp,fontWeight: FontWeight.w500 ),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: 15.w),
                          child:  Text('+ ${viewLaps_reverse[index]['currentlap']}',style: GoogleFonts.roboto(fontSize: 22.sp,fontWeight: FontWeight.w500),),
                        ),
                       
                        Text(" ${viewLaps_reverse[index]['laptime']}",style: GoogleFonts.roboto(fontSize: 22.sp,fontWeight: FontWeight.w500 ),),
                      ],
                    );
                  },itemCount: viewLaps_reverse.length,
                  separatorBuilder: (context, index) {
                      return Divider(thickness: 2.h,);
                    },),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
        
                  IconButton(onPressed:(){!change? lap():pauseTimer(true);}, 
                  icon: Icon(change?Icons.stop_circle_outlined:Icons.timelapse_rounded),
                  
                  color: Colors.red,
                    iconSize: 80.h,
                  ),
                  IconButton(onPressed:()=>change?startTimer(context):pauseTimer(false), 
                  color: Colors.red,
                  icon: Icon(change?Icons.play_circle_fill_outlined :Icons.pause_circle_filled_outlined),
                    iconSize: 80.h,
                  ),
                  
                ],
              )
        
          ],
            
          ),
        ),
      
      
    );
        }
    else{
         
         return  Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                        
                      Row(
                        mainAxisAlignment: laps<1?MainAxisAlignment.center:MainAxisAlignment.start,
                        children: [
                           Padding(
                          padding: EdgeInsets.only(bottom: 30.h,left: laps<1? 0.w:20.w),
                           child: showProgressLandScape(),
                          ),
                    if(laps>0)Padding(
                    padding:  EdgeInsets.only(top: 20.h,bottom: 20.h),
                    
                    child: Container(
                      height: 200.h,
                      width: 200.w,
                      child: ListView.builder(itemBuilder:(context,index){
                        return Row(
                          
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: 15.w),
                              child: Text("${viewLaps_reverse.length-index}.",style: GoogleFonts.roboto(fontSize: 40.sp,fontWeight: FontWeight.w500 ),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(right: 15.w),
                              child:  Text('+ ${viewLaps_reverse[index]['currentlap']}',style: GoogleFonts.roboto(fontSize: 40.sp,fontWeight: FontWeight.w500),),
                            ),
                           
                            Text(" ${viewLaps_reverse[index]['laptime']}",style: GoogleFonts.roboto(fontSize: 40.sp,fontWeight: FontWeight.w500 ),),
                          ],
                        );
                      },itemCount: viewLaps_reverse.length,
                      
                          
                        ),
                         ),
                        ),
                        ],
                      ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    
                      IconButton(onPressed:(){!change? lap():pauseTimer(true);}, 
                      icon: Icon(change?Icons.stop_circle_outlined:Icons.timelapse_rounded),
                      
                      color: Colors.red,
                        iconSize: 40.w,
                      ),
                      IconButton(onPressed:()=>change?startTimer(context):pauseTimer(false), 
                      color: Colors.red,
                      icon: Icon(change?Icons.play_circle_fill_outlined :Icons.pause_circle_filled_outlined),
                        iconSize: 40.w,
                      ),
                      
                    ],
                  )
            
              ],),
            ),
          
         );
      }
    }),
       floatingActionButton: FloatingActionButton(onPressed: ()=>save(context),
      backgroundColor: Colors.orangeAccent,
      child: Icon(Icons.save,),),);
  }



  
}