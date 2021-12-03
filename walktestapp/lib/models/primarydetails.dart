

import 'dart:convert';

class PrimaryDetails{
  String id;
  String name;
  String age;
  String phoneNumber;
  double weight;
  double height;
  String hunit;
  String wunit;

  PrimaryDetails({required this.id,required this.name,required this.age,required this.height,required this.weight,required this.hunit,required this.wunit,required this.phoneNumber,});

  

  factory PrimaryDetails.fromJson(Map<String, dynamic> jsonData) {
    return PrimaryDetails(
      id: jsonData['id'],
      name: jsonData['name'],
      age: jsonData['age'],
      height: jsonData['height'],
      weight: jsonData['weight'],
      phoneNumber: jsonData['phonenumber'],
      hunit: jsonData['hunit'],
      wunit: jsonData['wunit'],
      

     
    );
  }
  
  
  static Map<String, dynamic> toMap(PrimaryDetails primaryDetails) => {
        'id': primaryDetails.id,
        'name': primaryDetails.name,
        'age' :primaryDetails.age,
        'height':primaryDetails.height,
         'weight':primaryDetails.weight,
         'phonenumber':primaryDetails.phoneNumber,
         'hunit':primaryDetails.hunit,
         'wunit':primaryDetails.wunit
         
      };

  static String encode(List<PrimaryDetails> primarydetails) => json.encode(
        primarydetails
            .map<Map<String, dynamic>>((primarydetail) => PrimaryDetails.toMap(primarydetail))
            .toList(),
            

           
      );

  static List<PrimaryDetails> decode(String primarydetails) =>
      (json.decode(primarydetails) as List<dynamic>)
          .map<PrimaryDetails>((item) => PrimaryDetails.fromJson(item))
          .toList();
}
