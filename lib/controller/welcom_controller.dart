import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro2/screens/ranking.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/history.dart';
import '../screens/home.dart';
import '../screens/rewards.dart';
import '../screens/welcome.dart';
import 'firebase_controller.dart';


class WelcomeController extends GetxController {
  final fireBaseController = Get.put(FirebaseController());
  var UserKey =''.obs;
  var UseName =''.obs;

  var isLoggedIn = false.obs;
  var currentIndex = 0.obs;
  var screens = [
    HomeScreen(),
    RewardsScreen(),
    RankScreen(),
    HistoryScreen()
  ];
  @override
  void onInit() async {
    redirect();
    super.onInit();
  }
  Future<void> redirect() async {
    var user_name = await GetStorage().read('user_name');
    var userkey=await GetStorage().read('user_id');


    if (user_name != null) {
      UseName.value= user_name;
      UserKey.value=userkey;
      await fireBaseController.getUserData(userkey);
      print(UserKey);

      isLoggedIn.value =true;
      Get.off(() => WelcomeScreen());

    }

  }
  Future<void> register({required String user_name}) async {
    var now = DateTime.now();
    String s =DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    print(s);
   await GetStorage().write('user_name', user_name);
    String userkey= await fireBaseController.addUser('0','0',user_name);
    await GetStorage().write('user_id',userkey);
   // await fireBaseController.addSteps('80',userkey);
    isLoggedIn.value = true;
    Get.offAll(() => WelcomeScreen());
  }
} //end of controller
