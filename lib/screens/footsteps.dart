import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/step_point_controller.dart';
import '../widgets/primary_button.dart';

class FootSteps extends StatefulWidget {
  FootSteps({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _FootStepsState createState() => _FootStepsState();
}

class _FootStepsState extends State<FootSteps> {
  final footstepsController = Get.put(StepPointController());

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'stopped';
  String _toggleButtonText = 'Start';
  int _stepCnt = 0;
  String permissionStatus = 'PERMISSION DENIED';

  List<Widget> renderPedometerElements() {
    List<Widget> pedometerElements;
    if (_toggleButtonText == 'Stop') {
      pedometerElements = [
        Text(
          'Steps taken:'.tr,
          style: TextStyle(fontSize: 20),
        ),

             Text(
              footstepsController.step_points.value.toString(),
              style: TextStyle(fontSize: 20),
            ),
        Divider(
          height: 10,
          thickness: 0,
          color: Colors.white,
        ),
        Text(
          'Pedestrian status:'.tr,
          style: TextStyle(fontSize: 16),
        ),
        Icon(
          _status == 'walking'
              ? Icons.directions_walk
              : _status == 'stopped'.tr
                  ? Icons.accessibility_new
                  : Icons.error,
          size: 100,
        ),
        Center(
          child: Text(
            _status,
            style: _status == 'walking' || _status == 'stopped'
                ? TextStyle(fontSize: 16)
                : TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
      ];
    } else {
      pedometerElements = [];
    }
    return pedometerElements;
  }

  void _togglePedometer() async {
    setState(() {
      if (_toggleButtonText == 'Start') {
        _toggleButtonText = 'Stop';
        _stepCnt = 0;
      } else {
        _toggleButtonText = 'Start';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPermissions();
    initPlatformState();
  }

  void getPermissions() async {
    print('CHECKING FOR PERMISSIONS...');
    if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    }
    var status = await Permission.activityRecognition.status;
    if (status.isDenied) {
      setState(() {
        permissionStatus = 'PERMISSION DENIED';
      });
    }

    if (await Permission.activityRecognition.request().isGranted) {
      initPlatformState();

      setState(() {
        permissionStatus = 'GRANTED';
      });
      print(permissionStatus);
    }

    // // You can can also directly ask the permission about its status.
    // if (await Permission.activityRecognition.isRestricted) {
    //   print('PERMISSION RESTRICTED!!!');
    // }
  }

  void onStepCount(StepCount event) async {
    // print(event);
    print('STEP COUNT EVENT: ${event.steps.toString()}');

    setState(() {
      _stepCnt += 1;
      footstepsController.step_points.value =footstepsController.step_points.value + _stepCnt;
    });
    footstepsController.stepsUpdade();

  }

  void onPedestrianStatusChanged(PedestrianStatus event) async {
    // print(event);
    print('STATUS CHANGED EVENT: ${event.status}');
    setState(() {
      _status = event.status;
      // print(_status);
      // print(_toggleButtonText);
    });
  }

  void onPedestrianStatusError(error) async {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) async {
    print('onStepCountError: $error');
    setState(() {
      _stepCnt = -1;
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
            child: permissionStatus == 'GRANTED'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PrimaryButton(
                              label: _toggleButtonText,
                              onPress: _togglePedometer),
                        ),_toggleButtonText == 'Stop'?
                      Obx(()=>Column(children: renderPedometerElements(),)):Container()
                     , ])
                : Center(
                    child: Text(
                      'SENSOR PERMISSION DENIED',
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ));
  }
}
