import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walktestapp/addPrimaryDetails.dart';


import 'showprimarydetails.dart';




class HomePage extends StatefulWidget {

   
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState(){
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      ]);
      super.initState();
  }
   void clickOnAdd(BuildContext ctx)async{
     bool value = await  Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=> AddPrimaryDetails(false,'1')));
     if(value)
        initState();
    }

    void clickOnTest(BuildContext ctx)async{   
          
      bool value=await Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=> ShowPrimaryDetails()));
      if(value)
      initState();
    }

  showinfo (BuildContext ctx){
      return showDialog(context: ctx, builder:(ctx){
      return AlertDialog(
        title: Text ("Developer Info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          
          Padding(
            padding: const EdgeInsets.only(top:1,bottom: 2),
            child: Text("Name: Elson C Kaithamangalam "),
          ),
          Padding(
            padding: const EdgeInsets.only(top:2),
            child: TextButton(onPressed: _launchEmail,child: Text("Email: elsonck23@outlook.com"),),
          ),
          TextButton(onPressed: _launchURL,child: Text("Linkedin Profile")),
        ],),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(ctx).pop();
          }, child: Text("Ok")),
          
        ],
      );
    });
  }

  _launchEmail() async {
    launch(
        "mailto:elsonck23@outlook.com?subject=Feedback");
  }

  _launchURL() async {
    const url = 'https://www.linkedin.com/in/elson-c-kaithamangalam-15ba581b1/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    
     
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(title: Text("6:00 Walk"),backgroundColor: Colors.orange,
        actions: [IconButton(onPressed: ()=>showinfo(context), icon: Icon(Icons.info))],),
        body: Stack(
        
          
          children: [
            
              Padding(
                padding:  EdgeInsets.only(top:0.02.sh,),
                child: Image(
                     

                image: AssetImage("images/walkapplogo.png"),
                   color: Colors.orangeAccent,
                   
                   height:450.h),
              ),
              
                
          Padding(
            padding:  EdgeInsets.only(top: 0.45.sh),
            child: Column(
              children: [
                Text("Welcome to Walk Test",
                      style: GoogleFonts.asap(fontSize: 30.sp,fontWeight: FontWeight.bold,color: Colors.black)
                        ),
                      Divider(height: 50.h,color: Theme.of(context).primaryColor,),
                    Container(
                      height: 40.h,
                      width: 0.6.sw,
                      child: ElevatedButton(
                            
                        style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w),
                        
                        )
                   )
                      ),
                        onPressed:()=>clickOnAdd(context),
                        child:Text("Add New ",style: GoogleFonts.openSans(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.black),)
                      ),
                    ),
                  Divider(height: 30.h,color: Theme.of(context).primaryColor,) , 
            Container(
               height: 40.h,
               width: 0.6.sw,
               
              child: ElevatedButton(
                            
                        style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.circular(20.w),
                        
                        )
                     )
                      ),
                        onPressed:()=>clickOnTest(context),
                        child:Text("Take Test ",style: GoogleFonts.openSans(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.black),)
                      ),
            ),
              ],
            ),
          ),
              
            
            
    
      
            
          ],
        ),
      ),
    );
  }
}