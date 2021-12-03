import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walktestapp/TestDetailsFilling.dart';
import 'package:walktestapp/models/testdetails.dart';


class TestDetailsCardLandScape extends StatelessWidget {
  
  final TestDetails testDetails;
  final String number;
  final String testid;
  final String name;
  final BuildContext context;
  final Function function;
  
  TestDetailsCardLandScape({required this.testDetails,required this.number,required this.testid,required this.name,required this.context,required this.function}); 


  void showDetailedViewPortrait(){
    showDialog(context: context, builder:(ctx){
      return  
        
        Builder(
          builder: (context) {
            return AlertDialog(
                scrollable: true,
            
                contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                content: Container(
                  height:500.h ,
                  width: 0.7.sw,
                  
                  child: ListView(
                    
                    children:[ 
                      Text("Test Details",style: TextStyle(fontSize: 50.sp),),
                      Padding(
                        padding:  EdgeInsets.only(top:20.h,bottom: 20.h),
                        child: Text("Test Date : ${testDetails.date} ",style: TextStyle(fontSize: 25.sp),),
                      ),
                      DataTable( 
            
                        columns: [  
                          DataColumn(label: Text(  
                              '',  
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)  
                          )),  
                          DataColumn(label: Text(  
                              'PreTest',  
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)  
                          )),  
                          DataColumn(label: Text(  
                              'EndTest',  
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)  
                          )),  
                        ],  
                        rows: [  
                          DataRow(
                            
                            cells: [  
                            DataCell(Text("BP\n(mmHg)")),  
                            DataCell(Text(testDetails.BP_before)),  
                            DataCell(Text(testDetails.BP_after)),  
                          ]),  
                          DataRow(cells: [  
                            DataCell(Text("HR\n(bpm)")),  
                            DataCell(Text(testDetails.HR_before)),  
                            DataCell(Text(testDetails.HR_after)),  
                          ]),  
                          DataRow(cells: [  
                            DataCell(Text("RR\n(bpm)")),  
                            DataCell(Text(testDetails.RR_before)),  
                            DataCell(Text(testDetails.RR_after)),  
                          ]),  
                          DataRow(cells: [  
                            DataCell(Text("SpO${'\u2082'}\n(%)")),  
                            DataCell(Text(testDetails.SPO2_before)),  
                            DataCell(Text(testDetails.SPO2_after)),  
                          ]),
                           DataRow(cells: [  
                            DataCell(Text("Dyspnea\n(Borg)")),  
                            DataCell(Text(testDetails.dyspnea_before)),  
                            DataCell(Text(testDetails.dyspnea_after)),  
                          ]),
                           DataRow(cells: [  
                            DataCell(Text("Fatigue\n(Borg)")),  
                            DataCell(Text(testDetails.fatigue_before)),  
                            DataCell(Text(testDetails.fatigue_after)),  
                          ])
                        ]),
                    
                     Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Test Time: ${testDetails.test_duration} min"),
                   ),
            
                    Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Test Completion Time: ${testDetails.completion_time} min"),
                   ),
            
                   Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("One lap distance: ${testDetails.oneLapDistance} m"),
                   ),
            
                    Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Total Laps : ${testDetails.total_laps}"),
                   ),
            
                   Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Partial Lap Distance : ${testDetails.partial_lap_distance} m"),
                   ),
            
                   Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Total Distance Covered : ${testDetails.total_covered_diatance} m"),
                   ),
            
                   Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Average Lap Time : ${testDetails.averagelap} min"),
                   ),
            
                   Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Medications Taken : ${testDetails.MedicationsTaken}"),
                   ),
            
                    Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Symptoms : ${testDetails.Symptoms_after}"),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top: 20.h),
                     child: Text("Stop Reason: ${testDetails.StopReason}"),
                   ),
            
                   
                   ]
                    )
                    ),
               
      );
          }
        );
    
    });
  }
  
 
  @override
  Widget build(BuildContext context) {
   
    
    return Card(
      child: ListTile(leading: Text("#$number"),
      title: Text("Test Date : ${testDetails.date}"),
      onTap: ()=>  showDetailedViewPortrait(),
      trailing:  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TestDetailsForm(testid,testDetails.id,name,testDetails.date))), icon: Icon(Icons.edit)),
                  IconButton( onPressed: ()=>function() ,icon:Icon(Icons.delete)),
                ],
              ),
      
      ),
    
    ) ;
  }
}