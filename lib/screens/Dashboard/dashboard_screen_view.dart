
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_details/api/job_designations_api.dart';
import 'package:job_details/models/JobDesignations/job_designations_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  http.Response? resp;
  var data;
  List<JobDetails> jobList = [];
  TextEditingController? jobDescription;
  List<String> jobDesigna = [];
  String jobDesignationStr = '';

  // Future<void> apiCalling() async {
  //   try {
  //     resp = await http.get(
  //       Uri.parse('https://devstaticapi.hire22.co/v1/jobdesignations'),
  //     );
  //
  //     if(resp!=null) {
  //       var dt = json.decode(resp!.body);
  //       data = dt['jobdesignations'];
  //       print(data);
  //       print(data[0]['designation']);
  //     }
  //
  //   } catch (e) {
  //     print("Response: ${resp!.body}");
  //   }
  //
  // }

  void getJobDetailsfromApi() async {
    JobDetailsApi.getJobDetails().then((response) {
      setState(() {
        data = json.decode(response.body);
        print(data);
        Iterable list = data['jobdesignations'];
        jobList = list.map((model) => JobDetails.fromJson(model)).toList();
        for(int i=0; i<jobList.length; i++) {
          jobDesigna.add(jobList[i].designation);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    jobDescription = TextEditingController();
    Future.delayed(const Duration(seconds: 5),() {
      setState(() {
        getJobDetailsfromApi();
        // print(data);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Job Title",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  DropdownSearch(
                    // selectedItem: jobDesigna[0],
                    showSelectedItems: true,
                    items: jobDesigna,
                    showSearchBox: true,
                    mode: Mode.MENU,
                    onChanged: (item) {
                      jobDesignationStr = item.toString();
                    },
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description Yourself",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  TextFormField(
                    controller: jobDescription,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      // hoverColor: Colors.white,
                      // fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.blue.withOpacity(0.2),
                            width: 2,
                          ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      // focusColor: bhagwa,
                      counterText: "${200 - jobDescription!.text.length}/200",
                    ),
                    maxLength: 200,
                  ),
                ],
              ),

            ),

            const SizedBox(height: 40.0,),

            Container(
              margin: const EdgeInsets.all(12.0),
              child: FlatButton(
                height: 50,
                color: Colors.black87,
                minWidth: MediaQuery.of(context).size.width,
                colorBrightness: Brightness.dark,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Submitted!")),
                  );
                  print(jobDescription!.text);
                },
                child: const Text('SUBMIT',style: TextStyle(fontSize: 20.0),),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

//         ListView.builder(
//           itemCount: jobList.length,
//           physics: const ScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(jobList[index].designation.toString()),
//               subtitle: Text(jobList[index].designationId.toString()),
//             );
//           }
//         ),

// TextFormField(
//   controller: jobDesign,
//   decoration:InputDecoration(
//     border:InputBorder.none,
//     prefix: DropdownButtonFormField<String>(
//
//         decoration: InputDecoration.collapsed(
//           hintText: 'select',
//           hintStyle: TextStyle(fontSize: 12,color: Colors.grey.shade600),
//         ),
//         value: type,
//         validator: (value) => value == null? 'please select': null,
//         onChanged: (String? newValue) {
//           setState(() {
//             type = newValue;
//           });
//         },
//         items: jobList.map((item){
//           return DropdownMenuItem(
//             onTap: (){
//               type=item['city'];
//               // print(selectedCity);
//             },
//             value: item['id'].toString(),
//             child: Padding(
//               padding: const EdgeInsets.only(left:15.0,top: 13.0),
//               child: Text(item['city'],style: TextStyle(fontSize: 12,color: Colors.grey.shade600),),
//             ),
//           );
//         }).toList(),
//     ),
//   ),
// ),

// DropdownSearch(
//   items: jobDesigna,
//   onChanged: (items) {
//     print(items);
//   },
// ),
