import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro2/model/exchange.dart';
import 'package:pro2/model/redemption.dart';

class FirebaseController extends GetxController {
  late final CollectionReference  userRef,exchangesRef,redemptionRef ;

 // List<Exchange> exchangesList =<Exchange>[].obs;
 // List<Redemption> redemptionList =<Redemption>[].obs;
  List exchangesList=[].obs;
  List redemptionList=[].obs;
  List useDataList=[].obs;
  List usersList=[].obs;

  late DocumentReference df;
  @override
  void onInit() async {
    userRef = await FirebaseFirestore.instance.collection('users');
    exchangesRef = await FirebaseFirestore.instance.collection('exchanges');
    redemptionRef = await FirebaseFirestore.instance.collection('redemption');

  }

  //CollectionReference stepRef =FirebaseFirestore.instance.collection('foot_steps');

  Future<String> addUser(String stepPoint,String healthpoint,String name) async{

  df= await userRef.add({"step":stepPoint,"healthpoint":healthpoint,"name":name});
  return df.id;

  }
  editUserData(String stepPoint,String healthpoint,String userKey) async{

    await userRef.doc(userKey).update({"step":stepPoint,"healthpoint":healthpoint});

  }
  addExchange(String userKey,String healthPoint,String e_date) async{

    await exchangesRef.add({"u_key":userKey,"helthPoint":healthPoint,"e_date":e_date});

  }
  addRedemption(String userKey,String healthPoint,String reward ,String r_date) async{

    await redemptionRef.add({"u_key":userKey,"healthPoint":healthPoint,"reward":reward,"r_date":r_date});

  }
  getExchangesData() async{
    var userkey=await GetStorage().read('user_id');

    exchangesList.clear();
  var responseBody=  await exchangesRef.where("u_key",isEqualTo:userkey ).get();
  responseBody.docs.forEach((element) {
    exchangesList.add(element.data());
  });

  }
  getallusers() async{
    usersList.clear();
    var responseBody=  await userRef.get();
    responseBody.docs.forEach((element) {
      usersList.add(element.data());
    });

  }
  getRedemptionData() async{
    var userkey=await GetStorage().read('user_id');
    redemptionList.clear();
    var responseBody=  await redemptionRef.where("u_key",isEqualTo:userkey ).get();
    responseBody.docs.forEach((element) {
      redemptionList.add(element.data());
    });

  }
  getHealthPointUser() async{
    redemptionList.clear();
    var responseBody=  await redemptionRef.get();
    responseBody.docs.forEach((element) {
      redemptionList.add(element.data());
    });

  }
  getUserData(String key) async{
    useDataList.clear();
    var responseBody=  await userRef.doc(key).get();
    print(responseBody.data());
    useDataList.add(responseBody.data());
    print(useDataList[0]['name']);
   await GetStorage().write('step',useDataList[0]['step']);
    await GetStorage().write('point',useDataList[0]['healthpoint']);

    /**responseBody.doc(key).forEach((element) {
      print(element.data());
      useDataList.add(element.data());
    });**/

  }
  }


