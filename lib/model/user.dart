class User{
 late String name;
  dynamic key;
  User.fromJson(Map<String, dynamic> json){
    key=json['id'];
  }
}