class ProfileModel{
   String? name;
   String? phone;
   var Id;

  ProfileModel({ this.name,  this.phone,this.Id});

  Map<String, dynamic> toMap() {
    return {
      'id' : Id,
      'name': name,
      'email': phone,
    };
  }
}