import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/db/model/db_model.dart';

ValueNotifier<List<Studentmodel>> studentlistNotifier = ValueNotifier([]);


late Database _db;


Future<void> initializeDatabase()async{
  _db= await openDatabase(
    'student.db',
    version: 1,
    onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE student(id INTEGER PRIMARY KEY ,name TEXT,age TEXT,address TEXT,mobile TEXT,image TEXT)');
    }
  );
}


Future<void> addStudent(Studentmodel value) async{
  await _db.rawInsert('INSERT INTO student(name,age,address,mobile,image)VALUES(?,?,?,?,?)',[value.name,value.age,value.address,value.mobile,value.image]);
  getAllStudents();  
}


Future<void> getAllStudents() async{
 final _values= await  _db.rawQuery('SELECT * FROM student'); 
 print(_values);
  studentlistNotifier.value.clear();
 _values.forEach((map) { 
  final student= Studentmodel.fromMap(map);
  studentlistNotifier.value.add(student);
 });
 studentlistNotifier.notifyListeners();
}


Future<void> deleteStudent(int id) async{
  await _db.delete("student",where: "id=?",whereArgs: [id]); 
  getAllStudents();
}


Future<void> updateStudent(int id,String name,String age,String address,String mobile,String image ) async{
  final data= {
    'name' : name,
    'age': age,
    'address' : address,
    'mobile' : mobile,
    'image' : image
  };
  await _db.update("student",data,where: 'id=?',whereArgs: [id]);  
  getAllStudents();
}
