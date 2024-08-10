import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_scanner/pages/Documents%20page/widgets/search_bar.dart';

import 'widgets/document_appbar.dart';

class DocumentScreen extends StatefulWidget {
  final String? imagePath;

  const DocumentScreen({super.key, this.imagePath});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<String> items = ['Sort by date', 'Sort by week', 'Sort by month'];
  String? selectedValue;

  List<File> _files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
    // List<File> file = _files.map((path) => File(path)).toList();
    // Call the function to load files in initState
  }

  // Function to load files from the directory
  Future<void> _loadFiles() async {
    final directoryPath = '/data/user/0/com.example.pdf_scanner/app_flutter';
    List<File> files = await getFilesInDirectory(directoryPath);
    print(files);

    setState(() {
      _files = files; // Update the state with the loaded files
    });
  }

  // Function to get files in the directory
  Future<List<File>> getFilesInDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);

    if (await directory.exists()) {
      final List<FileSystemEntity> entities = await directory.list().toList();
      final List<File> files = entities.whereType<File>().toList();
      return files;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // String imageName = widget.imagePath.split('/').last;

    return Scaffold(
        backgroundColor: Colors.white,
        body: _files.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DocumentAppBar(),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Documents",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const CustomSearchBar(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        hint: const Text('Sort..'),
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
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Today",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _files.length,
                        itemBuilder: (context, index) {
                          final file = _files[index];
                          return Container(
                            margin: const EdgeInsets.only(top: 5),
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
                                    border: Border.all(
                                        color: const Color(0xff9694FF))),
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Image.file(file),
                                  // child: Text(
                                  //   ".pdf",
                                  //   style: TextStyle(color: Color(0xff9694FF)),
                                  // ),
                                ),
                              ),
                              title: Text(
                                // imageName
                                //  ??
                                file.path.split('/').last,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                "11 Pages",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff9694FF)),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.star,
                                    color: Color(0xff9694FF),
                                  )),
                            ),
                          );
                        })
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
