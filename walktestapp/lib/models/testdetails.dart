import 'dart:convert';

class TestDetails{
   String id;
   String BP_before;
   String BP_after;
   String HR_before;
   String HR_after;
   String RR_before;
   String RR_after;
 
   String SPO2_before;
   String SPO2_after;
   String dyspnea_before;
   String dyspnea_after;
   String fatigue_before;
   String fatigue_after;
   String test_duration;  
   String oneLapDistance;
   String total_laps;
   String partial_lap_distance;
   String total_covered_diatance; 
   bool Stopped_before;
   String StopReason;
   String Symptoms_after;
   String MedicationsTaken;
   String testid;
   String completion_time;
   String averagelap;
   String date;

  TestDetails(
    {required this.id,
      required this.testid,
      required this.date,
     required this.BP_before,
     required this.BP_after,
     required this.HR_before,
     required this.HR_after,
     required this.RR_before,
     required this.RR_after,
     required this.SPO2_before,
     required this.SPO2_after,
     required this.dyspnea_before,
     required this.dyspnea_after,
     required this.fatigue_before,
     required this.fatigue_after,
     required this.Stopped_before,
     required this.StopReason,
     required this.MedicationsTaken,
     required this.Symptoms_after,
     required this.test_duration,
     required this.completion_time,
     required this.oneLapDistance,
     required this.total_laps,
     required this.total_covered_diatance,
     required this.partial_lap_distance,
     required this.averagelap,
    
    });


    factory TestDetails.fromJson(Map<String, dynamic> jsonData) {
    return TestDetails(
      id: jsonData['id'],
      testid: jsonData['testid'],
      date: jsonData['date'],
      BP_after: jsonData['BP_after'],
      BP_before: jsonData['BP_before'],
      HR_after: jsonData['HR_after'],
      HR_before: jsonData['HR_before'],
      RR_after: jsonData['RR_after'],
      RR_before: jsonData['RR_before'],
      SPO2_after: jsonData['SPO2_after'],
      SPO2_before: jsonData['SPO2_before'],
      dyspnea_after: jsonData['dyspnea_after'],
      dyspnea_before: jsonData['dyspnea_before'],
      fatigue_after: jsonData['fatigue_after'],
      fatigue_before: jsonData['fatigue_before'],
      MedicationsTaken: jsonData['Medication_taken'],
      Stopped_before: jsonData['stopped_before'],
      StopReason: jsonData['stop_reason'],
      Symptoms_after: jsonData['symptoms_after'],
      oneLapDistance: jsonData['oneLapDistance'],
      partial_lap_distance: jsonData['partialLapDistance'],
      test_duration: jsonData['testDuration'],
      completion_time: jsonData['completion_time'],
      total_covered_diatance: jsonData['total_covered_distance'],
      total_laps: jsonData['total_laps'],
      averagelap: jsonData['averagelaps'],


      

     
    );
  }
  
  
  static Map<String, dynamic> toMap(TestDetails testDetails) => {
      'id': testDetails.id,
      'testid':testDetails.testid,
      'date':testDetails.date,
      'BP_after':testDetails.BP_after,
      'BP_before':testDetails.BP_before,
      'HR_after':testDetails.HR_after,
      'HR_before':testDetails.HR_before,
      'RR_after':testDetails.RR_after,
      'RR_before':testDetails.RR_before,
      'SPO2_after':testDetails.SPO2_after,
      'SPO2_before':testDetails.SPO2_before,
      'dyspnea_after':testDetails.dyspnea_after,
      'dyspnea_before':testDetails.dyspnea_before,
      'fatigue_after':testDetails.fatigue_after,
      'fatigue_before':testDetails.fatigue_before,
      'Medication_taken':testDetails.MedicationsTaken,
      'stopped_before': testDetails.Stopped_before,
      'stop_reason': testDetails.StopReason,
      'symptoms_after':testDetails.Symptoms_after,
      'oneLapDistance':testDetails.oneLapDistance,
      'partialLapDistance':testDetails.partial_lap_distance,
      'testDuration':testDetails.test_duration,
      'completion_time':testDetails.completion_time,
      'total_covered_distance':testDetails.total_covered_diatance,
      'total_laps':testDetails.total_laps,
      'averagelaps':testDetails.averagelap,

        
         
      };

  static String encode(List<TestDetails> testdetails) => json.encode(
        testdetails
            .map<Map<String, dynamic>>((testdetails) => TestDetails.toMap(testdetails))
            .toList(),
            

           
      );

  static List<TestDetails> decode(String testdetails) =>
      (json.decode(testdetails) as List<dynamic>)
          .map<TestDetails>((item) => TestDetails.fromJson(item))
          .toList();

}