import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel{
   String? name;
   String? phone;
   var profilePic;
   var id;
  ProfileModel({ this.name,  this.phone,this.profilePic,this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'profilePic' : profilePic,
      'id': id,

    };
  }

   factory ProfileModel.fromjson(Map<String, dynamic> json) {
     return ProfileModel(
         phone: json['phone'],
       name: json['name'],
       profilePic: json['profilePic'],
       id: json['id']
     );
   }
}




class ProfileModelForChat{
  String? name;
  String? phone;
  var profilePic;
  var id;
  ProfileModelForChat({ this.name,  this.phone,this.profilePic,this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'profilePic' : profilePic,
      'id': id,

    };
  }

  ProfileModelForChat.fromDocumentSnapshot(DocumentSnapshot<Map<String,dynamic>>  json):
        phone = json['phone'],
        name = json['name'],
        profilePic = json['profilePic'],
        id = json['id'];

//  {
//   return ProfileModel(
//       phone: json['phone'],
//     name: json['name'],
//     profilePic: json['profilePic'],
//     id: json['id']
//   );
// }
}