//  addRedemption(String userKey,String healthPoint,String reward ,String r_date) async{
class Redemption{
  String? userKey ,healthPoint,reward,r_date;

  Redemption(this.userKey, this.healthPoint,this.reward, this.r_date);
  Redemption.fromJson(Map<String, dynamic> json) {
    userKey =json['userKey'];
    healthPoint=json['healthPoint'];
    healthPoint=json['healthPoint'];
    reward =json['reward'];
    r_date=json['r_date'];

  }

}