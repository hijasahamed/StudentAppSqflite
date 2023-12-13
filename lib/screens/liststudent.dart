import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';
import 'package:student_app/screens/details.dart';
import 'package:student_app/screens/editstudent.dart';



class ListStudent extends StatefulWidget {
  const ListStudent({super.key});

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:Color.fromARGB(255, 216, 220, 217), ),
      child: ValueListenableBuilder(
        valueListenable: studentlistNotifier, 
        builder: (BuildContext ctx,List<Studentmodel>studentList,Widget? child){
    /*      return ListView.separated(
            itemBuilder: (ctx,index){
              final data= studentList[index];
              return Card(
                color: Colors.deepPurple ,
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ListTile(                      
                      leading: CircleAvatar(
                        radius: 30 ,
                        backgroundImage: FileImage(File(data.image)),            
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name:${data.name}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                          Text('Age:${data.age}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                          Text('Address:${data.address}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                          Text('Mobile:+91 ${data.mobile}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),                       
                        ],
                      ),
                      trailing: SizedBox(                       
                        width: 96 ,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditStudent(student: data);}));
                            }, 
                            icon: Icon(Icons.edit,color: Colors.green,)
                          ),
                            IconButton(onPressed: (){deletebuttonclicked(data.id!);}, icon: Icon(Icons.delete,color: Colors.red,)) 
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context){return Details(studentdetails: studentList);}));
                      },        
                    ),
                  ],
                ),
              );
              
            },
            separatorBuilder: (ctx,index){
              return SizedBox(height: 3,); 
            }, 
            itemCount: studentList.length,
          );
    */     
          return Container(
            width: 400 ,
            child: GridView.builder(
              itemCount: studentList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5
                ),
              itemBuilder: (ctx,index){
                final data=studentList[index];
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.deepPurple),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(data.image)),
                        ),
                        trailing: SizedBox(                       
                          width: 96 ,
                          child: Row(
                            children: [
                            IconButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditStudent(student: data);}));
                            }, 
                          icon: Icon(Icons.edit,color: Colors.green,)
                          ),
                          IconButton(onPressed: (){deletebuttonclicked(data.id);}, icon: Icon(Icons.delete,color: Colors.red,)) 
                          ],
                          ),
                        )
                      ),
                      SizedBox(height: 5 ,), 
                      ListTile(
                      title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                      Text('Name:${data.name}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                      Text('Age:${data.age}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                      Text('Address:${data.address}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                      Text('Mobile:+91 ${data.mobile}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),                       
                      ],
                    ),
                      )
                    ],
                  ),
                );
              }
            ),
          );


        }
      ),
    );
  }


  Future<void> deletebuttonclicked(id) async{ 
    showDialog(
      context: context, 
      builder: (ctx){
        return AlertDialog(
          content: Text('Do You Want To Delete Details?'), 
          actions: [
            TextButton(
              onPressed: (){
                deleteStudent(id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor:  Color.fromARGB(255, 241, 19, 19),
                    margin: const EdgeInsets.all(50),
                    content: Text(
                      'Student Details Deleted',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black), 
                    ),
                  ),
                );                
              }, 
              child: Text('YES'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('NO')
            )
          ],
        );
      }
    );
  }

}

