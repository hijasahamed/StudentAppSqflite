
class Studentmodel {

   int? id;

  final String name;

  final String age;

  final String address;


  final String mobile;


  final String image;

  Studentmodel(
      {required this.name,
      required this.age,
      required this.address,
      required this.mobile,
      required this.image,
      this.id
      }
    ); 

  static Studentmodel fromMap(Map<String, Object?> map) {
    final id= map['id'] as int;
    final name= map['name'] as String;
    final age= map['age'] as String;
    final address= map['address'] as String;
    final mobile= map['mobile'] as String;
    final image=map['image'] as String;

    return Studentmodel(id: id, name: name, age: age, address: address, mobile: mobile, image: image);
  }
}