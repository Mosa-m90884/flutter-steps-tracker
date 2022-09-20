//addExchange(String userKey,String healthPoint,String e_date) async{
class Exchange{
  String? userKey ,healthPoint, e_date;

  Exchange(this.userKey, this.healthPoint, this.e_date);
  Exchange.fromJson(Map<String, dynamic> json) {
    userKey =json['userKey'];
    healthPoint=json['healthPoint'];
    e_date=json['e_date'];

  }

}