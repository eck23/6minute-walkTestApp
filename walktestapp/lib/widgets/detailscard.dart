import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walktestapp/addPrimaryDetails.dart';
import 'package:walktestapp/showtestdetails.dart';

class  DetailsCard extends StatelessWidget {
  
   String title;
   String subtitle;
   String id;
   Function function;
   
  
  DetailsCard(this.id,this.title,this.subtitle,this.function);

  void openTest(BuildContext ctx)async{
     Navigator.of(ctx).push(MaterialPageRoute(builder: (_){return ShowTestDetails(id: id,name:title,);}));
  
}
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(leading: Icon(Icons.person),
              title: Text(title,style: GoogleFonts.roboto(fontSize: 15.sp,fontWeight: FontWeight.w500),),
              subtitle: subtitle!="NA" ?Text('Contact :$subtitle'):Text(""),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddPrimaryDetails(true,id))), icon: Icon(Icons.edit)),
                  IconButton( onPressed: ()=>function() ,icon:Icon(Icons.delete)),
                ],
              ),

              onTap: ()=>openTest(context),
              ),
              
              
    );
  }
}