import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileSaveAndStorage extends StatefulWidget {
  const FileSaveAndStorage({super.key});

  @override
  State<FileSaveAndStorage> createState() => _FileSaveAndStorageState();
}

class _FileSaveAndStorageState extends State<FileSaveAndStorage> {


  Future<void> saveText(String textToSave) async {
    try {
      // Get the documents directory
      Directory? externalStorageDirectory = await getApplicationDocumentsDirectory();

      Directory folder = Directory('${externalStorageDirectory.path}/SMG');
      await folder.create();
      // Specify the file path
      String filePath = '${folder.path}/text_file.txt';

      // Create a File object
      File file = File(filePath);

      // Write the text to the file
      await file.writeAsString(textToSave);

      print('Text has been saved to the file.');
    } catch (e) {
      print('Error saving text to file: $e');
    }
  }

  Future<void> internal(String textToSave) async {
    try {
      // Get the documents directory
      Directory? externalStorageDirectory = await getExternalStorageDirectory();

      Directory folder = Directory('${externalStorageDirectory?.path}/SMG');
      await folder.create();
      // Specify the file path
      String filePath = '${folder.path}/text_file.txt';

      // Create a File object
      File file = File(filePath);

      // Write the text to the file
      await file.writeAsString(textToSave);

      print('Text has been saved to the file.');
    } catch (e) {
      print('Error saving text to file: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("App Information Save"),

      ),
      body:Column(
        children: [
          ElevatedButton(onPressed: (){
            saveText("App Infomation");
          }, child:Text("Save")),


        ElevatedButton(onPressed: (){
            saveText("Internal");
          }, child:Text("Save"))





        ],
      ),
    );
  }
}
