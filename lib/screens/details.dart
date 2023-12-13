import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/db/model/db_model.dart';

class Details extends StatelessWidget {
  final studentdetails;
  const Details({super.key,required Studentmodel this.studentdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Text(
              'Details',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    
      body: SafeArea(
        child: Container(
          height: 400 ,
          width: double.infinity,
          child: Card(
            color: Colors.amber[200],
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(             
              children: [
                SizedBox(
                height: 40,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(studentdetails.image)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Name :${studentdetails.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900
                  ,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Age :${studentdetails.age}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Phone no :${studentdetails.address}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Place :${studentdetails.mobile}',
                textAlign: TextAlign.center, 
                style: const TextStyle(
                    color: Colors.black, 
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
              ],
            ),
          ),
        )
      ),
    );
  }
} 