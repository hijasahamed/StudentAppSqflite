import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';

File? image1;
String? image;

class AddStudent extends StatefulWidget {
  AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final GlobalKey<FormState> _validation = GlobalKey<FormState>();

  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student Details'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Form(
                  key: _validation,
                  child: Column(
                    children: [
        
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:image1 != null
                            ? FileImage(image1!)
                            :  AssetImage('images/circle avatar.png')
                            as ImageProvider,
                            radius: 70,
                          ),
                          Positioned(
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    fromgallery();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.deepPurple,
                                    size: 20,
                                  )),
                            ),
                            bottom: 0,
                            right: 0,
                          )
                        ],
                      ),
        
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter your name';
                          }
                        },
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.abc),
                            border: OutlineInputBorder(),
                            labelText: 'Name'),
                        textCapitalization: TextCapitalization.words,    
                      ),
        
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter your age';
                          }
                        },
                        controller: _agecontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month),
                            border: OutlineInputBorder(),
                            labelText: 'Age'),
                      ),
       
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter your address';
                          }
                        },
                        controller: _addresscontroller,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.place),
                            border: OutlineInputBorder(),
                            labelText: 'Address'
                          ),
                          textCapitalization: TextCapitalization.words,
                      ),
        
        
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty||value.length!=10) { 
                            return 'Please eneter a valid phone number';
                          }
                        },
                        controller: _mobilecontroller,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '+91 ', 
                          prefixStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          suffixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          labelText: 'Mobile',
                        ),
                      ),
        
        
                    ],
                  )
                ),
        
              SizedBox(height: 25),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: Size(360, 45 )),
                  onPressed: () {
                    onSubmitButtonClicked(context);
                  },                 
                  icon: Icon(Icons.check),
                  label: Text('Submit')
              ),

            ],
          ),
        ),
      )),
    );
  }



  Future<void> onSubmitButtonClicked(BuildContext context) async{
    final _name=_namecontroller.text.trim();
    final _age=_agecontroller.text.trim();
    final _address=_addresscontroller.text.trim();
    final _mobile=_mobilecontroller.text.trim();

    if(_validation.currentState!.validate()&&image1!=null){
      final _student= Studentmodel(name: _name, age: _age, address: _address, mobile: _mobile, image: image!);
      await addStudent(_student);
     
      Navigator.of(context).pop();
      clearStudentProfilephoto();
      submitbuttondetailsok(_name); 
    }
    else if(_validation.currentState!.validate()&&image1==null){
      submitbuttondetailnotok(); 
    }
  } 


  Future<void> fromgallery() async {
    final img1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img1 != null) {
      setState(() {
        image1 = File(img1.path);
        image = image1!.path;
      });
    }
  }

  clearStudentProfilephoto() {
    _namecontroller.text = '';
    _agecontroller.text = '';
    _addresscontroller.text = '';
    _mobilecontroller.text = '';
    setState(() {
      image1 = null;
    });
  }

  submitbuttondetailsok(data){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor:  Color.fromARGB(255, 30, 189, 22),
          margin: const EdgeInsets.all(50),
          content: Text(
            '${data} Details Submitted', 
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
  }

  submitbuttondetailnotok(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor:  Color.fromARGB(255, 244, 70, 70),
          margin: const EdgeInsets.all(50),
          content: Text(
            'Please Add Student Identity Photo',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
  }

}
