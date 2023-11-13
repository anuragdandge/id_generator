import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  @override
  void initState() {
    super.initState();
    _getAllStudents();
  }

  late List<Map<String, dynamic>> allStudents = [];
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Students  "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.black45),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.purple[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Name",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              " Phone Number ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              " PRN Number  ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          content: Text("Student's info"),
                        ),
                      );
                    },
                    child: const Text("View Full Profile "),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getAllStudents() async {
    var collection = FirebaseFirestore.instance.collection('students');
    var data = await collection.get();

    late List<Map<String, dynamic>> tempList = [];
    for (var element in data.docs) {
      tempList.add(element.data());
    }
    print(tempList);
    setState(() {
      allStudents = tempList;
      isLoaded = true;
    });
  }
}
