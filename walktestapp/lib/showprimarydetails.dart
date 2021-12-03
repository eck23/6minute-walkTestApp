import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walktestapp/addPrimaryDetails.dart';
import 'package:walktestapp/models/primarydetails.dart';
import 'package:walktestapp/models/testdetails.dart';

import 'package:walktestapp/widgets/detailscard.dart';

class ShowPrimaryDetails extends StatefulWidget{

  

  @override
  State<ShowPrimaryDetails> createState() => _ShowPrimaryDetailsState();
}

class _ShowPrimaryDetailsState extends State<ShowPrimaryDetails> {
  List<PrimaryDetails> templist=[];
  List<PrimaryDetails> searchlist=[];
  final _searchkey=GlobalKey<FormState>();
  final searchController= TextEditingController();

  void initState(){
    
      getdata();
      print('in init');
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      ]);
      
    }

   void getdata() async{

      SharedPreferences prefs=await SharedPreferences.getInstance();
      setState(() {
        templist.clear();
          if(prefs.getString('primary')!=null){
          String? detailsString=prefs.getString('primary');
          templist=PrimaryDetails.decode(detailsString!) ;
           
        }
    });
    
      
  }
  void clearall()async{
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
     setState(()   {
                  
                 sharedPreference.remove('primary');
                 sharedPreference.remove('test');
                 templist.clear();
                
          });
}

void clearSpecific(String id)async{
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  List<TestDetails> temp=[];
        
        
        if(prefs.getString('primary')!=null){
          String? detailsString=prefs.getString('primary');
          templist=PrimaryDetails.decode(detailsString!);
          templist.removeWhere((element) => element.id==id);
            
        }
        if(prefs.getString('test')!=null){
            String? detailsString=prefs.getString('test');
             temp=TestDetails.decode(detailsString!);
            temp.removeWhere((element) => element.id==id);

            
        }
         
    final String primaryEncodedData = PrimaryDetails.encode(templist);
   await prefs.setString('primary', primaryEncodedData);
   final String encodedData = TestDetails.encode(temp);
   await prefs.setString('test', encodedData);

    searchController.clear();
    print('setstate finish');
    getdata();
      
}   
       
               

void alert (String text,Function function,BuildContext ctx){
      showDialog(context: ctx, builder:(ctx){
      return AlertDialog(
        title: Text (text),
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

  void confirm(String val){
        alert("Are you sure to delete all ?",clearall,context);
  }

   
  @override
  Widget build(BuildContext context)  {
         Future<bool> _willPopCallback() async {
          Navigator.pop(context);
          return true; 
        }
      return WillPopScope(onWillPop: _willPopCallback,
        child: GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: 
               Scaffold(
                appBar: AppBar(title: Text("Patient List"),actions: [PopupMenuButton(
                    onSelected: confirm,
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (context)=>
                        [PopupMenuItem<String>(child: Text("Delete All"),value: 'deleteAll')])]
                ,),
                body: SingleChildScrollView(
                  child: 
                   Column(
                    children: [
                      Divider(height: 20.h,),
                      Form(
                        key: _searchkey,
                        child: Container(
                          height: 50.h,
                          width: 70.sw,
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding:  EdgeInsets.only(left: 25.w),
                            child: TextFormField(
                              
                                controller: searchController,
                                textAlign: TextAlign.left,
                                
                                
                                onChanged: (value){
                                  setState(() {
                                    searchlist= templist.where((element)=>element.name.toLowerCase().contains(value.toLowerCase())).toList();
                                  });
                                },
                                style: TextStyle(color: Colors.white,fontSize: 15.w),
                                decoration: InputDecoration(hintText: "Search by name",
                                hintStyle: TextStyle(color: Colors.white,fontSize: 15.w), 
                                border: InputBorder.none,
                                
                                ),
                              ),
                          ),
                        ),
                        ),
                    Divider(height: 20.h,),
                    Container(height: 500.h,
                        padding: EdgeInsets.only(),
                              
                              child: templist.isEmpty?Text("Nothing to show"):ListView.builder(itemBuilder: (context,index){
                                return searchController.text.isEmpty?DetailsCard(
                                  templist[index].id, 
                                  templist[index].name, 
                                  templist[index].phoneNumber,
                                  //()=>clearSpecific(templist[index].id),
                                  ()=>alert('Are you sure to delete ${templist[index].name}',()=>clearSpecific(templist[index].id),context),
                                  
                                  ):DetailsCard(
                                  searchlist[index].id,
                                  searchlist[index].name,
                                  searchlist[index].phoneNumber,
                                  //()=>clearSpecific(templist[index].id),
                                 ()=> alert('Are you sure to delete ${searchlist[index].name}',()=>clearSpecific(searchlist[index].id),context),
                                 
                                 
                                );
                              },itemCount: searchController.text.isEmpty?templist.length:searchlist.length,)),
                      
                   
                    ],
                  
               ),), 
               floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
             floatingActionButton: FloatingActionButton(onPressed: ()async{
               
              bool value= await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>AddPrimaryDetails(false,'1')),);
              if(value)
              initState();
              },
             
             child: Icon(Icons.add),
             backgroundColor: Colors.orange,),
            )
          )),
      );
  
  
}
}