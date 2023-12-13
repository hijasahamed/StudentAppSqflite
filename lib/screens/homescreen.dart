 

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_app/db/function/db_function.dart';
import 'package:student_app/db/model/db_model.dart';

import 'package:student_app/screens/addstudent.dart';
import 'package:student_app/screens/details.dart';

import 'package:student_app/screens/liststudent.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});


  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [           
            PopupMenuButton(
              elevation: 20,
              shadowColor: Colors.grey,
              iconSize: 35,
              icon: Icon(Icons.list),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.person_search,color: Colors.green,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Students')
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.star,color: Color.fromARGB(255, 247, 223, 3),),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Get The App')
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.chrome_reader_mode,color: Colors.blue,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('About')
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings,color: Colors.grey,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Settings')
                    ],
                  ),
                ),
              ]
            ),
            Text('STUDENTS APP', style: TextStyle(fontWeight: FontWeight.w900),),
            IconButton(onPressed: () {
              showSearch(
                      context: context,
                      delegate: search(),
                    );
            }, icon: Icon(Icons.search)),
          ],
        ),
      ),


      
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              child: Image(image: AssetImage('images/donbosco.png')),
            ),
          ), 

          SizedBox(height:5 ), 

          Flexible(
            flex: 13,
            child: Container(  
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),            
              child: ListStudent(),
            ),
          ),

          SizedBox(height: 5), 

          Flexible(
            flex: 1,              
              child: Container(               
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return AddStudent();
                        }));
                      },
                      child: Text('+  Add Student'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 11, 11),
                        minimumSize: Size(120,40 )
                      ),
                    ),
                ),
              )
            ),
            
        ],
      ),
    );
  }

}



class search extends SearchDelegate {
  List data = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentlistNotifier,
        builder: (BuildContext context, List<Studentmodel> studentlist,
            Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentlist[index];
              String nameval = data.name;
              if ((nameval).contains(query)) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return 
                           Details(
                            studentdetails: data,
                          );
                        }));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: studentlist.length,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentlistNotifier,
        builder: (BuildContext context, List<Studentmodel> studentlist,
            Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentlist[index];
              String nameval = data.name;
              if ((nameval).contains((query.trim()))) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Details(
                            studentdetails: data,
                          );
                        }));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                print('no result');
              }
              return null;
            },
            itemCount: studentlist.length,
          );
        });
  }
}
