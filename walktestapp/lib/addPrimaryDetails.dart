
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walktestapp/showprimarydetails.dart';
import 'models/primarydetails.dart';



class AddPrimaryDetails  extends StatefulWidget {

  static const pageid='addprimary';
 
  bool editcall;
  String tempid;
  AddPrimaryDetails(this.editcall,this.tempid);
  
  @override
  State<AddPrimaryDetails> createState() => _AddPrimaryDetailsState();
}

class _AddPrimaryDetailsState extends State<AddPrimaryDetails> {


  void initState(){
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      
      ]);
      super.initState();
  }

  List<PrimaryDetails>primarydetails=[];
  
  final namecontroller=TextEditingController();
  final numbercontroller=TextEditingController();
  final agecontroller=TextEditingController();
  final heightcontroller=TextEditingController();
  final weightcontroller=TextEditingController();
  
  String heightUnit='cm';
  String weightUnit='kg';  

  bool form=false;
  
  final datakey=GlobalKey<FormState>();
  
  void submitdetails(BuildContext ctx) async  {

    SharedPreferences prefs=await SharedPreferences.getInstance();
   
     primarydetails.clear();
     if(primarydetails.isEmpty && prefs.getString('primary')!=null ){

      String? detailsString=prefs.getString('primary');
      primarydetails=PrimaryDetails.decode(detailsString!);
     }
     
     if(widget.editcall==true){
        int index= primarydetails.indexWhere((element) => element.id==widget.tempid);
        primarydetails[index].name=namecontroller.text;
        primarydetails[index].age=agecontroller.text;
        primarydetails[index].height=double.parse(heightcontroller.text);
        primarydetails[index].weight=double.parse(weightcontroller.text);
        primarydetails[index].phoneNumber=numbercontroller.text;
        primarydetails[index].hunit=heightUnit;
        primarydetails[index].wunit=weightUnit;
        

     }else{
       primarydetails.add(PrimaryDetails(id: (DateTime.now()).toString(), 
       name: namecontroller.text,
       age: agecontroller.text, 
       height: double.parse(heightcontroller.text), 
       weight: double.parse(weightcontroller.text), 
       phoneNumber: numbercontroller.text,
       hunit:heightUnit,
       wunit:weightUnit,
       ));
     }
     print(heightUnit);
     print(weightUnit);
  final String encodedData = PrimaryDetails.encode(primarydetails);
  await prefs.setString('primary', encodedData);
  if(widget.editcall==true){
    Navigator.pop(context);
    
  }

  Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_)=> ShowPrimaryDetails()));

}

Widget dataEntry(double heigth, double width, TextInputType textInputType,TextEditingController controller ,String label){
    
    return 
       
            Container(
              height: heigth,
              width: width,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(1)),border: Border.all(color: Colors.black)),
              child: TextFormField(controller:controller,
                                textAlign: TextAlign.center,
                                keyboardType:textInputType,
                               
                                
                              decoration: InputDecoration(
                                  
                                  border: InputBorder.none,
                                 hintText: label
                                
                                ),
                              
                                validator: (val){
                                  if(numbercontroller.text.trim().isEmpty){
                                   
                                      numbercontroller.text='NA';
                                   
                                  }
                                  val=val!.trim();
                                  if(val.isEmpty){
                                    Fluttertoast.showToast(
                                      msg: "Some Information Are Missing",
                                      toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM ,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white
                                    );
                                    form=false;
                                    return ;
                                  }
                                  return null;
                                
                                },
                              ),
            );
  }
  

  void setOnEdit()async{
   
      SharedPreferences prefs=await SharedPreferences.getInstance();
        if(primarydetails.isEmpty && prefs.getString('primary')!=null ){

        String? detailsString=prefs.getString('primary');
        primarydetails=PrimaryDetails.decode(detailsString!);
     
        int index= primarydetails.indexWhere((element) => element.id==widget.tempid);
        setState(() {
          namecontroller.text=primarydetails[index].name;
        agecontroller.text=primarydetails[index].age;
        heightcontroller.text=primarydetails[index].height.toString();
        weightcontroller.text=primarydetails[index].weight.toString();
        numbercontroller.text=primarydetails[index].phoneNumber;
        heightUnit=primarydetails[index].hunit;
        weightUnit=primarydetails[index].wunit;
        });
         }
    }

  Widget dropdown(List<String> content,int unit){
    return DropdownButton<String>(
      value: unit==1?heightUnit:weightUnit,
      //icon: const Icon(Icons.arrow_downward),
     // iconSize: 24,
      //elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 1,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          unit==1?heightUnit = newValue! : weightUnit = newValue! ;
          
        });
      },
      items: 
         content.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
    

  @override
  Widget build(BuildContext context) {
   
    

    
    if(widget.editcall==true){
      setOnEdit();
    }
    
  
    return  GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child:
             SafeArea(
               child: Scaffold(
                   
                   appBar: AppBar(title: Text("Add Patient Details"),),
                     body:  Padding(
                         padding:  EdgeInsets.only(top:80.h),
                         child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                         
                           
                              Text("Fill the details of the Patient",style: GoogleFonts.balsamiqSans(fontSize:24)),
                            
                            Divider(height: 25.h,),
    
                             Form(
                               key: datakey,
                               child:  
                             Column(children: [
                            dataEntry(50.h,0.8.sw,TextInputType.name,namecontroller,"Name"),
    
                            
                             
                            Padding(
                              padding:  EdgeInsets.only(top:20.h,left: 22.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  
                                  Padding(
                                    padding:  EdgeInsets.only(right: 17.w),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                      dataEntry(50.h,0.25.sw,TextInputType.number,heightcontroller,"Height"),
                                      Padding(
                                        padding:  EdgeInsets.only(left:10.w),
                                        child: dropdown(['cm','ft'],1),
                                      ),
                                    ],)
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(right:1),
                                    child: Row(children: [
                                      dataEntry(50.h,0.25.sw,TextInputType.number,weightcontroller,"Weight"),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: dropdown(['kg','lb'],0),
                                      )
                                    ],)
                                  ),
                                ],
                              ),
                            ),
                          
                           Center(
                              child: Padding(
                                      padding:  EdgeInsets.only(top:20.h,bottom: 20.h),
                                      child: dataEntry(50.h,0.5.sw,TextInputType.number,agecontroller,"Age"),
                                  ),
                            ),
                        dataEntry(50.h,0.8.sw,TextInputType.name,numbercontroller,"Contact Number (optional)"),
                             ],),
                             ),
                          Divider(height: 50.h,),
                        Container(
                          
                          height: 50.h,
                          width:0.5.sw,
                          child: ElevatedButton(onPressed: (){
                            form=true;
                            if(datakey.currentState!.validate() && form==true)
                            submitdetails(context);
                            
                            }, 
                            
                            child: Text("Submit"))),
                                
    
                       
                    ],
                ),
                         ),
                       ),
                     ),
             ),
      );
    
  }
}