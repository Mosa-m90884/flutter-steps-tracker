import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro2/model/reward.dart';
import 'package:pro2/screens/ranking.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/history.dart';
import '../screens/home.dart';
import '../screens/rewards.dart';
import '../screens/welcome.dart';
import 'firebase_controller.dart';


class StepPointController extends GetxController {
  final fireBaseController = Get.put(FirebaseController());
  String user_name='';
  String userkey='';
  var now = DateTime.now();
  var step_points =0.obs;
  var health_point =0.obs;
  var status = ''.obs;
  var toggleButtonText = ''.obs;
  var permissionStatus = ''.obs;
  @override
  void onInit () async{
    user_name = await GetStorage().read('user_name');
    print('mbnmb');
    userkey=await GetStorage().read('user_id');
     status.value = 'stopped';
     toggleButtonText.value = 'Start';
     permissionStatus.value = 'PERMISSION DENIED';
    var step=await GetStorage().read('step');
    String point=await GetStorage().read('point');

    if(step !=null){
      step_points.value =int.parse(step);
    }else{step_points .value=0;}
    if(point !=null){
      health_point.value =int.parse(point);
    }
  }

  Future<void> stepsUpdade() async{
 print(userkey);
    await GetStorage().write('step',step_points.value.toString());
    fireBaseController.editUserData(step_points.value.toString(),health_point.value.toString(), userkey);
}
  Future<void> replaceToHealthPoint(int value) async{
    String e_date =DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    if (value>2){
      step_points.value=  step_points.value -2;
      health_point.value++;
      fireBaseController.addExchange(userkey, health_point.value.toString(), e_date);
      stepsUpdade();
      healthPointUpdate();
    }

  }
  Future<void> healthPointUpdate() async{
    await GetStorage().write('point',health_point.value.toString());

  }
  Future<void> replaceToReward(Reward reward) async{
    String r_date =DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    if (reward.price>health_point.value){

    }else{
      health_point.value = health_point.value-reward.price;
      fireBaseController.addRedemption(userkey, health_point.value.toString(), reward.name, r_date);
      healthPointUpdate();
      stepsUpdade();
    }
    }
}