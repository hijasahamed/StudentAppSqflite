import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';
import 'package:student_app/screens/addstudent.dart';
import 'package:student_app/screens/homescreen.dart';



class EditStudent extends StatefulWidget {

  final student;
  
  const EditStudent({super.key, required Studentmodel this.student});

  @override
  State<EditStudent> createState() => EditStudentState();
}



class EditStudentState extends State<EditStudent> {

  final GlobalKey<FormState> _validation = GlobalKey<FormState>();

  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();


  @override
 void initState() {
   _namecontroller.text = widget.student.name;
   _agecontroller.text = widget.student.age;
   _addresscontroller.text = widget.student.address;
   _mobilecontroller.text = widget.student.mobile;
    super.initState();
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
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
                            : FileImage(File(widget.student.image)),
                            radius: 60,
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


                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter a value';
                          }
                        },
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.abc),
                            border: OutlineInputBorder(),
                            labelText: 'Name'),
                      ),


                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter a value';
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


                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter a value';
                          }
                        },
                        controller: _addresscontroller,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.place),
                            border: OutlineInputBorder(),
                            labelText: 'Address'),
                      ),


                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please eneter a value';
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

              SizedBox(height: 15),
              ElevatedButton.icon(
                  onPressed: () {
                    onUpdateButtonClicked(context,widget.student.id);
                  },                 
                  icon: Icon(Icons.check),
                  label: Text('Update')),
            ],
          ),
        ),
      )),
    );
  }

   Future<void> onUpdateButtonClicked(BuildContext context,id) async{
    final _name=_namecontroller.text.trim();
    final _age=_agecontroller.text.trim();
    final _address=_addresscontroller.text.trim();
    final _mobile=_mobilecontroller.text.trim();
   

    if(_validation.currentState!.validate() ){
      final _student= await Studentmodel(name: _name, age: _age, address: _address, mobile: _mobile, image: image!);
      updateStudent(id, _name, _age, _address, _mobile,image!); 
      Navigator.of(context).pop();
      updatedsuccessfully();
      clearStudentProfile();  
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

  clearStudentProfile() {
    _namecontroller.text = '';
    _agecontroller.text = '';
    _addresscontroller.text = '';
    _mobilecontroller.text = '';
    setState(() {
      image1 = null;
    });
    // image=null;
  }

  updatedsuccessfully(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor:  Colors.blue,
          margin: const EdgeInsets.all(50),
          content: Text(
            'Updated',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
  }

}

