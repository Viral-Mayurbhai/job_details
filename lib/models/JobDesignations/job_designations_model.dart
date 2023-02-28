//
// class JobDesignations {
//   List<Jobdesignations>? jobdesignations;
//
//   JobDesignations({this.jobdesignations});
//
//   JobDesignations.fromJson(Map<String, dynamic> json) {
//     if (json['jobdesignations'] != null) {
//       jobdesignations = <Jobdesignations>[];
//       json['jobdesignations'].forEach((v) {
//         jobdesignations!.add(new Jobdesignations.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.jobdesignations != null) {
//       data['jobdesignations'] =
//           this.jobdesignations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Jobdesignations {
//   int? designationId;
//   String? designation;
//
//   Jobdesignations({this.designationId, this.designation});
//
//   Jobdesignations.fromJson(Map<String, dynamic> json) {
//     designationId = json['designation_id'];
//     designation = json['designation'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['designation_id'] = this.designationId;
//     data['designation'] = this.designation;
//     return data;
//   }
// }

class JobDetails {
  int designationId;
  String designation;

  JobDetails.fromJson(Map json)
      : designationId = json['designation_id'],
        designation = json['designation'];

  Map toJson() {
    return {'designation_id': designationId, 'designation': designation};
  }
}