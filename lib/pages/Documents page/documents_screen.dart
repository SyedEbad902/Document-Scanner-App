import 'package:flutter/material.dart';

import '../Home/home_screen.dart';
import 'widgets/document_appbar.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<String> items = ['Sort by date', 'Sort by week', 'Sort by month'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DocumentAppBar(),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Documents",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            CustomSearchBar(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton<String>(
                value: selectedValue,
                hint: Text('Sort..'),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Today",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 5),
                    // padding: EdgeInsets.only(top: 8),
                    height: 73,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all()),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      leading: Container(
                        // padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff9694FF))),
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Text(
                            ".pdf",
                            style: TextStyle(color: Color(0xff9694FF)),
                          ),
                        ),
                      ),
                      title: Text(
                        "Brief-task-today.pdf",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "11 Pages",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff9694FF)),
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.star,
                            color: Color(0xff9694FF),
                          )),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
