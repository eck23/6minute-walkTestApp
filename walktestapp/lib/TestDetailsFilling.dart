import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walktestapp/models/testdetails.dart';
import 'package:walktestapp/showtestdetails.dart';


class TestDetailsForm  extends StatefulWidget {
  
  
   final String testid;
   final String id;
   final String name;
   final String date;
   
  
   TestDetailsForm(this.testid,this.id,this.name,this.date);

  @override
  State<TestDetailsForm> createState() => _TestDetailsFormState();
}

class _TestDetailsFormState extends State<TestDetailsForm> {

  List<TestDetails> test=[];
TextEditingController bpBefore= TextEditingController();

  TextEditingController bpAfter=TextEditingController();

  TextEditingController hrBefore=TextEditingController();

  TextEditingController hrAfter=TextEditingController();

  TextEditingController spo2Before=TextEditingController();

  TextEditingController spo2After=TextEditingController();

  TextEditingController rrBefore=TextEditingController();

  TextEditingController rrAfter=TextEditingController();

  TextEditingController dyspneaBefore=TextEditingController();

  TextEditingController dyspneaAfter=TextEditingController();

  TextEditingController fatigueBefore=TextEditingController();

  TextEditingController fatigueAfter=TextEditingController();

  TextEditingController partialLap=TextEditingController();

  TextEditingController medications=TextEditingController();

  TextEditingController stopReason=TextEditingController();

  TextEditingController symptoms=TextEditingController();

  TextEditingController onelapcontroller=TextEditingController();

  TextEditingController totallapcontroller=TextEditingController();

  TextEditingController partiallapcontroller=TextEditingController();

  TextEditingController totalmincontroller=TextEditingController();

  TextEditingController totalseccontroller=TextEditingController();

  TextEditingController completionmincontroller=TextEditingController();

  TextEditingController completionseccontroller=TextEditingController();

  TextEditingController avgmincontroller=TextEditingController();

  TextEditingController avgseccontroller=TextEditingController();


  

 
  int index=0;

DateTime showdate=DateTime.now();
bool save=true;
bool dateflag=false;
late List testtime;
late List avgtime;
late List comptime;
 NumberFormat formatter= new NumberFormat('00');

  
  @override
  void initState() {
      getdata();
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      ]);
  }
  void getdata()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
      test.clear();
      if(prefs.getString('test')!=null){
        
          String? detailsString=prefs.getString('test');
        test=TestDetails.decode(detailsString!);

        index =test.indexWhere((element) => element.testid==widget.testid);

        testtime= test[index].test_duration.split(':');
        comptime=test[index].completion_time.split(':');
        avgtime=test[index].averagelap.split(":");
        
       
        bpBefore.text=test[index].BP_before;
        bpAfter.text=test[index].BP_after;
        hrBefore.text=test[index].HR_before;
        hrAfter.text=test[index].HR_after;
        rrBefore.text=test[index].RR_before;
        rrAfter.text=test[index].RR_after;
        spo2Before.text=test[index].SPO2_before;
        spo2After.text=test[index].SPO2_after;
        dyspneaBefore.text=test[index].dyspnea_before;
        dyspneaAfter.text=test[index].dyspnea_after;
        fatigueBefore.text=test[index].fatigue_before;
        fatigueAfter.text=test[index].fatigue_after;
        medications.text=test[index].MedicationsTaken;
        stopReason.text=test[index].StopReason;
        symptoms.text=test[index].Symptoms_after;
        totalmincontroller.text=testtime[0];
        totalseccontroller.text=testtime[1];
        completionmincontroller.text=comptime[0];
        completionseccontroller.text=comptime[1];
        avgmincontroller.text=avgtime[0];
        avgseccontroller.text=avgtime[1];
        onelapcontroller.text=test[index].oneLapDistance;
        totallapcontroller.text=test[index].total_laps;
        partiallapcontroller.text=test[index].partial_lap_distance;
       
      }

 }
  
   void enterData()async{

  
      SharedPreferences prefs=await SharedPreferences.getInstance();
   
      double total=((double.parse(onelapcontroller.text))*(double.parse(totallapcontroller.text)))+double.parse(partiallapcontroller.text);
             
             test[index].BP_after=bpAfter.text.trim();
             test[index].BP_before=bpBefore.text.trim();
             test[index].HR_after=hrAfter.text.trim();
             test[index].HR_before=hrBefore.text.trim();
             test[index].RR_after=rrAfter.text.trim();
             test[index].RR_before=rrBefore.text.trim();
             test[index].SPO2_after=spo2After.text.trim();
             test[index].SPO2_before=spo2Before.text.trim();
             test[index].dyspnea_after=dyspneaAfter.text.trim();
             test[index].dyspnea_before=dyspneaBefore.text.trim();
             test[index].fatigue_after=fatigueAfter.text.trim();
             test[index].fatigue_before=fatigueBefore.text.trim();
             test[index].MedicationsTaken=medications.text.trim();
             test[index].StopReason=stopReason.text.trim();
             test[index].Symptoms_after=symptoms.text.trim();
             test[index].total_covered_diatance=total.toString().trim();
             test[index].total_laps=totallapcontroller.text.trim();
             test[index].partial_lap_distance=(double.parse(partiallapcontroller.text)).toString().trim();
             test[index].oneLapDistance=(double.parse(onelapcontroller.text)).toString().trim();
             test[index].test_duration='${formatter.format(int.parse(totalmincontroller.text))} : ${formatter.format(int.parse(totalseccontroller.text))}'.trim();
             test[index].completion_time='${formatter.format(int.parse(completionmincontroller.text))} : ${formatter.format(int.parse(completionseccontroller.text))}'.trim();
             test[index].averagelap='${formatter.format(int.parse(avgmincontroller.text))} : ${formatter.format(int.parse(avgseccontroller.text))}'.trim();
             
             if(dateflag==true){
               test[index].date=DateFormat.yMMMd().format(showdate);
             }

           
         final String encodedData = TestDetails.encode(test);
        await prefs.setString('test', encodedData);
   
   


   }
  
      void submitdetails(BuildContext ctx)  {
      print("laps : ${totallapcontroller.text}");
     enterData();
     Navigator.pop(context);
     Navigator.pop(context);
     Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder:(_)=>ShowTestDetails(id: widget.id, name: widget.name)));  
  
  }

  showToast(String message){
     Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM ,
        backgroundColor: Colors.black,
        textColor: Colors.white
    );
  }
  
  void confirm (BuildContext context){
    showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text ("Do you want to save ?"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("No")),
          ElevatedButton(onPressed: (){
            submitdetails(context);
          }, child: Text("Yes")),
        ],
      );
    });
  }
  
  Widget dataEntry(TextInputType textInputType,TextEditingController controller ,String label,String hint,double height,double width,int maxlines){
          
    return 
                 SizedBox(
                   height: height,
                   width: width,
                   child: TextFormField(controller:controller,
                                textAlign: TextAlign.center,
                                keyboardType:textInputType,
                                maxLines: maxlines>=1?maxlines:3,
                               
                                //enableInteractiveSelection: false,
                                decoration: InputDecoration(
                                  labelText: label,
                                
                                 hintText: hint,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1,))
                                ),
                              
                                validator: (val){
                                  if(medications.text.trim().isEmpty){
                                    medications.text='-';
                                  }
                                  if(symptoms.text.trim().isEmpty){
                                    symptoms.text='-';
                                  }
                                  if(stopReason.text.trim().isEmpty){
                                    stopReason.text='-';
                                  }
                                
                                  val=val!.trim();
                                  
                                  if(val.isEmpty){
                                    
                                    showToast("Some fields are missing");
                                    save=false;
                                    return null;
                                  }
                                  return null;
                                
                                },
                    ),
                 );
    
  }
  void datebutton(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate:DateTime(2019), 
      lastDate: DateTime.now()
      ).then((pickeddate){
        if(pickeddate==null){
         dateflag=false;
          return;
          }
        setState(() {
          dateflag=true;
          showdate=pickeddate;
          //print(showdate);

        });
      });
      
  }

  bool onenter=false;
  final datakey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  
  double normalSizeH=70.h;
  double normalSizeW=150.w;
  double enlargedSizeH=100.h;
  double enlargedSizeW=250.w;
  double smallsizeH=70.h;
  double smallSizeW=100.w;
 
     Future<bool> _willPopCallback() async {
          
          SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
      ]);
          return true; 
      }
    
  
    return WillPopScope(onWillPop: _willPopCallback,
      child: GestureDetector(
        
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(title: Text("Test Details Form"),),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                 
                children:[
                            Padding(
                              padding:  EdgeInsets.all(10.h),
                              child: Text("Fill Test Details",style: 
                              TextStyle(fontSize:17.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                          
                            
                            Form(
                            
                              key: datakey,
                              child:Column(
                                children: [
                                  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right:10.w),
                                  child: dataEntry(  TextInputType.text,bpBefore, "BP_Before",'',normalSizeH,normalSizeW,1),
                                ),
                                dataEntry( TextInputType.text,bpAfter, "BP_After",'',normalSizeH,normalSizeW,1),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry( TextInputType.text,hrBefore, "HR_Before",'',normalSizeH,normalSizeW,1),
                                ),
                                dataEntry( TextInputType.text,hrAfter, "HR_After",'',normalSizeH,normalSizeW,1),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.text,rrBefore, "RR_before",'',normalSizeH,normalSizeW,1),
                                ),
                                dataEntry(TextInputType.text,rrAfter, "RR_After",'',normalSizeH,normalSizeW,1),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right:10.w),
                                  child: dataEntry(TextInputType.text,spo2Before, "SpO${'\u2082'} Before",'',normalSizeH,normalSizeW,1),
                                ),
                                dataEntry(TextInputType.text,spo2After, "SpO${'\u2082'} After",'',normalSizeH,normalSizeW,1),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.text,dyspneaBefore, "Dyspnea_Before",'',normalSizeH,normalSizeW,1),
                                ),
                                dataEntry(TextInputType.text,dyspneaAfter, "Dyspnea_After",'',normalSizeH,normalSizeW,1),
                              ],
          
                            ),
            
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.text,fatigueBefore, "Fatigue_Before",'',normalSizeH,normalSizeW,1),
                                ),
                                dataEntry(TextInputType.text,fatigueAfter, "Fatigue_After",'',normalSizeH,normalSizeW,1),
                              ],
          
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.numberWithOptions(decimal: true),onelapcontroller, "One Lap Distance(in m)",'',normalSizeH,normalSizeW,1),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.numberWithOptions(decimal: true),partiallapcontroller, "Partial Lap Distance(in m)",'',normalSizeH,normalSizeW,1),
                                ),
                                
                              ],
          
                            ),
                            
                             dataEntry(TextInputType.numberWithOptions(decimal: true),totallapcontroller, "Total Laps",'',normalSizeH,normalSizeW,1),
    
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              
                              children: [
                                 Padding(
                                  padding:  EdgeInsets.only(left:20.w,right: 20.w),
                                  child: Text("Test Time",style: TextStyle(fontSize: 15.sp), )
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.numberWithOptions(decimal: false,signed: false),totalmincontroller, "minutes",'minutes',smallsizeH,smallSizeW,1),
                                ),
                                 dataEntry(TextInputType.numberWithOptions(decimal: false,signed: false),totalseccontroller, "seconds",'seconds',smallsizeH,smallSizeW,1),
                                
                                
                              ],
          
                            ),
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              
                              children: [
                                 Padding(
                                  padding:  EdgeInsets.only(left:20.w,right: 10.w),
                                  child: Text("Time Taken",style: TextStyle(fontSize: 15.sp), )
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.numberWithOptions(decimal: false,signed: false),completionmincontroller, "",'minutes',smallsizeH,smallSizeW,1),
                                ),
                                 dataEntry(TextInputType.numberWithOptions(decimal: false,signed: false),completionseccontroller, "",'seconds',smallsizeH,smallSizeW,1),
                                
                                
                              ],
          
                            ),
    
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              
                              children: [
                                 Padding(
                                  padding:  EdgeInsets.only(left:20.w,right: 10.w),
                                  child: Text("Avg Lap time",style: TextStyle(fontSize: 15.sp), )
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.w),
                                  child: dataEntry(TextInputType.numberWithOptions(decimal: false,signed: false),avgmincontroller, "",'minutes',smallsizeH,smallSizeW,1),
                                ),
                                 dataEntry(TextInputType.numberWithOptions(decimal: false,signed: false),avgseccontroller, "",'seconds',smallsizeH,smallSizeW,1),
                                
                                
                              ],
          
                            ),
                            dataEntry( TextInputType.multiline,medications,"Medications Taken Before Test(if any)",'',enlargedSizeH,enlargedSizeW,-1),
                            dataEntry( TextInputType.multiline,symptoms, "Symptoms After Test(if any)",'',enlargedSizeH,enlargedSizeW,-1),
                            
                             dataEntry(TextInputType.multiline,stopReason, "Reason For Stopping Early(if stopped early)",'',enlargedSizeH,enlargedSizeW,-1),
                                ],
                            ) ,
                              
                          ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                          dateflag ==false?Text('Test Date : ${widget.date}',style: GoogleFonts.roboto(fontSize:15.sp),):
                          Text('Test Date : ${DateFormat.yMMMd().format(showdate)}',style: GoogleFonts.roboto(fontSize:15.sp),),
                          IconButton(onPressed: datebutton, icon: Icon(Icons.date_range)),
                        ],),
                        
                        ElevatedButton(onPressed: (){
                          save=true;
                          datakey.currentState!.validate();
                          if((save==true)){
                            confirm(context);
                          }
          
                          
                        }, child: Text("Submit")),
                        ],
                          
              
                  
              ),
            ),
          ),
          ),
      ),
    );
  }
}